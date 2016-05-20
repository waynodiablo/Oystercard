# Section 3: Extending Active Record Associations

Your `build_review` method should now look something like this:

```
def build_review(attributes = {}, user)
  review = reviews.build(attributes)
  review.user = user
  review
end
```
or perhaps:

```
def build_review(attributes = {}, user)
  attributes[:user] ||= user
  reviews.build(attributes)
end
```

However, this approach is subtly naive.  Active Record has already provided a number of creation methods via the `reviews` association; i.e. enabling the following from the controller:
```
restaurants.reviews.create(review_params)
restaurants.reviews.create!(review_params)
restaurants.reviews.build(review_params)
```
But our new method `build_review` sits outside of this and there are no equivalents for the `create` methods.  So why have a `build_review` method at all?

Our goal is to keep the controller _thin_ by moving as much business logic as possible into the model.  In this case, we are trying to reduce one or other of the following approaches into just one call from the controller:
```
review = reviews.build(review_params)
review.user = current_user
```
or:
```
review_params[:user] ||= current_user
reviews.build(review_params)
```

What we really want is something more consistent like this:
```
restaurants.reviews.build_with_user(review_params, current_user)
```
But how can we introduce our own method `build_with_user` into the Active Record association `reviews`?

Let's write a test first in `restaurant_spec.rb`:
```
describe 'reviews' do
  describe 'build_with_user' do

    let(:user) { User.create email: 'test@test.com' }
    let(:restaurant) { Restaurant.create name: 'Test' }
    let(:review_params) { {rating: 5, thoughts: 'yum'} }

    subject(:review) { restaurant.reviews.build_with_user(review_params, user) }

    it 'builds a review' do
      expect(review).to be_a Review
    end

    it 'builds a review associated with the specified user' do
      expect(review.user).to eq user
    end
  end
end
```

Fortunately, Active Record has some advanced features which enable you to do exactly this by _extending_ association proxies.

In `Restaurant`, try the following:
```
has_many :reviews do
  def build_with_user(attributes = {}, user)
    attributes[:user] ||= user
    build(attributes)
  end
end
```
Does this pass our new test?  Can you spot a problem?

This approach doesn't quite fulfil all of our needs.  While I have my `build_with_user` method, what about `create_with_user` or `create_with_user!` versions?  Adding these to the block is going to start making this association declaration unwieldy.  Plus, as our application grows, creating associations with the current user might be something we want to do elsewhere.  Could we reuse this somehow?

Actually, yes we can.  Instead of extending the association inline as we have above, we can extend it using a module.  Create the following in the `app/models` folder:
`with_user_association_extension.rb`:
```
module WithUserAssociationExtension
  def create_with_user(attributes = {}, user)
   attributes[:user] ||= user
   create(attributes)
  end

  def create_with_user!(attributes = {}, user)
    attributes[:user] ||= user
    create!(attributes)
  end

  def build_with_user(attributes = {}, user)
    attributes[:user] ||= user
    build(attributes)
  end
end
```
Now, in `Restaurant`, replace the association declaration with the following:
```
has_many :reviews,
      -> { extending WithUserAssociationExtension },
      dependent: :destroy
```

Not only should this pass all our tests, we can use this extension module to extend _any_ association where we want to pass the user alongside the model attributes.  And that's pretty cool.

For more information on extending Active Record associations, see the [Rails Guides](http://guides.rubyonrails.org/association_basics.html#association-extensions).


* **Users can only edit/delete restaurants which they've created**
* **Users can delete only their own reviews**

### Version 3 Complete! - End of Tutorial!

Congratulations on reaching the end. However, if you are sad that you have run out of Yelp - fear not! We have put together some additional tasks which you may be interested in.

# [Bonus Stage 1: Average Ratings](../yelp_further_challenges/1_average_ratings.md)
