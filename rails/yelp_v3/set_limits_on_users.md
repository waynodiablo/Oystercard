#### Setting limits on users

Now we want to set limits on what site visitors can do. From our [specification](yelp.md#v3-specification):

* A user must be logged in to create restaurants
* Users can only edit/delete restaurants **which they've created**
* Users can only leave **one review per restaurant**
* Users can delete their own reviews

Let's tackle these one by one. Remember to always write tests first, commit often to git and swap driver/navigator roles frequently&nbsp;:twisted_rightwards_arrows:.


##### A user must be logged in to create restaurants

In `restaurants_controller.rb`, we can add a `before_action` at the top of the controller that checks to see if a user is logged in before the action runs. See if you can write a test first before adding the code below. You'll also need to update some of your other feature specs as this breaks those as well.

```ruby
before_action :authenticate_user!, :except => [:index, :show]
```

As you can guess, this will apply to all of the methods in the controller except for `index` and `show`, so guests will still be able to see the list of restaurants and the individual restaurant pages.

Now try adding tests/code for the following scenarios:  (Before attempting this, we strongly recommend you read up on [Active Record Associations](http://guides.rubyonrails.org/association_basics.html)).  To see how this relates to the following features, read [this pill](reviewed_restaurants.md)

* **Users can only edit/delete restaurants which they've created**
* **Users can only leave one review per restaurant**
* **Users can delete only their own reviews**
