# Section 1: Setting limits on Users

Now we want to set limits on what site visitors can do. From our [specification](../yelp_project_specification.md):

* A user must be logged in to create restaurants
* Users can only edit/delete restaurants **which they've created**
* Users can only leave **one review per restaurant**
* Users can delete their own reviews

### User Must Log in to Create Restaurants

In `restaurants_controller.rb`, we can add a `before_action` at the top of the controller that checks to see if a user is logged in before the action runs. See if you can write a test first before adding the code below. You'll also need to update some of your other feature specs as this breaks those as well.

```ruby
before_action :authenticate_user!, :except => [:index, :show]
```

As you can guess, this will apply to all of the methods in the controller except for `index` and `show`, so guests will still be able to see the list of restaurants and the individual restaurant pages.

### Users can only edit/delete restaurants which they've created

To complete this step, you will need to create associations between your models.

Install the [shoulda](https://rubygems.org/gems/shoulda/versions/3.5.0) gem to TDD these associations at the unit level, then make feature tests. When you've made these tests pass, it's time to move on.

### [Next Section - Users Can Only Leave One Review per Restaurant](2_one_review_per_user.md)
