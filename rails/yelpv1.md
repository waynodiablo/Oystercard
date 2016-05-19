x# Section 9: Updating (CR"U"D)

#### Adding a description to restaurants – migrations

Currently, our database has a restaurants table with a few columns (much like a spreadsheet in Excel). Let's say it looks something like this:

Id | Name
-- | ---
1 | KFC
2 | Pret a Manger
3 | ...

We want to add another column to the table for a description. In Rails, the way you do this is by creating a **migration**. Let's look at migrations again.

Migrations describe a set of changes you're making to your database – Rake can interpret them and run the actual SQL commands that make those changes happen without you having to get your hands dirty. They're also super-useful because if something goes wrong, you can roll your database back to a previous state by using those migration files (which provide a record of every change to your data).

```shell
$ bin/rails g migration AddDescriptionToRestaurants description:text
$ bin/rake db:migrate
```

The first command above creates a migration with adds a 'description' column (of type text) to our 'restaurants' table. The second command actually runs that migration, updating our database schema to add that column.

=========== NOTE - THERE WAS SOME RE-ORDERING HERE. CHECK CONTENT FOR LOGICAL FLOW ==============

##### Updating restaurants

Now let's tackle updating restaurants. Testing first:

`spec/features/restaurants_feature_spec.rb`:

```ruby
...
context 'editing restaurants' do

  before { Restaurant.create name: 'KFC' }

  scenario 'let a user edit a restaurant' do
   visit '/restaurants'
   click_link 'Edit KFC'
   fill_in 'Name', with: 'Kentucky Fried Chicken'
   click_button 'Update Restaurant'
   expect(page).to have_content 'Kentucky Fried Chicken'
   expect(current_path).to eq '/restaurants'
  end

end
...
```

(Note the `before` hook which creates a restaurant in the database before running our test).

Run RSpec and follow the path it leads you down... Again, a quick look at `bin/rake routes` will show you that Rails has some built-in routes for you to use.

First, we need to add an edit link for each restaurant. In `app/views/restaurants/index.html.erb` or `app/views/restaurants/index.html.haml` add to the code that loops through each restaurant:

erb:
```erb
<%= link_to "Edit #{restaurant.name}", edit_restaurant_path(restaurant) %>
```
haml:
```haml
= link_to "Edit #{restaurant.name}", edit_restaurant_path(restaurant)
```

Note that `edit_restaurant_path` takes an argument – the restaurant you want to edit!

We need to make an `edit` method. We can use `Restaurant.find` to find a restaurant by its id.

`app/controllers/restaurants_controller.rb`:

```ruby
...

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

...
```

Now we need to create the missing `edit` view.

`app/views/restaurants/edit.html.erb`:

```erb
<%= form_for @restaurant do |f| %>
  <%= f.label :name %>
  <%= f.text_field :name %>
  <%= f.submit %>
<% end %>
```

`app/views/restaurants/edit.html.haml`:

```haml
= form_for @restaurant do |f|
  = f.label :name
  = f.text_field :name
  = f.submit
```

Cool. But we still haven't got an `update` action, as RSpec will tell you – so time to add that to `restaurants_controller.rb`.

```ruby
...
  def update
    @restaurant = Restaurant.find(params[:id])
    @restaurant.update(restaurant_params)

    redirect_to '/restaurants'
  end
...
```

And we're done. A good time to commit our latest code to git, and switch Driver/Navigator Roles&nbsp;:twisted_rightwards_arrows:.

##### Deleting restaurants

To finish off CRUD, we need a *delete* method.

In `restaurants_feature_spec.rb`, let's add a test:

```ruby

...

context 'deleting restaurants' do

  before { Restaurant.create name: 'KFC' }

  scenario 'removes a restaurant when a user clicks a delete link' do
    visit '/restaurants'
    click_link 'Delete KFC'
    expect(page).not_to have_content 'KFC'
    expect(page).to have_content 'Restaurant deleted successfully'
  end

end
...
```

If you look at `rake routes`, you'll see a `destroy` route that takes the verb `DELETE` – that's what we'll be using. Let's link this up in our restaurant view so that users can access it by adding the following line:

`app/views/restaurants/index.html.erb`:

```erb
<%= link_to "Delete #{restaurant.name}", restaurant_path(restaurant), method: :delete %>
```
`app/views/restaurants/index.html.haml`:

```haml
= link_to "Delete #{restaurant.name}", restaurant_path(restaurant), method: :delete
```

Again, `restaurant_path` takes a restaurant as an argument, but here we have to explicitly specify the `delete` method so that Rails knows we want to delete the item.

Running RSpec again will throw a different error – this time that there's a method missing.

To the restaurants controller, add a destroy method:


```ruby
...
  def destroy
    @restaurant = Restaurant.find(params[:id])
    @restaurant.destroy
    flash[:notice] = 'Restaurant deleted successfully'
    redirect_to '/restaurants'
  end
...
```

Don't forget to display the `flash[:notice]` in `application.html.erb` or `application.html.haml` , by adding it above `<%= yield %>` or `= yield`

```erb
<%= notice %>
<%= yield %>
```
```haml
= notice
= yield
```

