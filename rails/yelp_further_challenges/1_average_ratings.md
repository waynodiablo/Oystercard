# Bonus Stage 1: Average ratings

We want our restaurants to show their average rating. Test!

##### Feature and unit tests

To `review_feature_spec.rb`, add the code below. If you've done the extra authentication steps in the previous tutorial you may need to add them to your feature specs as you write them.

```ruby
def leave_review(thoughts, rating)
  visit '/restaurants'
  click_link 'Review KFC'
  fill_in 'Thoughts', with: thoughts
  select rating, from: 'Rating'
  click_button 'Leave Review'
end

scenario 'displays an average rating for all reviews' do
  leave_review('So so', '3')
  leave_review('Great', '5')
  expect(page).to have_content('Average rating: 4')
end
```

Now, in our `restaurant_spec.rb`, we add a unit test:

```ruby
...
describe '#average_rating' do
  context 'no reviews' do
    it 'returns "N/A" when there are no reviews' do
      restaurant = Restaurant.create(name: 'The Ivy')
      expect(restaurant.average_rating).to eq 'N/A'
    end
  end
end
...
```

Now we have failing acceptance tests and failing unit tests.  Not a bad time to commit to git (not on master ideally) and swap driver/navigator roles&nbsp;:twisted_rightwards_arrows:.

##### Making an `average_rating` helper

The state of having a failing acceptance test and a failing unit test is an important point in the acceptance/unit test cycle.  We've converted from a high level user requirement to a low level specific. We have two layers of red above us.  We want to red/green/factor cycle at the unit test level to get the functionality needed to make the acceptance test go green.  To make the unit test pass, we need to update our restaurant model.

`app/models/restaurant.rb`:

```ruby
def average_rating
  'N/A'
end
```

This passes the test so far, but obviously isn't very useful. However at least we have confirmed that our unit test is hitting the right place. Now we need a test in the case of having one review, and then one for when it has two or more reviews.

`restaurant_spec.rb`:

```ruby
...
context '1 review' do
  it 'returns that rating' do
    restaurant = Restaurant.create(name: 'The Ivy')
    restaurant.reviews.create(rating: 4)
    expect(restaurant.average_rating).to eq 4
  end
end
...
```

Let's update our `average_rating` method, again doing the absolute minimum to make the test pass.

`app/models/restaurant.rb`:

```ruby
def average_rating
  return 'N/A' if reviews.none?
  4
end
```

A good time to commit to git and swap driver/navigator roles&nbsp;:twisted_rightwards_arrows:.

And now for multiple reviews...

`restaurant_spec.rb`:

```ruby
...
context 'multiple reviews' do
  it 'returns the average' do
    restaurant = Restaurant.create(name: 'The Ivy')
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

Rails has lots of great methods like this.  Check out the [Active Record Calculations API docs](http://api.rubyonrails.org/classes/ActiveRecord/Calculations.html) for more details.  Our unit tests should now be green (acceptance test still red); a good time to commit our changes to our feature branch in git and swap driver/navigator roles&nbsp;:twisted_rightwards_arrows:.

##### Displaying the average rating

Now, let's add some code to the index page to display this average beside each restaurant.

```erb
...
<h3>Average rating: <%= restaurant.average_rating.to_i %></h3>
...
```

```haml
...
%h3 Average rating: #{restaurant.average_rating.to_i}
...
```
This should make our acceptance test go green meaning that we have completed our acceptance test unit test cycle.

##### Stars make things pretty

Even though are tests are green we can improve the user interface.  Yelp uses star ratings which are a nice way of showing a restaurant's rating. We can do something similar just by using the Unicode 'star' characters.

Specifically, we can use these two glyphs:

> BLACK STAR (U+2605)
> ★

> WHITE STAR (U+2606)
> ☆

Let's change the feature spec to expect that output.

```ruby
scenario 'displays an average rating for all reviews' do
  leave_review('so so', '3')
  leave_review('Great!', '5')
  expect(page).to have_content('Average rating: ★★★★☆')
end
```

And now let's make sure the page uses the UTF-8 character set, otherwise those Unicode stars won't render properly.

Somewhere in the layout `head` section you'll need to have this `meta` tag:

```erb
<meta charset="UTF-8">
```

```haml
%meta(charset="UTF-8")
```
We're restarting the acceptance test - unit test cycle again now since the above acceptance test will fail.  Let's follow on with a series of unit tests to get the low level functionality we need to make the high level acceptance test pass.

##### DIY helper methods

Let's create our own helper method that we can call to generate a star rating from a numerical rating.

First we'll make a test for it - throw together a `helpers` folder in the spec
folder, and write a new test in a new file called `reviews_helper_spec.rb`.

```ruby
require 'rails_helper'

