# Section 14: Validations

##### Adding validations - restaurant uniqueness

We also don't want to allow users to create the same restaurant twice. So, let's write a test in our restaurant model spec!

```ruby
it "is not valid unless it has a unique name" do
  Restaurant.create(name: "Moe's Tavern")
  restaurant = Restaurant.new(name: "Moe's Tavern")
  expect(restaurant).to have(1).error_on(:name)
end
```

This test fails because we haven't implemented a validation on uniqueness yet. Fix it by updating this line in your restaurant model as follows:

```ruby
validates :name, length: { minimum: 3 }, uniqueness: true
```

(RailsGuides has lots of information on the [different validations](http://guides.rubyonrails.org/active_record_validations.html) that are available to you.)

##### Adding validations – reviews

Lets also make sure that the rating cannot be more than 5. Add a `review_spec.rb` model test – this should go in `spec/models`.

```ruby
require 'rails_helper'

describe Review, type: :model do
  it "is invalid if the rating is more than 5" do
    review = Review.new(rating: 10)
    expect(review).to have(1).error_on(:rating)
  end
end
```

Your test will fail because our review model doesn't stop someone from submitting a rating greater than 5. So in `app/models/review.rb`, add:

```ruby
validates :rating, inclusion: (1..5)
```

Your tests should now all be passing. High Five!!!!!

### Version 1 Complete!

#### Related Videos:

* [Rails](https://www.youtube.com/watch?v=iOJUBnC0imE)
* [Rails Cont](https://www.youtube.com/watch?v=Tm7kjJBDa-8)

### [Next Section - Authentication with Devise](../yelp_v2/1_installing_devise.md)
