# Active Record Associations and Encapsulating business logic in models

In [YelpV2](yelpv2.md), we are challenged with the following feature:

**Users can only leave one review per restaurant**

The temptation is to start adding logic in the `ReviewsController` to test whether the current user has already reviewed the given restaurant.  **But this is bad**.  Why?

The controller's responsibility is to handle any logic relating to the request and response.  This includes authentication, authorization (at a request level), redirection and rendering.  As part of this, it is also responsible for loading up the models required by the view.  However, **it is not responsible for any other business logic**.

Business logic belongs in the model and "Users can only leave one review per restaurant" is very definitely business logic.

So how do we move this into the model?

The first thing to recognize is that a user has _two separate associations_ with restaurant:
1. A user creates a restaurant.
2. A user can review a restaurant.

Whe have already modelled the first in `Restaurant`:

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
it { is_exepected.to have_many :reviewed_restaurants}
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