describe ReviewsHelper, :type => :helper do
  context '#star_rating' do
    it 'does nothing for not a number' do
      expect(helper.star_rating('N/A')).to eq 'N/A'
    end
  end
end
```

It's been a while so let's commit our changes to our feature branch in git and swap driver/navigator roles&nbsp;:twisted_rightwards_arrows:.

Now the new driver can write that helper method. Rails has auto-generated some placeholder files that we can open up and edit.

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
it 'returns five black stars for five' do
  expect(helper.star_rating(5)).to eq '★★★★★'
end
```

Commit our changes to git and swap driver/navigator roles&nbsp;:twisted_rightwards_arrows:.  We're using the [ping-pong pairing](pills/pairing.md#ping-pong-pairing-between-programmer-a-and-b) method here.

Now the new driver needs to update the same method again in order to make our unit test pass.

```ruby
module ReviewsHelper
  def star_rating(rating)
    return rating unless rating.is_a?(Fixnum)
    '★' * rating
  end
end
```

Once ping pong pairing is up and running the driver keeps making a test pass and then creates a new failing test.  It's almost like a game of chess with two players taking turns of move and counter-move.  Driver, let's have another test for the navigator to chew on!

```ruby
it 'returns three black stars and two white stars for three' do
  expect(helper.star_rating(3)).to eq '★★★☆☆'
end
```

Of course we're always running rspec to check that our tests fail before going on to make the pass, but of course we don't need to remind you of that :-)  We're at a new test failure point - time to commit and swap driver/navigator roles&nbsp;:twisted_rightwards_arrows:.

The new driver needs to work out the remainder to put on the end as white stars:

```ruby
module ReviewsHelper
  def star_rating(rating)
    return rating unless rating.is_a?(Fixnum)
    remainder = (5 - rating)
    "★" * rating + "☆" * remainder
  end
end
```

Now the driver can make a final unit test:

```ruby
it 'returns four black stars and one white star for 3.5' do
  expect(helper.star_rating(3.5)).to eq '★★★★☆'
end
```

Before you run this test think about whether you expect it to pass or fail.  Then run rspec to check. Consider the result carefully.  Whatever happens it's time to commit and swap driver/navigator roles&nbsp;:twisted_rightwards_arrows:.

Were you surprised to see the test fail? When either of you was in navigator mode you might have started to worry about a more strategic issue arising from the current helper implementation, that we've tied things to a class type.  The problem for this test in particular is that we'll get '3.5' back as 3.5, which in Ruby is a Float, and not a Fixnum. A good navigator here might well suggest a bit of [duck typing](http://en.wikipedia.org/wiki/Duck_typing) to identify the input as valid - perhaps we could check not whether we have a Fixum, but whether the incoming rating responds to the `round` method?

If it does, we could then proceed with the method, which involves rounding the review to make sure we get an integer back (rather than using half stars).

```ruby
module ReviewsHelper
  def star_rating(rating)
    # does the rating respond to `round`? If not, just return the rating
    return rating unless rating.respond_to?(:round)

    # if it does – i.e. if it's a valid number - then the rest of the
    # method is run
    remainder = (5 - rating.round)
    "★" * rating.round + "☆" * remainder
  end
end
```

And that should pass those tests. We've completed our run of unit test ping pong and depending on how long it took you to get the last chunk working you might want to swap driver/navigator roles or not.  At the end of the day the critical thing is that both pair partners spend an equal amount of time on the keyboard, and also that you both get a nice balance of activity at the different testing levels and through the applicaiton logic.  Whether you swap roles here or not it's time to jump back up to our failing acceptance test to see if we can now fix it. We can make that pass with something like the following:

```erb
...
<%= star_rating(restaurant.average_rating) %>
...
```

```haml
...
= star_rating(restaurant.average_rating)
...
```
Done. We've made our own helper method – but there are lots of built-in helpers that are very useful. Have a look at :pill: **[Helper methods](/pills/rails_helpers.md)** to learn more.

**Exercise - having reviewed the helper pill see if you can ping pong pair through an acceptance test unit test cycle to get the reviews to display when they were created relative to now (e.g. '5 hours ago').**

Ensuring all our tests are green it's time to commit and we could swap driver/navigator roles before we start a new feature &nbsp;:twisted_rightwards_arrows:, but use your best judgement about how much keyboard time you are getting. Consider that you could place each feature on it's own feature branch and then merge back to master once completed and green.

## Related Videos

* [Rails Helpers and Acceptance/Unit Testing Cycle](https://www.youtube.com/watch?v=M7pUtGRO-zg)

# [Bonus Stage 2: Adding Endorsements](2_adding_endorsements.md)