And now our tests pass and we've got all four CRUD methods!  Let's celebrate by  committing our latest code to git, and switching Driver/Navigator Roles&nbsp;:twisted_rightwards_arrows:.

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

def review_params
  params.require(:review).permit(:thoughts, :rating)
end
```

(Remember all the `permit` weirdness from before!)  Now, this is probably a good time to commit our code and switch Driver/Navigator Roles&nbsp;:twisted_rightwards_arrows:.

##### Associating restaurants and reviews

RSpec will now complain that we don't have an association between restaurants and reviews. Bummer. Time to fix that.

TDD in Rails is sometimes difficult as there is so much 'magic', it is often difficult to know what to test.  Fortunately, the guys over at [Thoughtbot](thoughtbot.com) have written a fantastic gem called [shoulda](https://github.com/thoughtbot/shoulda) to help us test some of those hard to reach parts.

Add `shoulda` to your Gemfile and run `bundle install`

Create `spec/models/restaurant_spec.rb`:
```
require 'rails_helper'

describe Restaurant, type: :model do
  it { is_expected.to have_many :reviews }
end
```
Now run `rspec`.  What just happened?

If you haven't come across RSpec's [one-liner syntax](https://www.relishapp.com/rspec/rspec-core/v/3-2/docs/subject/one-liner-syntax) before, now is the time to go and investigate.

Let's pass this test:

To `app/models/restaurant.rb`, add:

`has_many :reviews`

Is RSpec passing?

Finally, we need to modify our database to join together reviews and restaurants. Time for a migration:

`$ bin/rails g migration AddRestaurantIdToReviews restaurant:belongs_to`

This does some Rails magic.  But in the words of Uncle Vernon, "There's no such thing as magic!"  Study the migration file that Rails has just created.  What is it doing?  Why do we need to add restaurant_id to reviews?  (Wait, doesn't that sound familiar...?).  Now would be a good time to investigate [ActiveRecord Associations](http://guides.rubyonrails.org/association_basics.html).

Run `$ bin/rake db:migrate`.

Now, if you look at your `schema.rb` you'll see the new association between restaurants and reviews.

RSpec now gives an error about a missing template for create, so time to create that. Let's add the following line to the end of the `create` method in the reviews controller.

`app/controllers/reviews_controller.rb`:

```ruby
redirect_to restaurants_path
```

Now, once the method is run, Rails will take a user back to the list of restaurants.

Finally, update `app/views/restaurants/index.html.(erb/haml)` to display the actual reviews, which you can get at by calling `restaurants.reviews.each` and iterating over them. You'll want to do the same for `app/views/restaurants/show.html.(erb/haml)`. Use something like this inside of your each loop:

erb:
```erb
<h3>Reviews for <%= restaurant.name %></h3>

<% if restaurant.reviews.any? %>
  <ul>
    <% restaurant.reviews.each do |review| %>
      <li>
        <%= review.thoughts %>, <strong><%= review.rating %></strong>/5
      </li>
    <% end %>
  </ul>
<% else %>
  <p>No reviews.</p>
<% end %>
```
haml:
```haml
%h3
  Reviews for
  = restaurant.name

- if restaurant.reviews.any?
  %ul
    - restaurant.reviews.each do |review|
      %li
        = review.thoughts
        %strong= review.rating
        \/5
- else
  %p No reviews
```
##### `belongs_to` and dealing with orphan reviews

*In the following section up to the exercise, use what you've read in the previous section to TDD all of the following using `shoulda`.  We've given you the final code - please decide how to write the tests first.*

Adding the following line to the `review.rb` model will tie the review to a restaurant:

```ruby
belongs_to :restaurant
```

But what if the 'parent' restaurant gets deleted? This would lead to reviews existing without a restaurant associated with them. Awful. So we need to tie the 'destroy' commands of both of these together – if a restaurant is deleted, all its child reviews go as well.

`app/models/restaurant.rb`:

```ruby
has_many :reviews, dependent: :destroy
```

***Exercise***: We just added code that does not support any functionality that we are testing.  Create a test to check for it, and then make sure it fails when `belongs_to :restaurant` is removed.  Test Driven Development (TDD) is the best way to ensure that tests fail before passing, but the critical thing is that you see the tests fail at least once.  Why?  Because otherwise you are not sure if your test is not just a vacuous test that will just waste time and leave you thinking you have test coverage when you don't really.

Before we move on let's commit our latest code to git, and switch Driver/Navigator Roles&nbsp;:twisted_rightwards_arrows: again.

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

(Note that this uses the Rails helper method `pluralize` – have a look online and see what you find!)  Let's also commit our latest code to git, and switch Driver/Navigator Roles&nbsp;:twisted_rightwards_arrows: one last time in this walkthrough.

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

Your tests should now all be passing.  Commit and High Five!!!!!

#### Done

#### Related Videos:

* [Rails](https://www.youtube.com/watch?v=iOJUBnC0imE)
* [Rails Cont](https://www.youtube.com/watch?v=Tm7kjJBDa-8)

On to [version 2](yelpv2.md)!
