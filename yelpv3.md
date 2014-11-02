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

