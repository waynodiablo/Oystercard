# Section 13: Testing Validations

#### Stop users creating duplicate restaurants – validations

First, write a test. We'll add this within our existing feature spec for restaurants.

`spec/features/restaurants_feature_spec.rb`:

```ruby
...

context 'creating restaurants' do

...

  context 'an invalid restaurant' do
    it 'does not let you submit a name that is too short' do
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'kf'
      click_button 'Create Restaurant'
      expect(page).not_to have_css 'h2', text: 'kf'
      expect(page).to have_content 'error'
    end
  end
...
```

As we haven't got any length limits on restaurant name, the test will fail. Let's fix that – by writing another test, this time for the restaurant model (this is distinct from the restaurant feature spec). Here, we're testing the way that restaurants are actually represented by our code, rather than what the user sees on our website.

##### Unit testing a validation

In `spec/models/restaurant_spec.rb`:

```ruby
it 'is not valid with a name of less than three characters' do
  restaurant = Restaurant.new(name: "kf")
  expect(restaurant).not_to be_valid
end
```

But our expectation of `not_to be_valid` is pretty vague – a restaurant might be invalid for a variety of reasons. Let's narrow it down:

```ruby
require 'spec_helper'

describe Restaurant, type: :model do
  it 'is not valid with a name of less than three characters' do
    restaurant = Restaurant.new(name: "kf")
    expect(restaurant).to have(1).error_on(:name)
    expect(restaurant).not_to be_valid
  end
end
```

To get this test to run, you will need to add `rspec-collection_matchers` to the `test` group of your Gemfile and run `bundle install`.  Time to commit our latest code to git, and switch Driver/Navigator Roles&nbsp;:twisted_rightwards_arrows:.

##### Adding validations – restaurant name length

To pass this test we need to add a validation to our restaurant model.

`app/models/restaurant.rb`:

```ruby
validates :name, length: { minimum: 3 }
```

That will pass our model test – the model will now prevent restaurants with a name shorter than 3 characters from being saved – but not the original feature test. Let's fix our feature test now.

Currently the ```create``` action on the restaurants controller will redirect to `restaurants_path`, regardless of whether or not a restaurant has been successfully created – so let's change that.

`app/controllers/restaurants_controller.rb`:

```ruby
def create
  @restaurant = Restaurant.new(restaurant_params)
  if @restaurant.save
    redirect_to restaurants_path
  else
    render 'new'
  end
end
```

Here, `Restaurant.create` has been split up into its component parts – `Restaurant.new` and `Restaurant.save`. We're still not showing the user an error, though, even though one is being generated in the background (it's that error that's passing our unit test).

To show an error, let's edit our view. Add this to the top of your `views/restaurants/new.html.(erb/haml)` file:

erb:
```erb
<% if @restaurant.errors.any? %>
  <section id="errors" >
    <h2> <%= pluralize(@restaurant.errors.count, "error") %> prohibited this restaurant from being saved: </h2>
    <ul>
      <% @restaurant.errors.full_messages.each do |message| %>
        <li><%= message %></li>
      <% end %>
    </ul>
  </section>
<% end %>
```
haml:
```haml
- if @restaurant.errors.any?
  %section#errors
    %h2
      = pluralize @restaurant.errors.count, "error"
      prohibited this restaurant from being saved:
    %ul
      - @restaurant.errors.full_messages.each do |message|
        %li= message
```

What does this do? Well, in the case that our restaurant has any errors on it (that is, something went wrong when trying to save it) those errors are displayed on screen in a `section`, along with a count of how many errors there are.

***Exercise***: inspect the css styles for the div surrounding the name input field.  You should find that rails has automatically added a `.field_with_errors` class.  Style this so that the form shows the user specifically which input field needs correcting.

(Note that this uses the Rails helper method `pluralize` – have a look online and see what you find!)

### [Next Section - Validations](14_validations.md)
