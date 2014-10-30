# Yelp

### V1 Walkthrough

- [Installing Rails and initialising your app](#installing-rails-and-initialising-your-app)
    - [Where'd all the files go?](#whered-all-the-files-go)
    - [Boot the server](#boot-the-server)
    - [Add some testing gems](#add-some-testing-gems)
- [The first test – home page with a link](#the-first-test--home-page-with-a-link)
- [The second test – creating a restaurant](#the-second-test--creating-a-restaurant)
- [Adding a description to restaurants – migrations](#adding-a-description-to-restaurants--migrations)
- [Adding reviews to restaurants – associations](#adding-reviews-to-restaurants--associations)
    - [Test first!](#test-first)
    - [Nested routes](#nested-routes)
    - [Add a controller and a model](#add-a-controller-and-a-model)
    - [Associating restaurants and reviews](#associating-restaurants-and-reviews)
    - [`belongs_to` and dealing with orphan reviews](#belongsto-and-dealing-with-orphan-reviews)
- [Stop users creating duplicate restaurants – validations](#stop-users-creating-duplicate-restaurants--validations)
    - [Unit testing a model](#unit-testing-a-model)
    - [Adding validations – restaurant name length](#adding-validations--restaurant-name-length)
    - [Adding validations - restaurant uniqueness](#adding-validations---restaurant-uniqueness)

#### Installing Rails and initialising your app

`$ gem install rails` will install the Rails gem. Expect it to take a while. `rails --help` gives a nice help menu.

Right. All installed? Then let's begin.

Make a new Rails app:

`$ rails new yelp_clone -d postgresql -T`

* `yelp_clone` is the name of your app – Rails will create this in a new directory. 
* By default, Rails uses Test::Unit for testing. The `-T` switch turns off the built-in Rails test suite, because we're going to use RSpec for this project.
* `-d` preconfigures your app for a particular type of database. By default, this is SQLite – which is problematic because Heroku doesn't support it. In this case, we're overriding the default to use PostgreSQL. 

#### Where'd all the files go?

True to its 'opinionated' name, Rails is full of files and folders right from the get-go. Here's what some of them do:

* `app` – **where your code goes**. Contains models, views and controllers.
* `vendors` – a place for resources that you haven't written but are needed for the project, like JQuery.
* `public` – public resources. These will remain available even if the server goes down. Includes all your error pages by default.
* `log` – keeps server logs and terminal output.
* `config` – configuration information, including `database.yml` which includes database configuration details, a routes file,
* `bin` – contains your specified version of Rails.

#### Boot the server

Start up the server!

`$ rails server`

or

`$ rails s`

will get you started. (Rails has lots of these little command-line shortcuts.) Now visit http://localhost:3000. Don't worry if you see an error – you'll likely need to run a `rake` task to get your database going, so visit the page and you'll be told which.

`$ rake db:create`

If this doesn't work, you may need to run 

`$ rake db:create RAILS_ENV=test`

instead.

#### Add some testing gems

Now, add some gems to your Gemfile!

```ruby
gem 'rspec-rails', group: :test
gem 'capybara', group: :test
```

With these, we also want to run this command:

`$ rails generate rspec:install`

This gets RSpec going by creating a `spec` directory and a helper file.

In your `spec/rails_helper.rb` file, add the line:

`require 'capybara/rails'`

This lets you use Capybara in your testing environment.

#### The first test – home page with a link

Make a `spec/features/` directory, and make a new spec file inside it.

`spec/features/restaurants_feature_spec.rb`:

```ruby
require 'rails_helper'

describe 'restaurants' do
  context 'no restaurants have been added' do
      it 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants'
      expect(page).to have_link 'Add a restaurant'
    end
  end
end
```

Now run `rspec`, which will say that there's no route matching `/restaurants`. Simple.

The `config/routes.rb` file has lots of clues as to how to write routes – have a look at them.

`config/routes.db`:

```ruby
resources :restaurants
```

If you now run `rake routes` you'll get a list of the different routes that this has created. **This is one of the more powerful features of Rails:** it has conventions about routing that do a lot of work for you. Look at the way it's automatically created paths for `create`, `read`, `update` and `destroy` methods. You can see how fast would be to get a simple [CRUD](http://en.wikipedia.org/wiki/Create,_read,_update_and_delete) app off the ground!

Running `rspec` again, we get another `RoutingError` – this time, there's no Restaurants controller. Time to make one!

`$ rails g controller restaurants`

(Here, `g` is short for generate.)

Now, RSpec gives us a different error – that there's no action /index for restaurants. Let's fix that.

`app/controllers/restaurants_controller.rb`:

```ruby
class RestaurantsController < ApplicationController

  def index
  end

end
```

Now we get a different error – that `app/views/` is missing an index view.

`$ touch app/views/restaurants/index.html.erb`

(Note the double file extension here.)

Now our error is that there's no text on the page! Fix it:

`app/views/restaurants/index.html.erb`:

```html
No restaurants yet!
```

Cool – but now RSpec is telling us we need a link on the page.

`app/views/restaurants/index.html.erb`:

```html
No restaurants yet!
<a href='#'>Add a restaurant</a>
```

We've just fudged this by setting the link's `href` value to '#', so it doesn't go anywhere – but it is a link all the same, so now, our test is passing.

#### The second test – creating a restaurant on the backend

Add the following to `spec/features/restaurants_feature_spec.rb`:

```ruby
...

context 'restaurants have been added' do
  before do
    Restaurant.create(name: 'KFC')
  end

  it 'should display restaurants' do
    visit '/restaurants'
    expect(page).to have_content('KFC')
    expect(page).not_to have_content('No restaurants yet')
  end
end
...
```

Now we need a Restaurants model to satisfy our failing test.

`$ rails g model restaurant name:string description:text`

This command will add 'name' and 'description' properties to the database for each restaurant, and make a migration file that you can run to create these properties. Each item gets an ID automatically. Note that 'restaurant' here is singular, but the controller refers to 'restaurants'.

(Here, **string** and **text** are types of data that your database can store. Rails will interpret these terms differently depending on what type of database you use, but in principle *string* has a length limit of 255 characters whereas *text* does not.)

If you make a mistake, you can type the above command but using `rails d` – for destroy – to remove the migration.

Then:

`$ rake db:migrate`

which will run all of your database migrations.

(A word on migrations – if you need to change something, **don't edit the schema file it**. If you want to remove database tables or change the schema in any way, instead write another migration that does that.)

Now, in `restaurants_controller.rb` we want to get all of those restaurants from the database. Let's add a method for that (*the below replaces the old method*):

```ruby
def index
  @restaurants = Restaurant.all
end
```

This creates an instance variable, `@restaurants`, that is accessible by our `index` view. Let's refer to it in `app/views/restaurants/index.html.erb`:

```erb
<% if @restaurants.any? %>
  <% @restaurants.each do |restaurant| %>
    <h2> <%= restaurant.name %> </h2>
  <% end %>
<% else %>
  No restaurants yet
<% end %>

<a href='#'>Add a restaurant</a>
```

#### Creating a restaurant on the frontend

That last test is all well and good, but it invokes `Restaurant.create` – we still don't have a way for users of our site to add restaurants. Let's add a test for that now.

`spec/features/restaurants_feature_spec.rb`:

```ruby
describe 'creating restaurants' do 
 it 'prompts user to fill out a form, then displays the new restaurant' do
  visit '/restaurants'
  click_link 'Add a restaurant'
  fill_in 'Name', with: 'KFC'
  click_button 'Create Restaurant'
  expect(page).to have_content 'KFC'
  expect(current_path).to eq '/restaurants'
 end
end
```

The test will fail. We have an 'Add a restaurant' link, but it doesn't go anywhere! Where should we link to? Run `rake routes` if you want a clue...

Let's make a new method in `restaurants_controller.rb` to go alongside our `index` method.

`app/controllers/restaurants_controller.rb`:

```ruby
class RestaurantsController < ApplicationController
...
  def new
  end
...
```

Run your tests again – sure enough, our `new` method doesn't have a view associated with it. Let's make one.

`app/views/restaurants/new.html.erb`:

```erb
<%= form_for Restaurant.new do |f| %>
<%= f.label :name %>
<%= f.text_field :name %>
<%= f.submit %>
<% end %>
```

Here, we're using Rails' built-in `form_for` helper to build a form, which takes care of a lot of things, including verifying the authenticity of the form. You can read more about that in [RailsGuides](http://guides.rubyonrails.org/form_helpers.html).

Run your tests again – RSpec will now say it doesn't know what to do with the information submitted into that form. We need a `create` method!

```ruby
class RestaurantsController < ApplicationController
...
  def create
    Restaurant.create(params[:restaurant])
    redirect_to '/restaurants'
  end
...
```

Looks good. Wait... why doesn't this work?

Well, before Rails 3.2, it would have worked – and that was a huge security hole. `params[:reviews]` passes in *all* the params received from the submitted form. If an unscrupulous user were to modify the form in their browser to include extra form fields, then our controller would blindly accept them as well!

As a result, we need to explicitly state which params we're going to allow our controller to accept, using `permit`. Modify the following line:

```ruby
Restaurant.create(params[:restaurant])
```

to instead say

```ruby
Restaurant.create(params[:restaurant]).permit(:name) 
```

which tells Rails that we should allow only the field labelled 'name' to be accepted by the form.

Now let's clean up that form a bit – using `Restaurant.new` inside the view logic isn't good practice, so instead we'll use `@restaurant` and let the controller deal with what that means.

`app/views/restaurants/new.html.erb`:

```erb
<%= form_for Restaurant.new do |f| %>
  <%= f.label :name %>
  <%= f.text_field :name %>
  <%= f.submit %>
<% end %>
```

`app/controllers/restaurants_controller.rb`:

```ruby
class RestaurantsController < ApplicationController
...
  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(params[:restaurant])
    redirect_to '/restaurants'
  end
...
```

Much better.

#### Adding a description to restaurants – migrations

Currently, our database has a restaurants table with a few columns (much like a sheet in Excel). Let's say it looks something like this:

Id | Name  
--- | --- 
1 | KFC 
2 | Pret a Manger
3 | ...

We want to add another column to the table for a description. In Rails, the way you do this is by creating a **migration**.

Migrations describe a set of changes you're making to your database – Rake can interpret them and run the actual SQL commands that make those changes happen without you having to get your hands dirty. They're also super-useful because if something goes wrong, you can rollback your database to a previous state by using those migration files (which provide a record of every change to your data).

```shell
$ rails g migration AddDescriptionToRestaurants description:text
$ rake db:migrate
```

The first command above creates a migration with adds a 'description' column (of type text) to our 'restaurants' table. The second command actually runs that migration, updating our database schema to add that column.

#### Putting the 'UD' in CRUD - updating and destroying restaurants

You remember [CRUD](http://en.wikipedia.org/wiki/Create,_read,_update_and_delete), right? That's all Yelp is, at its core. Just a fancy CRUD app.

So far we've got creating restaurants down, but we can't update or delete them.

##### Updating restaurants

Let's tackle updating restaurants first. Let's test:

`spec/features/restaurants_feature_spec.rb`:

```ruby
...
context 'editing restaurants' do

  before do 
    Restaurant.create(name:'KFC') 
  end

  it 'lets a user edit a restaurant' do
   visit '/restaurants'
   click_link 'Edit KFC'
   fill_in 'Name', with: 'Kentucky Fried Chicken'
   click 'Update Restaurant'
   expect(page).to have_content 'Kentucky Fried Chicken'
   expect(current_path).to eq '/restaurants'
  end

end
...
```

(Note the `before` hook which creates a restaurant in the database before running our test.)

Run RSpec, and follow the path it leads you down... Again, a quick good at `rake routes` will show you that Rails has some built-in routes for you to use.

First, we need an edit link for each restaurant. In `app/views/restaurants/index.html.erb` to the code that loops through each restaurant, add:

```erb
<%= link_to "Edit #{restaurant.name}", edit_restaurant_path(restaurant) %>
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

Cool. But we still haven't got an `update` action, as RSpec will tell you – so time to add that to `restaurants_controller.rb`.

```ruby
...
  def update
    @restaurant = Restaurants.find(:params[:id])
    @restaurant.update(params[:restaurants]).permit(:name)
    redirect_to '/restaurants'
  end
...
```

And we're done.

##### Deleting restaurants

To finish off CRUD, we need a *delete* method.

In `restaurants_feature_spec.rb`, let's add a test:

```ruby

...

describe ‘deleting restaurants’ do

  before do
    Restaurant.create(:name => "KFC")
  end

  it "removes a restaurant when a user clicks a delete link" do
    visit '/'
    click_link 'Delete KFC'
    expect(page).not_to have_content 'KFC'
    expect(page).to have_content 'Restaurants deleted successfully'
  end

end
...
```

If you look at `rake routes`, you'll see a `destroy` route that takes the verb `DELETE` – that's what we'll be using. Let's link this up in our restaurant view so that users can access it by adding the following line:

`app/views/restaurants/index.html.erb`:

```erb
<%= link_to "Delete #{restaurant.name}", restaurant_path(restaurant), method: :delete %>
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
    redirect_to '/restaurant'
  end
...
```

And now our tests pass and we've got all four CRUD methods!

#### Adding reviews to restaurants – associations

##### Test first!

Let's add some reviews for our restaurants.

`app/spec/features/review_spec.rb`:

```ruby
require 'rails_helper'

describe 'reviewing' do
  before do
    Restaurant.create(name: 'KFC')
  end

  it 'allows users to leave a review using a form' do
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

First, we need a new route for reviews. Update `routes.rb` to have a nested resource:

```ruby
resource :restaurants do
  resource :reviews
end
```

Then, add a link (using Rails' `link_to` helper) to `new_restaurant_review_path` (you can see this path appearing in `rake routes`).

##### Add a controller and a model

Now we need a new controller.

`$ rails g controller reviews`

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
  <%= f.submit 'Leave review' %>
<% end %>
```

Cool. Now we need a model for reviews – currently they aren't being stored in the database!

`$ rails g model review thoughts:text rating:integer`

Let's add a create method to our reviews controller.

`app/controllers/reviews_controller.rb`:

```ruby
def create
  @restaurant = Restaurant.find(params[:restaurant_id])
  @restaurant.reviews.create(params[:reviews].permit(:thoughts, :rating))
end
```

(Remember all the `permit` weirdness from before!)

##### Associating restaurants and reviews

RSpec will now complain that we don't have an association between restaurants and reviews. Bummer. Time to fix that.

To `app/models/restaurant.rb`, add:

`has_many :reviews`

Finally, we need to modify our database to join together reviews and restaurants. Time for a migration:

`$ rails g migration AddResturantIdToReviews restaurant:belongs_to`

`$ rake db:migrate`

This does some Rails magic – it interprets AddRestaurantIdToReviews and parses it, so it understands that it needs to add 'RestaurantId' to the Reviews model. Then, Rake runs the migration.

Now, if you look at your `schema.rb` you'll see the new association between restaurants and reviews.

RSpec now gives an error about a missing template for create, so time to create that. Let's add the following line to the end of the `create` method in the reviews model.

`app/controllers/reviews_controller.rb`:

```ruby
redirect_to restaurants_path
```

Now, once the method is run, Rails will take a user back to the list of restaurants.

Finally, update `restaurants/index.html.erb` to display the actual reviews, which you can get at by calling `restaurants.reviews.each` and iterating over them.

@@WIP

##### `belongs_to` and dealing with orphan reviews

Adding the following line to the `review.rb` model will tie the review to a restaurant:

```ruby
belongs_to :restaurant
```

But what if the 'parent' restaurant gets deleted? This would lead to reviews without a restaurant associated with them. Awful. So we need to tie the 'destroy' commands of both of these together – if a restaurant is deleted, all its child reviews go as well.

`app/models/restaurant.rb`:

```ruby
has_many :reviews, dependent: :destroy
```

#### Stop users creating duplicate restaurants – validations

First, write a test. We'll add this within our existing feature spec for restaurants.

`spec/features/restaurants_feature_spec.rb`:

```ruby
describe 'creating restaurants' do

        ...

    context 'an invalid restaurant' do
        it 'does not let you submit a name that is too short' do
            visit '/restaurant'
            click_link 'Add a restaurant'
            fill_in 'Name', with: 'kf'
            click_button 'Create Restaurant'
            expect(page).not_to have_css 'h2', text: 'kf'
            expect(page).to have_content 'error'
        end
    end
end
```

As we haven't got any length limits on restaurant name, the test will fail. Let's fix that – by writing another test, this time for the restaurant model (as distinct from the restaurant feature). Here, we're testing the way that restaurants are actually represented by our code, rather than what the user sees on our website.

##### Unit testing a model

`spec/models/restaurant_spec.rb`:

```ruby
require 'spec_helper'

RSpec.describe Restaurant, :type => :model do
    it 'is not valid with a name of less than three characters' do
        restaurant = Restaurant.new(name: "kf")
        expect(restaurant).not_to be_valid
    end
end
```

Specifying `:type => :model` ensures that your test has methods appropriate for a model (unlike Capybara, which is specifically for web feature testing).

But our expectation of `not_to be_valid` is pretty vague – a restaurant might be invalid for a variety of reasons. Let's narrow it down:

```ruby
require 'spec_helper'

RSpec.describe Restaurant, :type => :model do
    it 'is not valid with a name of less than three characters' do
        restaurant = Restaurant.new(name: "kf")
        expect(restaurant).to have(1).error_on(:name)
        expect(restaurant).not_to be_valid
    end
end
```

To get this test to run, you may also need to add `rspec-collection_matchers` to the `test` group of your Gemfile and run `bundle install`.

##### Adding validations – restaurant name length

To pass this test we need to add a validation to our restaurant model.

`app/models/restaurant.rb`:

```ruby
validates :name, length: {minimum: 3}
```

That will pass our model test – the model will now prevent restaurants with a name shorter than 3 characters from being saves – but not the original feature test. Let's fix our feature test now.

Currently our restaurants controller will save a restaurant passed to its `create` method regardless of whether it's correct or not – so let's change that.

`app/controllers/restaurants_controller.rb`:

```ruby
def create
    @restaurant = Restaurant.new(params[:restaurant].permit(:name))
    if restaurant.save
        redirect_to restaurants_path
    else
        render 'new'
    end
end
```

Here, `Restaurant.create` has been split up into its component parts – `Restaurant.new` and `Restaurant.save`. We're still not showing the user an error, though, even though one is being generated in the background (it's that error that's passing our unit test).

To show an error, let's edit our view. Add this to the top of your `views/restaurants/new.html.erb` file:

```erb
<% if @restaurant.errors.any? %>
    <div id="errors" >
        <h2> <%= pluralize(@restaurant.errors.count, "error") %> prohibited this restaurant from being saved: </h2>
        <ul>
            <% @restaurant.errors.full_messages.each do |message| %>
                <li><%= message %></li>
            <% end %>
        </ul>
    </div>
<% end %>
```

What does this do? Well, in the case that our restaurant has any errors on it (that is, something went wrong when trying to save it), those errors are displayed on screen in a `div`, along with a count of how many errors there are.

(Note that this uses the Rails helper method `pluralize` – have a look online and see what you find!)

##### Adding validations - restaurant uniqueness

We also don't want to allow users to create the same restaurant twice. So, let's write a test!

```ruby
it "is not valid unless it has a unique name" do
    Restaurant.create(name: "Moe's Tavern")
    restaurant = Restaurant.new(name: "Moe's Tavern")
    expect(restaurant).to have(1).error_on(:name)
end
```

This test fails because we haven't implemented a validation on uniqueness yet. Fix it by updating this line in your restaurants model as follows:

```ruby
validates :name, length: {minimum: 3}, uniqueness: true
```

(RailsGuides has lots of information on the [different validations](http://guides.rubyonrails.org/active_record_validations.html) that are available to you.)

Your tests should now all be passing.

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

#### Done

On to [version 2](yelpv2.md)!