| [← Yelp V2](yelpv2.md) | [Yelp home](yelp.md) | Yelp V3 |
|------------------------|----------------------|--------:|

# Yelp

### V3 Walkthrough

In this version of our app, we want to tidy up the UX (user experience). It would be nice if our restaurants showed their average rating. It would also be cool if the page didn't refresh when we clicked on a link but updated dynamically.

Let's see what we can do.

#### Average ratings

We want our restaurants to show their average rating. Test!

##### Feature and unit tests

To `review_feature_spec.rb`, add the below. Here, we've extracted out the leaving review method.

```ruby
def leave_review(thoughts, rating)
  visit '/restaurants'
  click_link 'Review KFC'
  fill_in "Thoughts", with: thoughts
  select rating, from: 'Rating'
  click_button 'Leave Review'
end

it 'displays an average rating for all reviews' do
  leave_review('So so', "3")
  leave_review('Great', "5")
  expect(page).to have_content("Average: 4")
end
```

Now, in our `restaurant_spec.rb`, we add a unit test:

```ruby
...
describe '#average_rating' do
  context 'no reviews' do
    it 'returns "N/A" when there are no reviews' do
      restaurant = Restaurant.create(name: "The Ivy")
      expect(restaruant.average_rating).to eq 'N/A'
    end
  end
end
...
```

##### Making an `average_rating` helper

To make the test pass, we need to update our restaurant model.

`app/models/restaurant.rb`:

```ruby
def average_rating
  'N/A'
end
```

This passes the test so far, but obviously isn't very useful. Now we need a test in the case of having one review, and then one for when it has two or more reviews.

`restaurant_spec.rb`:

```ruby
...
context '1 review' do
  it 'returns that rating' do
    restaurant = Restaurant.create(name: "The Ivy")
    restaurant.reviews.create(rating: 4)
    expect(restaurant.average_rating).to eq 4
  end
end
...
```

Let's update our `average_rating` method.

`app/models/restaurant.rb`:

```ruby
def average_rating
  return 'N/A' if reviews.none?
  reviews.inject(0) {|memo, review| memo + review.rating}
end
```

And now for multiple reviews...

`restaurant_spec.rb`:

```ruby
...
context 'multiple reviews' do
  it 'returns the average' do
    restaurant = Restaurant.create(name: "The Ivy")
    restaurant.reviews.create(rating: 1)
    restaurant.reviews.create(rating: 5)
    expect(restaurant.average_rating).to eq 3
  end
end
...
```

And update our `average_rating` method...

`app/models/restaurant.rb`:

```ruby
def average_rating
  return 'N/A' if reviews.none?
  reviews.inject(0) {|memo, review| memo + review.rating} / reviews.count
end
```

(Note that without using `.to_f` to convert integers to floats, you would find you would only ever have whole number averages.)

**BUT!** Rails has a built-in helper method for this. You could instead just do this:

```ruby
reviews.average(:rating)
```

Easy.

##### Displaying the average rating

Now, add some code to the index page to display this average beside each restaurant.

```erb
...
<h3>Average rating: <%= restaurant.average_rating.to_i %></h3>
...
```

##### Stars make things pretty

But we can do better than that. Yelp uses star ratings which are a nice way of showing a restaurant's rating. We can do something similar just by using the Unicode 'star' characters.

Specifically, we can use these two glyphs:

> BLACK STAR (U+2605)
> ★
  
> WHITE STAR (U+2606)
> ☆

Let's change the feature spec to expect that output.

```ruby
it "displays an average rating for all reviews" do
  leave_review("so so", "3")
  leave_review("Great!", "5")
  expect(page).to have_content("Average rating: ★★★★☆")
end
```

And now let's make sure the page uses the UTF-8 character set, otherwise those Unicode stars won't render properly.

Somewhere in the layout `head` section you'll need to have this `meta` tag:

```erb
<meta charset="UTF-8">
```

##### DIY helper methods

Now we can create our own helper method that we can call to generate a star rating from a numerical rating.

First we'll make a test for it - throw together a `helpers` folder in the spec
folder, and write a new test in a new file called `reviews_helper_spec.rb`.

```ruby
require 'rails-helper'

describe ReviewsHelper, :type => :helper do
  context "#star_rating" do
    it "does nothing for not a number" do
      expect(helper.star_rating('N/A')).to eq "N/A"
    end
  end
end
```

Time to write that helper method. Rails has auto-generated some placeholder files that we can open up and edit.

`app/helpers/reviews_helper.rb`:

```ruby
module ReviewsHelper
  def star_rating(rating)
    rating
  end
end
```

Our test passes. Refine with a new test:

```ruby
it "returns five black stars for five" do
  expect(helper.star_rating(5)). to eq '★★★★★'
end
```

Which needs an updated method to pass.

```ruby
module ReviewsHelper
  def star_rating(rating)
    return rating unless rating.is_a?(Fixnum)
    "★" * rating
  end
end
```

And it's time for another test:

```ruby
it "returns three black stars and two white stars for three" do
  expect(helper.star_rating(5)). to eq '★★★☆☆'
end
```

So we need to work out the remainder to put on the end as white stars:

```ruby
module ReviewsHelper
  def star_rating(rating)
    return rating unless rating.is_a?(Fixnum)
    remainder = (5 - rating)
    "★" * rating + "☆" * remainder
  end
end
```

And the final test:

```ruby
it "returns three black stars and two white stars for 3.5" do
  expect(helper.star_rating(3.5)). to eq '★★★☆☆'
end
```

Alas - we'll get "3.5" back as 3.5 is a Float, not a Fixnum. Let's do a bit of duck typing rather than strict typing to identify the input as valid - does it respond to `round`? We can round the review to make sure we get an integer back (rather than using half stars).

```ruby
module ReviewsHelper
  def star_rating(rating)
    return rating unless rating.respond_to?(:round)
    remainder = (5 - rating)
    "★" * rating.round + "☆" * remainder
  end
end
```

And that should pass those tests. So let's go back to our `index` to get the
feature test to pass.

```erb
...
<%= star_rating(restaurant.average_rating) %>
...
```

Done. We've made our own helper method – but there are lots of built-in helpers that are very useful. Have a look at :pill: [Helper methods](pills/helper_methods.md) to learn more – once you have, see if you can get the reviews to display when they were created relative to now (e.g. '5 hours ago').

#### Refactoring using partials

A good rule of thumb is that if you do something twice, you should consider refactoring. (If you're doing it three times, *definitely* refactor.)

We've used the same form for restaurants twice (in create and edit) – exactly the same code. This is unnecessary duplication, and it also makes life more difficult for us. If we updated our restaurants model – say we wanted it to include an address – then we have two forms to update. If we forgot to do that, things would break.

Much better would be to have the same form abstracted out, and *refer* to it twice. Rails makes this easy with [partials](http://guides.rubyonrails.org/layouts_and_rendering.html#using-partials).

Let's do that now. Create `app/views/restaurants/_form.html.erb` (the prepended '_' indicates this is a partial) and copy and paste the form there.

Now, in both places we refer to the form (`app/views/restaurants/edit.html.erb` and `app/views/restaurants/new.html.erb`), remove the form and type this line instead:

```erb
<%= render "form" %>
```

So much cleaner! Rails knows to refer to the `_form` file we just created and slot it into the layout when the page is rendered.