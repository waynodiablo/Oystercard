| Yelp V1 | [Yelp home](yelp.md) | [Yelp V2 →](yelpv2.md) |
|---------|----------------------|-----------------------:|

# Yelp

***As you know, as with all Makers Academy materials, there may be subtle errors in the following code snippets.  Please try to approach those as challenges on which to polish your debugging skills - pull requests always welcome.***


### V1 Walkthrough

- [V1 Walkthrough](#v1-walkthrough)
    - [Getting started](#getting-started)
        - [Installing Rails and initialising your app](#installing-rails-and-initialising-your-app)
        - [Where'd all the files go?](#whered-all-the-files-go)
        - [Boot the server](#boot-the-server)
        - [Add some testing gems](#add-some-testing-gems)
    - [The first test – home page with a link](#the-first-test--home-page-with-a-link)
        - [Rails Routing](#rails-routing)
        - [Creating controllers](#creating-controllers)
        - [Creating views](#creating-views)
    - [The second test – creating a restaurant on the backend](#the-second-test--creating-a-restaurant-on-the-backend)
        - [Models and migrations](#models-and-migrations)
        - [Rendering restaurants in the view](#rendering-restaurants-in-the-view)
    - [Creating a restaurant on the frontend](#creating-a-restaurant-on-the-frontend)
        - [Making forms in Rails – `form_for`, `create`, and `permit`](#making-forms-in-rails--formfor-create-and-permit)
    - [Adding a description to restaurants – migrations](#adding-a-description-to-restaurants--migrations)
    - [Putting the 'UD' in CRUD - updating and destroying restaurants](#putting-the-ud-in-crud---updating-and-destroying-restaurants)
        - [Updating restaurants](#updating-restaurants)
        - [Deleting restaurants](#deleting-restaurants)
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
        - [Adding validations – reviews](#adding-validations---reviews)
    - [Done](#done)


***Please work through this walkthrough with a pair partner. Please take turns on the keyboard as the driver as described in the [pairing pill](pills/pairing.md) :pill:.   Please swap driver/navigator roles at least as often as you see the :twisted_rightwards_arrows: sign.***

#### Getting started

##### Installing Rails and initialising your app

`$ gem install rails` will install the Rails gem. Expect it to take a while. `rails --help` gives a nice help menu.

Right. All installed? Then let's begin.

Make a new Rails app:

`$ rails new yelp_clone -d postgresql -T`

* `yelp_clone` is the name of your app – Rails will create this in a new directory.
* By default, Rails uses Test::Unit for testing. The `-T` switch turns off the built-in Rails test suite, because we're going to use RSpec for this project.
* `-d` preconfigures your app for a particular type of database. By default, this is SQLite – which is a useful toy database, but can't be used on Heroku. In this case, we're overriding the default to use PostgreSQL.

##### Where'd all the files go?

True to its 'opinionated' name, Rails is full of files and folders right from the get-go. Here's what some of them do:

* `app` – **where your code goes**. Contains models, views and controllers; as well also JavaScript & CSS assets
* `bin` – contains specific versions of executables such as rails and rake for doing low level tasks
* `config` – configuration information, including `database.yml` which includes database configuration details and a routes file
* `db` - all our database related code for migrating and seeding the databse
* `lib` - place to put non-rails ruby code
* `log` – keeps server logs and terminal output
* `public` – public resources. These will remain available even if the server goes down. Includes all your error pages by default
* `tmp` - temporary stuff gets stored here
* `vendors` – a place for resources that you didn't write but are needed for the project, like jQuery; also called 3rd party assets



##### Boot the server

Start up the server!

`$ bin/rails server`

or

`$ bin/rails s`

will get you started. (Rails has lots of these little command-line shortcuts.) Now visit http://localhost:3000. Don't worry if you see an error – you'll likely need to run a `rake` task to get your database going, so visit the page and you'll be told which.

`$ bin/rake db:create`

If this doesn't work, you may need to run

`$ bin/rake db:create RAILS_ENV=test`

instead.

##### Adding Gems for testing

We created a Rails app without its default testing framework.  Let's add in our prefered RSpec testing framework by adding som gems to our Gemfile.

```ruby
group :test do
  gem 'rspec-rails'
  gem 'capybara'
end
```

Run bundler to install those gems

`$ bundle`

Once installed we want to run this command (details on the rspec-rails website):

`$ bin/rails generate rspec:install`

This gets RSpec going by creating a `spec` directory and two helper files ('spec/spec_helper.rb' and 'spec/rails_helper.rb'). It also creates a '.rspec' file which we should edit to look like this:

```sh
--color
--format documentation
--require spec_helper
```

Then, in your `spec/rails_helper.rb` file add the following require statement below the other require statements:

`require 'capybara/rails'`

This lets you use Capybara in your testing environment for the purpose of writing end user acceptance tests.  

**It might seem early but Rails has generated a lot of code for us so this would be a good time to commit our initial code to git, and to switch Driver/Navigator Roles&nbsp;:twisted_rightwards_arrows:.**

#### The first test – home page with a link

Let's start with a top level acceptance test of our site as it would be experienced through the eyes of our users.  Make a `spec/features/` directory, and make a new spec file inside it.

`spec/features/restaurants_feature_spec.rb`:

```ruby
require 'rails_helper'

feature 'restaurants' do
  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants'
      expect(page).to have_link 'Add a restaurant'
    end
  end
end
```

We should now see rspec fail with 'No route matches [GET] "/restaurants"' which indicates that we should make a change in 'config/routes.rb'

```ruby
get 'restaurants' => 'restaurants#index'
```

which links up the '/restaurants' URL to the index action on the restaurants controller.  As we have more actions we could continue to add individual routes such as "get 'restaurants/new' => 'restaurants#new'", but rails gives us a shortcut for creating all the commonly used routes associated with a resource, e.g.

```ruby
resources :restaurants
```

##### Rails Routing

If you now run `bin/rake routes` you'll get a list of the different routes created by `resources :restaurants`. **This is one of the more powerful features of Rails:** it has conventions about routing that do a lot of work for you.  Here's the output from the bin/rake routes` command:

```sh

          Prefix  Verb    URI Pattern                     Controller#Action
     restaurants  GET     /restaurants(.:format)          restaurants#index
                  POST    /restaurants(.:format)          restaurants#create
 new_restaurants  GET     /restaurants/new(.:format)      restaurants#new
edit_restaurants  GET     /restaurants/:id/edit(.:format) restaurants#edit
      restaurant  GET     /restaurants/:id(.:format)      restaurants#show
                  PATCH   /restaurants/:id(.:format)      restaurants#update
                  PUT     /restaurants/:id(.:format)      restaurants#update
                  DELETE  /restaurants/:id(.:format)      restaurants#destroy

```

on the left we see special prefixes that we can use to refer to these routes in  our rails code.  More on those soon.  The Verb is the HTTP verb used to access this route given the specific URI pattern, which includes optional formatting and in some cases id variables.  Each route is mapped to a specific action method on a controller; for example a 'GET' request to '/restaurants/3/edit' would lead us to call the edit action on the restaurants controller with an id variable set to the value 3.

Notice also the way `resources :restaurants` has automatically created paths for `create`, `read`, `update` and `destroy` methods. You can see how fast it can be to get a simple [CRUD](http://en.wikipedia.org/wiki/Create,_read,_update_and_delete) app off the ground!


Running `rspec` again, we get another `RoutingError` – this time, there's no Restaurants controller.

```sh
uninitialized constant RestaurantsController
```

Time to make a controller! First let's commit our latest code to git, and switch Driver/Navigator Roles&nbsp;:twisted_rightwards_arrows:.

##### Creating controllers

Controllers are a bit like methods in a Sinatra server file – they contain the 'verbs' that handle incoming requests and do something in response to them.

`$ bin/rails g controller restaurants`

Note, `g` is short for generate.  This command will generate a file restaurants_controller.rb in app/controllers and also an rspec test in spec/controllers.  Let's delete the latter for the moment since the integration test we are writing is currently sufficient for testing the controller functionality.

Now, RSpec gives us a different error – that there's no action /index for restaurants.

```sh
The action 'index' could not be found for RestaurantsController
```

Which indicates that we need to add an index method in our controller. If we were using Sinatra we might be tempted to use something like the following:

```ruby
get '/restaurants' do

end
```

However rails is a little simpler, and we can just define a method like so:

```ruby
class RestaurantsController < ApplicationController
  def index
    raise 'Hello from the index action'
  end  
end
```

Let's now take a little detour to see what this generates if we view the live site in a browser.  To run our rails server use the following command:

```sh
bin/rails server
```

which creates a web server running on port 3000 that we can browse to at http://localhost:3000, which will have a friendly welcome page for us. [Note that to shut the server down we type Ctrl-C]

Go to http://localhost:3000/restaurants and we'll see an error response in the RestaurantsController index action.  Notice the error page is showing us exactly the line in the controller where the error we raised occurred.  To move on we'll need a view and a model to give a response back to the user.


We don't have to have a model immediately.  If we remove the raise statement from the controller and run our tests we should get the following error:

```
Missing template restaurants/index
```

This is because our controller index action is looking for an erb template to display. Let's create one of those views.

##### Creating views

Much like in Sinatra, views tell your app how to present content on the page.

`$ touch app/views/restaurants/index.html.erb`

(Note the double file extension of the form 'index.html.erb'. Note that unlike sinatra that we don't have to specify the erb file directly. )

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

We've just fudged this by setting the link's `href` value to '#', so it doesn't go anywhere – but it is a link all the same. Now our test is passing.  A good time to commit our code to git, and switch Driver/Navigator Roles&nbsp;:twisted_rightwards_arrows:.

Now let's try running out server again (if we didn't shut it down previously).  Note that we can use the following shorthand (where s is short for server)

```sh
bin/rails s
```

http://localhost:3000/restaurants should now show the content of the index.html.erb file in the browser.  There's a bit more work to get here than with Sinatra, but Rails is providing a layout that we'll use again and again. Each view is automatically wrapped in a layout file that by default is 'app/views/layouts/application.html.erb' which has the following contents:

```html
<!DOCTYPE html>
<html>
  <head>
  <title>YelpClone</title>
  <%= stylesheet_link_tag 'application', media: 'all', 'data-turbolinks-track' => true %>
  <%= javascript_include_tag 'application', 'data-turbolinks-track' => true %>
  <%= csrf_meta_tags %>
  </head>
  <body>

    <%= yield %>

  </body>
</html>
```

where the yield statement is place that the controller specific template will be inserted.

Note also that we can see the available routes in an error message if we get our route wrong, e.g. going to http://localhost:3000/restaurantss we'll get an error and the same routing table that we get from running `bin/rake routes`.  Note also we will only get these sorts of error messages in our development environment.

#### The second test – creating a restaurant on the backend

Add the following inside the 'restaurants' describe block in `spec/features/restaurants_feature_spec.rb`:

```ruby
...

context 'restaurants have been added' do
  before do
    Restaurant.create(name: 'KFC')
  end

  scenario 'display restaurants' do
    visit '/restaurants'
    expect(page).to have_content('KFC')
    expect(page).not_to have_content('No restaurants yet')
  end
end
...
```

Note that the creation of the object here is similar to DataMapper using the term Restaurant.create, although in this case we are using the Rails gem ActiveRecord to create an object that will be stored in the database.

Running the tests here should give us the error 'Uninitialized constant Restaurant' which indicates that we need a Restaurant model to satisfy our failing test.

##### Models and migrations

Models contain all the logic behind the 'nouns' that make up your app. In our case, these are going to be restaurants, reviews, etc. They add constraints to on how these objects can behave and tell the app how they should be represented in the database.

`$ bin/rails g model restaurant name:string rating:integer`

Which should generate terminal output something like the following:

```sh
invoke  active_record
create    db/migrate/20141215193023_create_restaurants.rb
create    app/models/restaurant.rb
```

Note that we can abbreviate generate to g (just as server was abbreviated to s) and that we can remove anything we generate using the same command but replacing 'generate' with 'destroy' (or d).

This command does a couple of things:

* it creates a new model, which tells the app what a 'restaurant' is and what properties it has.
* it creates a **migration** which contains instructions for Rake ('Ruby `make`') to update the database.

Specifically, we've added 'name' and rating properties for each restaurant. Each item gets an ID automatically.

**Vitally**, in the model 'restaurant' is singular, but the controller refers to 'restaurants'. Rails makes lots of assumptions based on how you plurarise things, so be very careful of this!

Unlike in Datamapper where we might add a property :name, String in the model file, in Rails active record the properties are all specified in migrations, so that we have a precise record of the changes that the database goes through as we evolve our models over time, and they can all be stored in our version control system.

Looking at db/migrate/20141215193023_create_restaurants.rb we see the following file has been created:

```ruby
class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name
      t.integer :rating

      t.timestamps
    end
  end
end
```

Note that as well as the string name property that we specified in the generator timestamps are automatically added for us (so when models are created and updated we'll be able to look up when that happened), and that also the migration itself is timestamped based on when we ran the generate command

* We can run our tests now, but we'll get a reminder that we need to actually run these migrations in order to support the Restaurant model that we want to work with:

```sh
bin/rake db:migrate
```

* Depending on our setup we might also have to run this migration (which creates the restaurant table in the database) on the test database like so:

```sh
bin/rake db:migrate RAILS_ENV=test
```

(Here, **string** and **integer** are types of data that your database can store. Rails will interpret these terms differently depending on what type of database you use, but in principle *string* has a length limit of 255 characters while integer is a number.)

It's easy to make a mistake during generation.  You can quickly erase your work using the above command but using instead `rails d` – for destroy – to remove the migration.

Then:

`$ bin/rake db:migrate`

which will run all of your database migrations.

(A word on migrations – if you need to change something, **don't edit the schema file**. If you want to remove database tables or change the schema in any way, instead write another migration that does that).

Let's commit our latest code to git, and switch Driver/Navigator Roles&nbsp;:twisted_rightwards_arrows: again.

##### Rendering restaurants in the view

Now, in `restaurants_controller.rb` we want to get all of the restaurants from the database. Let's do this in the wrong way first, but see if you can spot what we are doing wrong. Replace the contents of `restaurants/index.html.erb` with the following:

```html
<% if Restaurant.all.any? %>
  <% Restaurant.all.each do |restaurant| %>
    <%= restaurant.name %>
  <% end %>
<% else %>
  <h1>No restaurants yet</h1>
  <a href="#">Add a restaurant</a>
<% end %>
```

The tests should all pass now, but what cardinal sin have we committed?

We're talking directly to our model from our view, and this can lead to dangerous spaghetti code.  We should prefer to have our controller mediate communication between the model and view.

Let's add a method to suppport that (*the method below replaces the old method*):

```ruby
def index
  @restaurants = Restaurant.all
end
```

This creates an instance variable `@restaurants` that is accessible in our `index` view. Let's refer to it in `app/views/restaurants/index.html.erb`:

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

So in summary our URL http://localhost:3000/restaurants hits the Rails routing system, which passes the request to the index action in the restaurants controller which queries the database for any restaurant models.  The controller then passes an instance variable containing all the restaurant models to the erb view, where they can be correctlt formatted and the resulting HTML is passed back to the browser for display to the end user.

The tests should all now pass. A good time to commit our code to git, and switch Driver/Navigator Roles&nbsp;:twisted_rightwards_arrows:.

#### Creating a restaurant on the frontend

Currently we can browse a list of restaurants, but we don't have a way for users of our site to add restaurants. Let's add a test for that now.

`spec/features/restaurants_feature_spec.rb`:

```ruby
context 'creating restaurants' do
  scenario 'prompts user to fill out a form, then displays the new restaurant' do
    visit '/restaurants'
    click_link 'Add a restaurant'
    fill_in 'Name', with: 'KFC'
    click_button 'Create Restaurant'
    expect(page).to have_content 'KFC'
    expect(current_path).to eq '/restaurants'
  end
end
```

The test should fail like so:

```sh
Capybara::ElementNotFound:
Unable to find field "Name"
```

We have an 'Add a restaurant' link, but it doesn't go anywhere! Where should we link to? Run `bin/rake routes` if you want a clue...

If you're feeling advanced see if you can use a rails path helper rather than hardcoding a particular URL.  Once you've got the link set correctly you should get a new error like this:

```sh
AbstractController::ActionNotFound:
The action 'new' could not be found for RestaurantsController
```

This indicates that we should make a new method in `restaurants_controller.rb` to go alongside our `index` method.

`app/controllers/restaurants_controller.rb`:

```ruby
class RestaurantsController < ApplicationController
...
  def new
  end
...
```

This should give us a new test error. A good time to commit our latest code to git, and switch Driver/Navigator Roles&nbsp;:twisted_rightwards_arrows:.  Note that generally we don't want to commit broken tests to master; it's better practice to use a feature branch and only merge to master when green.  In this case the new test error should be something like:

```sh
ActionView::MissingTemplate:
Missing template restaurants/new, application/new with {:locale=>[:en], :formats=>[:html], :variants=>[], :handlers=>[:erb, :builder, :raw, :ruby, :coffee, :jbuilder]}. Searched in:
* "/Users/sam/Documents/Github/MakersAcademy/Sam/yelp_clone/app/views"
```

The problem is that our `new` method doesn't have a view associated with it. Let's make one.

`$ touch app/views/restaurants/new.html.erb`

This gives us a new test failure:

```sh
Failure/Error: fill_in 'Name', with: 'KFC'
Capybara::ElementNotFound:
Unable to find field "Name"
```

We're currently missing anything on that page to allow a user to submit restaurant details - let's make a form to fix that!

##### Making forms in Rails – `form_for`, `create`, and `permit`

HTML forms are the common way to submit data through web applications and Rails provides a lot of helpers to streamline the process of creating them.  Adjust our new template as follows:

`app/views/restaurants/new.html.erb`

```erb
<%= form_for Restaurant.new do |f| %>
  <%= f.label :name %>
  <%= f.text_field :name %>
  <%= f.submit %>
<% end %>
```

Here, we're using Rails' built-in `form_for` helper to build a form, which takes care of a lot of things, including verifying the authenticity of the form. You can read more about that in [RailsGuides](http://guides.rubyonrails.org/form_helpers.html).

Run your tests again – RSpec will now say it doesn't know what to do with the information submitted into that form.

```sh
Failure/Error: click_button 'Create Restaurant'
AbstractController::ActionNotFound:
The action 'create' could not be found for RestaurantsController
```

We need a `create` method!  Before implementing the following, please experiment with create doing a `raise params` instead of the below and see what that gives you.  The params is what is returned from the form submisson and it's very important to understand how it works.

```ruby
class RestaurantsController < ApplicationController
...
  def create
    Restaurant.create(params[:restaurant])
    redirect_to '/restaurants'
  end
...
```

Looks good. However there's a problem:

```sh
Failure/Error: click_button 'Create Restaurant'
ActiveModel::ForbiddenAttributesError:
ActiveModel::ForbiddenAttributesError
```

Hmmm... why doesn't this work?

Well, before Rails 3.2, it would have worked – and that was a huge security hole. `params[:restaurant]` passes in *all* the params received from the submitted form. If an unscrupulous user were to modify the form in their browser to include extra form fields, then our controller would blindly accept them as well!

As a result, we need to explicitly state which params we're going to allow our controller to accept, using `permit`. Let's create a utility method that does this for us and add it to our controller:

```ruby
  def restaurant_params
    params.require(:restaurant).permit(:name)
  end
```

Now replace

```ruby
Restaurant.create(params[:restaurant])
```

to instead say

```ruby
Restaurant.create(restaurant_params)
```

which tells Rails that we should allow only the field labelled 'name' to be accepted by the form.  Your tests should now all be green!  This would be a good time to commit our latest code to git, and switch Driver/Navigator Roles&nbsp;:twisted_rightwards_arrows:.

Now let's clean up that form a bit – using `Restaurant.new` inside the view logic isn't good practice, so instead we'll use `@restaurant` and let the controller deal with what that means.

`app/views/restaurants/new.html.erb`:

```erb
<%= form_for @restaurant do |f| %>
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
    @restaurant = Restaurant.create(restaurant_params)
    redirect_to '/restaurants'
  end
...
```

Much better.

#### Adding a description to restaurants – migrations

Currently, our database has a restaurants table with a few columns (much like a spreadsheet in Excel). Let's say it looks something like this:

Id | Name
--- | ---
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

#### Putting the 'CUD' in CRUD - updating and destroying restaurants

You remember [CRUD](http://en.wikipedia.org/wiki/Create,_read,_update_and_delete), right? That's all Yelp is, at its core. Just a fancy CRUD app.

So far we've got creating restaurants down, but we can't update or delete them, nor can we really 'read' them (though we can see an index page of them).

##### Reading (showing) restaurants

We want to be able to click on the name of a restaurant and be taken to its individual profile page, just like on the real Yelp.

Let's write a test:

```ruby
...
context 'viewing restaurants' do

  let!(:kfc){Restaurant.create(name:'KFC')}

  scenario 'lets a user view a restaurant' do
   visit '/restaurants'
   click_link 'KFC'
   expect(page).to have_content 'KFC'
   expect(current_path).to eq "/restaurants/#{kfc.id}"
  end

end
...
```

Great: so we're expecting that a user can click on the restaurant's name on the main page and get to the restaurant's profile page (whose path should be a subroot of restaurants with the ID of the restaurant in question). The test should fail – let's walk through the steps needed to make it pass.

First, we need to update the view to show that link.

In the `<% @restaurants.each do |restaurant| %>` loop in `app/views/restaurants/index.html.erb`, add this line (removing the existing `<%= restaurant.name %>`):

```erb
<%= link_to "#{restaurant.name}", restaurant_path(restaurant) %>
```

Now each restaurant should have its name displayed as a clickable link. But we're still missing a 'show' method in the restaurants controller, so let's add one.

`app/controllers/restaurants_controller.rb`:

```ruby
def show
  @restaurant = Restaurant.find(params[:id])
end
```

This method gets called when you go to `/restaurants/:restaurant_id`, and uses the ID passed in the URL to look up the correct record from the database.

Now all we need is a view for the restaurant show method. Let's make one.

`app/views/restaurants/show.html.erb`:

```erb
<p><%= @restaurant.name %></p>
<p><%= @restaurant.description %></p>
```

That'll do for this view for the moment, but we'll be coming back here as we expand the app to have reviews for restaurants.  This is a good time to commit our latest code to git, and switch Driver/Navigator Roles&nbsp;:twisted_rightwards_arrows:.

##### Updating restaurants

Now let's tackle updating restaurants. Testing first:

`spec/features/restaurants_feature_spec.rb`:

```ruby
...
context 'editing restaurants' do

  before {Restaurant.create name: 'KFC'}

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

First, we need to add an edit link for each restaurant. In `app/views/restaurants/index.html.erb` add to the code that loops through each restaurant:

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

  before {Restaurant.create name: 'KFC'}

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

Don't forget to display the `flash[:notice]` in `application.html.erb`, by adding it above `<%= yield %>`

```ruby
<%= notice %>
<%= yield %>
```

And now our tests pass and we've got all four CRUD methods!  Let's celebrate by  committing our latest code to git, and switching Driver/Navigator Roles&nbsp;:twisted_rightwards_arrows:.

#### Adding reviews to restaurants – associations

##### Test first!

Let's add some reviews for our restaurants.

`spec/features/reviews_feature_spec.rb`:

```ruby
require 'rails_helper'

feature 'reviewing' do
  before {Restaurant.create name: 'KFC'}

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

To `app/models/restaurant.rb`, add:

`has_many :reviews`

Finally, we need to modify our database to join together reviews and restaurants. Time for a migration:

`$ bin/rails g migration AddRestaurantIdToReviews restaurant:belongs_to`

`$ bin/rake db:migrate`

This does some Rails magic – it interprets AddRestaurantIdToReviews and parses it, so it understands that it needs to add 'RestaurantId' to the Reviews model. Then, Rake runs the migration.

Now, if you look at your `schema.rb` you'll see the new association between restaurants and reviews.

RSpec now gives an error about a missing template for create, so time to create that. Let's add the following line to the end of the `create` method in the reviews controller.

`app/controllers/reviews_controller.rb`:

```ruby
redirect_to restaurants_path
```

Now, once the method is run, Rails will take a user back to the list of restaurants.

Finally, update `app/views/restaurants/index.html.erb` to display the actual reviews, which you can get at by calling `restaurants.reviews.each` and iterating over them. You'll want to do the same for `app/views/restaurants/show.html.erb`. Use something like this inside of your each loop:

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

##### `belongs_to` and dealing with orphan reviews

Adding the following line to the `review.rb` model will tie the review to a restaurant:

```ruby
belongs_to :restaurant
```

But what if the 'parent' restaurant gets deleted? This would lead to reviews existing without a restaurant associated with them. Awful. So we need to tie the 'destroy' commands of both of these together – if a restaurant is deleted, all its child reviews go as well.

`app/models/restaurant.rb`:

```ruby
has_many :reviews, dependent: :destroy
```

Before we move on let's commit our latest code to git, and switch Driver/Navigator Roles&nbsp;:twisted_rightwards_arrows: again.

#### Stop users creating duplicate restaurants – validations

First, write a test. We'll add this within our existing feature spec for restaurants.

`spec/features/restaurants_feature_spec.rb`:

```ruby
feature 'creating restaurants' do

...

  context 'an invalid restaurant' do
    scenario 'does not let you submit a name that is too short' do
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
  scenario 'is not valid with a name of less than three characters' do
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
validates :name, length: {minimum: 3}
```

That will pass our model test – the model will now prevent restaurants with a name shorter than 3 characters from being saves – but not the original feature test. Let's fix our feature test now.

Currently our restaurants controller will save a restaurant passed to its `create` method regardless of whether it's correct or not – so let's change that.

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

To show an error, let's edit our view. Add this to the top of your `views/restaurants/new.html.erb` file:

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

What does this do? Well, in the case that our restaurant has any errors on it (that is, something went wrong when trying to save it) those errors are displayed on screen in a `section`, along with a count of how many errors there are.

(Note that this uses the Rails helper method `pluralize` – have a look online and see what you find!)  Let's also commit our latest code to git, and switch Driver/Navigator Roles&nbsp;:twisted_rightwards_arrows: one last time in this walkthrough.

##### Adding validations - restaurant uniqueness

We also don't want to allow users to create the same restaurant twice. So, let's write a test in our restaurant model spec!

```ruby
scenario "is not valid unless it has a unique name" do
  Restaurant.create(name: "Moe's Tavern")
  restaurant = Restaurant.new(name: "Moe's Tavern")
  expect(restaurant).to have(1).error_on(:name)
end
```

This test fails because we haven't implemented a validation on uniqueness yet. Fix it by updating this line in your restaurant model as follows:

```ruby
validates :name, length: {minimum: 3}, uniqueness: true
```

(RailsGuides has lots of information on the [different validations](http://guides.rubyonrails.org/active_record_validations.html) that are available to you.)

##### Adding validations – reviews

Lets also make sure that the rating cannot be more than 5. Add a `review_spec.rb` model test – this should go in `spec/models`.

```ruby
require 'rails_helper'

RSpec.describe Review, :type => :model do
  scenario "is invalid if the rating is more than 5" do
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
