# Section 12: Associations

#### Adding reviews to restaurants – associations

##### Test first!

Let's add some reviews for our restaurants.

`spec/features/reviews_feature_spec.rb`:

```ruby
require 'rails_helper'

feature 'reviewing' do
  before { Restaurant.create name: 'KFC' }

  scenario 'allows users to leave a review using a form' do
     visit '/restaurants'
     click_link 'Review KFC'
     fill_in "Thoughts", with: "so so"
     select '3', from: 'Rating'
     click_button 'Leave Review'

     expect(current_path).to eq '/restaurants'
     expect(page).to have_content('so so')
  end

end
```

Naturally, your test fails. We need to tell our app what reviews are, and how they're related to restaurants. This relationship is called an **association**.

##### Nested routes

We first need a new route for reviews. Update `routes.rb` to have a nested resource:

```ruby
resources :restaurants do
  resources :reviews
end
```

Then, add a link (using Rails' `link_to` helper) to `new_restaurant_review_path` (you can see this path appearing in `bin/rake routes`).

##### Add a controller and a model

Now we need a new controller.

`$ bin/rails g controller reviews`

In `app/controllers/reviews_controller.rb`, add the 'new' method:

```rb
def new
  @restaurant = Restaurant.find(params[:restaurant_id])
  @review = Review.new
end
```

This sets up `@restaurant` and `@review` instance variables which get passed into the 'new review' form in the next step.

Keep following the errors RSpec is giving you. Now we need a view:

`app/views/reviews/new.html.erb`:

```erb
<%= form_for [@restaurant, @review] do |f| %>
  <%= f.label :thoughts %>
  <%= f.text_area :thoughts %>
  <%= f.label :rating %>
  <%= f.select :rating, (1..5) %>
  <%= f.submit 'Leave Review' %>
<% end %>
```
`app/views/reviews/new.html.haml`:

```haml
= form_for [@restaurant, @review] do |f|
  = f.label :thoughts
  = f.text_area :thoughts
  = f.label :rating
  = f.select :rating, (1..5)
  = f.submit 'Leave Review'
```

Cool. Now we need a model for reviews – currently they aren't being stored in the database!

`$ bin/rails g model review thoughts:text rating:integer`

Let's add a create method to our reviews controller.

`app/controllers/reviews_controller.rb`:

```ruby
def create
  @restaurant = Restaurant.find(params[:restaurant_id])
  @restaurant.reviews.create(review_params)
end

private

def review_params
  params.require(:review).permit(:thoughts, :rating)
end
```

(Remember all the `permit` weirdness from before!)

we should now be seeing the folowing error:

```
Failure/Error: click_button 'Leave Review'
     NoMethodError:
       undefined method `reviews' for #<Restaurant:0x007fd120bd40b8>
     # ./app/controllers/reviews_controller.rb:10:in `create'
     # ./spec/features/reviews_feature_spec.rb:11:in `block (2 levels) in <top (required)>'
```

This is really the meat of this walkthrough - our Restaurant class does not have an instance method '#reviews'. Rails can auto-magically generate this method for us, we just need to set up the association. We also need to make sure that we are able to delete restaurants, even if they have reviews. 

In `/app/models/restaurant.rb`:
```ruby
class Restaurant < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
end
```

We should now see an `UnknownAttributeError` for 'restaurant_id'. This is because we haven't added a reference to restaurant in our review table. Let's use a generator to build a migration:

```
$ bin/rails g migration AddRestaurantRefToReviews restaurant:references
```
Finally, to get our tests to pass, redirect back to the restaurants path, and add the review to your view template.

### [Next Section - Testing Validations](13_testing_validations.md)
