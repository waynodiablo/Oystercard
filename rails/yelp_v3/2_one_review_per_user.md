# Section 2: Users Can Only Leave One Review per Restaurant

The temptation is to start adding logic in the `ReviewsController` to test whether the current user has already reviewed the given restaurant.  **But this is bad**.  Why?

The controller's responsibility is to handle any logic relating to the request and response.  This includes authentication, authorization (at a request level), redirection and rendering.  As part of this, it is also responsible for loading up the models required by the view.  However, **it is not responsible for any other business logic**.

Business logic belongs in the model and "Users can only leave one review per restaurant" is very definitely business logic.

So how do we move this into the model?

The first thing to recognize is that a user has _two separate associations_ with restaurant:
1. A user creates a restaurant.
2. A user can review a restaurant.

We have already modelled the first in `Restaurant`:

```
belongs_to :user
```
and in user:
```
has_many :restaurants
```
But how does this relate to _reviewing_ restaurants?

The answer is it doesn't.

But we do already have this in `User`:
```
has_many :reviews
```
So we are part of the way there.  How do we use this to relate `User` to the restaurants they have reviewed?

What we have here is a _many-to-many_ relationship.  A user can review many restaurants and restaurants can be reviewed by many users.  Many-to-many relationships occur frequently, but they cannot be modeled directly.  There must always be a _joining model_.  In this case, the joining model has a context of its own and is obvious - it's `Review`; but sometimes this is not the case and a join model (and hence a _join table_) has to be created specifically to handle the relationship.

Anyway, let's make sure that all the necessary associations are in place (using shoulda to TDD of course):

`Restaurant`:
```
has_many :reviews
```
`Review`:
```
belongs_to :user
belongs_to :restaurant
```
`User`:
```
has_many :reviews
```

Now for the cool part.  Let's write the following test in `user_spec.rb`:
```
it { is_expected.to have_many :reviewed_restaurants}
```
There are no special tricks here - it's just the code I wish I had.  Now, how do we make this pass?

Let's try this (in `User`):
```
has_many :reviewed_restaurants
```
Did that work?

The problem is `reviewed_restaurants` is just a name I've made up.  ActiveRecord has no idea what it means or what it relates to.  What we are trying to say is 'create an association with `Restaurant`, joined through `reviews`, and call it `reviewed_restaurants`'.

Firstly, we haven't specified that it needs to join through the `reviews` association, so let's do that:

```
has_many :reviewed_restaurants, through: :reviews
```
Still not working?

ActiveRecord does not know what model to build the association with.  We've told it to use `reviews`, but we need also to specify which of `Review`'s associations to go through.  In another context, we might have declared:
```
has_many :restaurants, through: :reviews
```
and this would have worked as `reviews` has an association called `restaurant` and ActiveRecord just infers the association from this.  But we can't do that here because `User` already has an association called `restaurants`.  That's why we've called our new association `reviewed_restaurants`.  ActiveRecord cannot infer the association to use because `reviewed_restaurant` is not an association in `Review`.
So we have to declare it this way:
```
has_many :reviewed_restaurants, through: :reviews, source: :restaurant
```

Maybe time for a break to review all that again and have a look at [Active Record Associations](http://guides.rubyonrails.org/association_basics.html).


So now we have an association called `reviewed_restaurants` on `User`, we can use this to test whether a user has already reviewed a restaurant.  However, _we do not want the logic for this test to be in our controller_!  So let's encapsulate it in our `User` model:
```
def has_reviewed?(restaurant)
  reviewed_restaurants.include? restaurant
end
```
And in our controller, we could write this, which is quite satisfying:
```
if current_user.has_reviewed? @restaurant
  # some error handling goes here!
end
```
Plus, we could also pre-empt this by using `current_user.has_reviewed?(@restaurant)` to decide whether or not to render the Review button in the view...


However, I'm still not satisfied.  While we now have a clean way to potentially show or hide the Review button and a way for the controller to check that a user has reviewed a restaurant, it is still possible to create additional reviews for the same user and restaurant _directly through the models_.

To prevent this from happening, we need a validation.  Before we allow a `Review` to be saved, we need to validate that the user and restaurant combination is unique.

Ideally, we should TDD this, but shoulda currently doesn't support the following:
```
it { is_expected.to validate_uniqueness_of(:user).scoped_to(:restaurant) }
```

So until I've worked out a satisfactory way of doing this, let's put the following in `Review`:
```
validates :user, uniqueness: { scope: :restaurant, message: "has reviewed this restaurant already" }
```

Now in our controller, we don't need to check `current_user.has_reviewed?(@restaurant)` because the review validation takes care of it.  So we should have something like this in `ReviewsController`:
```
def create
  @restaurant = Restaurant.find review_params[:restaurant_id]
  @review = @restaurant.build_review review_params, current_user

  if @review.save
    redirect_to restaurants_path
  else
    if @review.errors[:user]
      # Note: if you have correctly disabled the review button where appropriate,
      # this should never happen...
      redirect_to restaurants_path, alert: 'You have already reviewed this restaurant'
    else
      # Why would we render new again?  What else could cause an error?
      render :new
    end
  end
end
```

What is `build_review` and what does it do? Try to build this method with your pair. A possible solution will be revealed in the next section.

Now you've seen how to move business logic into the model, have a look at your controllers and see where else you might do this.

Once you've created your own `build_review` method and have everything working, discuss the advantages and disadvantages of this approach.  Does it feel 'right'?  To explore an alternative (and smarter) approach, move onto Now move onto the next section to complete this feature.

### [Next Section - Extending Active Record Associations](3_extending_associations.md)
