##### A user must be logged in to create restaurants

In `restaurants_controller.rb`, we can add a `before_action` at the top of the controller that checks to see if a user is logged in before the action runs. See if you can write a test first before adding the code below. You'll also need to update some of your other feature specs as this breaks those as well.

```ruby
before_action :authenticate_user!, :except => [:index, :show]
```

As you can guess, this will apply to all of the methods in the controller except for `index` and `show`, so guests will still be able to see the list of restaurants and the individual restaurant pages.
