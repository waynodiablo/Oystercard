Helpers
=======

* in reviews feature spec let's do an average ratings spec:

```ruby

describe 'average ratings' do
  before {Restaurant.create name: 'KFC', cuisine: 'Chicken'}

  it 'calculates and displays the avg rating' do
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in 'Thoughts', with: 'Not great'
    select '2', from 'Rating'
    click_button 'Create Review'

    visit '/restaurants'
    click_link 'Review KFC'
    fill_in 'Thoughts', with: 'Great'
    select '4', from 'Rating'
    click_button 'Create Review'

    expect(page).to have_content 'Average rating: 3'
  end

end
```

* this is a little unDRY, so lets create an additional method to DRY this out


```ruby
def leave_review(thoughts, rating)
  visit '/restaurants'
  click_link 'Review KFC'
  fill_in 'Thoughts', with: thoughts
  select rating, from 'Rating'
  click_button 'Create Review'
end
```

* our spec can now be DRYed out using the above method, e.g. 

```ruby
describe 'average ratings' do
  before {Restaurant.create name: 'KFC', cuisine: 'Chicken'}

  it 'calculates and displays the avg rating' do
    leave_review('Poor', 2)
    leave_review('Great', 4)

    expect(page).to have_content 'Average rating: 3'
  end
end
```

* this test should now fail since we won't see the average rating yet

* Note that feature tests by their nature are somewhat slow, and so we want to avoid writing a feature test for every aspect of something like an average rating calculation where we should also test various corner cases, such as when there are no reviews etc.

* let's write a fast running unit test to check some of these situations in our spec/models/restaurant_spec.rb file

```ruby
require 'rails_helper'

RSpec.describe Restaurant, :type => :model do
  describe '#average_rating' do
    let(:kfc){Restaurant.create name: 'KFC', cuisine: 'Chicken'}
  
    it 'returns N/A if there are no reviews' do
      expect(kfc.average_rating).to eq 'N/A'
    end
  end
end
```

* and let's watch this test fail (hopefully for the right reason)

* Now we can make this test pass in the simplest fashion possible, which is important to ensure we are working from a stable base

```ruby
class Restaurant < ActiveRecord::Base
  has_many :reviews

  def average_rating
    'N/A'
  end
end
```

* this test should now pass, and we can follow up with a test of the next simplest situation

```ruby

  context 'with 1 review' do
    it 'returns the rating of that review' do
      kfc.reviews.create(rating: 3)
      expect(kfc.average_rating).to eq 3
    end 
  end
```

* and let's watch this fail.

* to make this pass we'll need to adjust our Restaurant model

```ruby
class Restaurant < ActiveRecord::Base
  has_many :reviews

  def average_rating
    return 'N/A' if reviews.none?
    reviews.inject(0) { |sum,review| sum + review.rating}
  end 
end
```

* test should now pass, however we are calculating the sum rather than the average, so let's add another test that exposes that problem

```ruby
  context 'with multiple reviews' do
    it 'returns the average of those reviews' do
      kfc.reviews.create(rating: 2)
      kfc.reviews.create(rating: 4)
      expect(kfc.average_rating).to eq 3
    end 
  end
```

* so this should fail and we can fix this as follows:

```ruby
class Restaurant < ActiveRecord::Base
  has_many :reviews

  def average_rating
    return 'N/A' if reviews.none?
    reviews.inject(0) { |sum,review| sum + review.rating} / reviews.count
  end 
end
```

* we also need to check for cases where the average review is not a whole number

```ruby
  context 'average review is not a whole number' do
    it 'returns the average as a float' do
      kfc.reviews.create(rating: 2)
      kfc.reviews.create(rating: 3)
      expect(kfc.average_rating).to eq 2.5
    end 
  end
```

* this will fail, and we can fix as follows:

```ruby
class Restaurant < ActiveRecord::Base
  has_many :reviews

  def average_rating
    return 'N/A' if reviews.none?
    reviews.inject(0) { |sum,review| sum + review.rating} / reviews.count.to_f
  end 
end
```

* the test should now pass, and we have 4 fast running unit tests, and have avoided creating multiple slow feature tests which would slow down our development process

* a possible refactoring is 

```ruby
class Restaurant < ActiveRecord::Base
  has_many :reviews

  def average_rating
    return 'N/A' if reviews.none?
    reviews.average(:rating)
  end 
end
```

* last thing we need is to have our new method be displayed in the view, e.g. app/views/restaurants/index.html.erb

```html
Average rating: <%= restaurant.average_rating%>
```

* and now our feature spec should pass as well

It would also be nice to have a graphic to represent the average rating, perhaps with some unicode stars.

* Let's update our reviews_feature_spec.rb to do that:


```ruby
describe 'average ratings' do
  before {Restaurant.create name: 'KFC', cuisine: 'Chicken'}

  it 'calculates and displays the avg rating' do
    leave_review('Poor', 2)
    leave_review('Great', 4)

    expect(page).to have_content 'Average rating: ★★★☆☆'
  end
end
```

* we might be tempted to implement this in our Restaurant model, but this is not best practise since we would be mixing up our business logic with our presentation logic, so another place we can put these is in our app/helpers/reviews_helper.rb


```ruby
module ReviewsHelper
  def star_rating(rating)
  end
end
```

* and we can start unit testing this in our spec/helpers/review_helpers_spec.rb

```ruby
RSpec.describe ReviewsHelper, :type => :helper do
  describe '#star_rating' do
    context 'not a number' do
      it 'returns the input unchanged' do
        expect(star_rating('N/A')).to eq 'N/A'
      end
    end
  end
end
```

* ensure we get the expected failure and fix in the following fashion:

```ruby
module ReviewsHelper
  def star_rating(rating)
    rating
  end
end
```

* now let's create a more demanding test

```ruby
    context 'rating of 5' do
      it 'returns 5 black stars' do
        expect(star_rating(5)).to eq '★★★★★'
      end
    end 
```

* check this fails

* let's make this pass in the simplest fashion possible

```ruby
module ReviewsHelper
  def star_rating(rating)
    '★' * rating
  end
end
```

* however this causes the earlier test to fail which we could now fix like so:

```ruby
module ReviewsHelper
  def star_rating(rating)
    return rating if rating == 'N/A'
    '★' * rating
  end
end
```

* however this hard codes a dependency on the string 'N/A' which is a bit brittle, and a better alternative would be to ensure that all strings are simply returned

```ruby
module ReviewsHelper
  def star_rating(rating)
    return rating if rating.is_a?(String)
    '★' * rating
  end
end
```

* but explicit type checking in ruby is generally frowned upon, and instead we should prefer duck typing, but let's first write some more tests


```ruby
    context 'rating of < 5' do
      it 'returns n black stars, for rating n, plus remainder white' do
        expect(star_rating(3)).to eq '★★★☆☆'
      end
    end 
```

* which will fail 
* we can then fix that as follows

```ruby
module ReviewsHelper
  def star_rating(rating)
    return rating if rating.is_a?(String)
    remainder = (5 - rating)
    ('★' * rating) + ('☆' * remainder)
  end
end
```

* final test we need is to consider how stars are displayed for non-whole number rating

```ruby
    context 'non-whole number rating' do
      it 'rounds up to the nearest star' do
        expect(star_rating(2.5)).to eq '★★★☆☆'
      end
    end 
```

* this test should fail and we can fix as follows


```ruby
module ReviewsHelper
  def star_rating(rating)
    return rating if rating.is_a?(String)
    rounded_rating = rating.round
    remainder = (5 - rounded_rating)
    ('★' * rounded_rating) + ('☆' * remainder)
  end
end
```

* let's now go back to the idea of duck typing, and refactor to check if rating responds to round, which is more ruby-ish in that we are now allowing the method to work with anything that responds to the round method, rather than being restricted to a particular class of objects

```ruby
module ReviewsHelper
  def star_rating(rating)
    return rating if rating.respond_to?(:round)
    rounded_rating = rating.round
    remainder = (5 - rounded_rating)
    ('★' * rounded_rating) + ('☆' * remainder)
  end
end
```

* finally we can use our star_rating method in our view

```html
Average rating: <%= star_rating restaurant.average_rating%>
```

* and we should see star ratings in the live site

All unit tests and feature tests should now pass, and this approach is very common, to jump between high level and low level tests.  We want to avoid too many slow running high level feature tests, and we respond to any situation where we find ourselves writing a series of repetitive feature tests we should consider switching to unit tests.  We can't work completely in unit-tests for everything as we do need to at least occasionally test that everything is working together correctly which invidiual unit tests cannot do.








