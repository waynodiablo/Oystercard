Rails Walkthrough
=================

DEPRECATED
==========

Please prefer https://github.com/makersacademy/course/blob/master/yelpv1.md

MVC Intro and Diagram
-------

Model View Controller (MVC) is an architectural pattern for dividing up responsibilities for serving a view, by having the presentation logic in a view, the business logic in a model and the two managed by a controller.  Very often the presentation of the final view will involve the controller coordinating the merging of model data with a view template for display to a user.

Rails uses the the MVC pattern, and let's start by installing that:

```sh
gem install rails
```

* We can create a new rails application like so

```sh
rails new yelpclone -T -d postgresql
```

where 'yelpclone' is the name of the app we are creating, '-T' avoids the creation of the default testing setup (we'll prefer rspec) and the '-d postgresql' indicates that we will use postgresql as our database rather than the default sqlite

* if we switch inside the newly created 'yelpclone' directory we'll see a number of new directories that rails has created for us:

  * app -- our models, views & controllers go in here, alone with js and css assets
  * bin -- contains some executables such as rails and rake for doing low level tasks
  * config -- configuration of our rails app - routes.rb is the most important
  * db  -- all our database specific configuration
  * lib -- place to put non-rails ruby code
  * log -- place for our logs
  * public -- non-dynamic html files get stored here
  * tmp    -- temporary stuff gets stored here
  * vendor -- third party assets (js & css) should go here

* Instead of the default minitest we're going with rspec, so we'll need to add the following to our Gemfile like so:

```ruby
group :test, :development do
  gem 'rspec-rails'
  gem 'capybara'
end
```

* and `bundle install` 

* next we'll use the rails generate command (see rspec-rails website):

```sh
bin/rails generate rspec:install
```

we use bin here to ensure we're using the version of rails associated with our current project.  This generate command will create an .rspec file and a spec directory with a spec_helper.rb and a rails_helper.rb.  

* We should edit the .rspec file like so:

```sh
--color
--format documentation
--helper spec_helper
```

* Let's start with a top level integration test of our site as it would be experienced through the eyes of our users:

```ruby
require 'rails_helper'

describe 'restaurants listing page' do
  it 'tells me there are no restaurants' do
    visit '/restaurants'
    expect(page).to have_content 'No restaurants yet'
  end
end
```

* Before we can even see any test fail here running rspec will give us errors such as 'FATAL: database "yelpclone" does not exist (ActiveRecord::NoDatabaseError)'

* We could create these databases by hand using psql, but we have some simple rake tasks that automate this for us:

```sh
bin/rake db:create db:migrate
```

* We should now see rspec fail with 'No route matches [GET] "/restaurants"' which indicates that we should make a change in 'config/routes.rb'

```ruby
  get 'restaurants' => 'restaurants#index'
```

which links up the '/restaurants' URL to the index action on the restaurants controller.  As we have more actions we could continue to add individual routes such as "get 'restaurants/new' => 'restaurants#new'", but rails gives us a shortcut for creating all the commonly used routes associated with a resource, e.g. 

```ruby
  resources :restaurants
```

* we can see all the routes generated for us by using the `bin/rake routes` command which gives output like the following:

```sh

          Prefix  Verb	 URI Pattern			 Controller#Action
     restaurants  GET	 /restaurants(.:format)		 restaurants#index
    		  POST	 /restaurants(.:format)		 restaurants#create
 new_restaurants  GET	 /restaurants/new(.:format)	 restaurants#new
edit_restaurants  GET	 /restaurants/:id/edit(.:format) restaurants#edit
      restaurant  GET	 /restaurants/:id(.:format)	 restaurants#show
     		  PATCH	 /restaurants/:id(.:format)	 restaurants#update
     		  PUT	 /restaurants/:id(.:format)	 restaurants#update
     		  DELETE /restaurants/:id(.:format)	 restaurants#destroy
```

on the left we see special prefixes that we can use to refer to these routes in future.  The Verb is the HTTP verb used to access this route given the specific URI pattern, which includes optional formatting and in some cases id variables.  Each route is mapped to a specific action method on a controller; for example a 'GET' request to '/restaurants/3/edit' would lead us to call the edit action on the restaurants controller with an id variable set to the value 3.

* Running the rspec tests again now we get the following error:

```sh
uninitialized constant RestaurantsController
```

* Thus, we must create a new controller:

```sh
bin/rails generate controller restaurants
```

* This will create a file restaurants_controller.rb in app/controllers and also an rspec test in spec/controllers.  Let's delete the latter for the moment

* Running the rspec tests again we get a new failure:

```sh
The action 'index' could not be found for RestaurantsController
```

* Which indicates that we need to add an index method in our controller. If we were using Sinatra we might be tempted to use something like the following:

```ruby
get '/restaurants' do

end
```

* However rails is a little simpler, and we can just define a method like so:

```ruby
def index
  raise 'Hello from the index action'
end  
```

* Let's now take a little detour to see what this generates if we view the live site in a browser.  To run our rails server use the following command:

```sh
bin/rails server
```

which creates a web server running on port 3000 that we can browse to at http://localhost:3000, which will have a friendly welcome page for us. [Note that to shut the server down we type Ctrl-C]

* Go to http://localhost:3000/restaurants and we'll see an error response in the RestaurantsController index action.  Notice the error page is showing us exactly the line in the controller where the error we raised occurred.  To move on we'll need a view and a model to give a response back to the user.

* We don't have to have a model immediately.  If we remove the raise statement from the controller and run our tests we should get the following error:

```
Missing template restaurants/index
```

* This is because our controller index action is looking for an erb template to display.  Note that unlike sinatra that we don't have to specify the erb file directly.  Also not that the erb files are of the form 'index.html.erb'

* Let's create the file 'index.html.erb' in app/views/restaurants and give it the following content

```html
No restaurants yet
```

* Our tests should now pass.  Let's also try running out server again (if we didn't shut it down previously).  Note that we can use the following shorthand (where s is short for server)

```sh
bin/rails s
```

* http://localhost:3000/restaurants should now show the content of the index.html.erb file in the browser.  There's a bit more work to get here than with Sinatra, but Rails is providing a layout that we'll use again and again.

* Note that we can put any html in the erb file that we want, e.g.

```html
<h1>No restaurants yet</h1>
```

and that each view is automatically wrapped in a layout file that by default is 'app/views/layouts/application.html.erb' which has the following contents:

```erb
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

where the yield statement is where the controller specific template will be inserted.

Note also that we can see the available routes in an error message if we get our route wrong, e.g. going to http://localhost:3000/restaurantss we'll get an error and the same routing table that we get from running `bin/rake routes`.  Note also we only get these sorts of error messages in our development environment.

* Okay, so now we can go back to our tests and create a context where we do actually have some restaurants:


```ruby
require 'rails_helper'

describe 'restaurants listing page' do
  context 'no restaurants' do
    it 'tells me there are no restaurants' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
    end
  end

  context 'are restaurants' do
    before do
      Restaurant.create(name: 'McDonalds') 
    end
    it 'should show the restaurant' do
      visit 'restaurants'
      expect(page).to have_content 'McDonalds'
    end 
  end
end
```

Note creation of object similar to DataMapper using the term Restaurant.create, although here we are using the Rails gem ActiveRecord to create an object that will be stored in the database

* Running the tests here should give us the error 'Uninitialized constant Restaurant'

* We can fix this issue with the command `bin/rails generate model Restaurant name:string`

Which will generate terminal output as follows:

```sh
  invoke  active_record
  create    db/migrate/201406030093124_create_restaurants.rb
  create    app/models/restaurant.rb
  invoke    rspec
  create      spec/models/restaurant_spec.rb
```

Note that we can abbreviate generate to g (just as server was abbreviated to s) and that we can remove anything we generate using the same command but replacing 'generate' with 'destroy' (or d).

* This model generation creates the following file app/models/restaurant.rb

```ruby
class Restaurant < ActiveRecord::Base
end
```

* Unlike in Datamapper where we might add a property :name, String in the model file, in Rails active record the properties are all specified in migrations, so that we have a precise record of the changes that the database goes through as we evolve our models over time, and they can all be stored in our version control system. 

* Looking at db/migrate/201406030093124_create_restaurants.rb we see the following file has been created:

```ruby
class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name
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

* Running out tests now we get the expected error 'expected to find text "McDonalds", in "No restaurants yet"' since our controller is still just displaying a static template

* Let's do this in the wrong way first, but see if you can spot what we are doing wrong:

```erb
<% if Restaurant.all.any? %>
  <% Restaurant.all.each do |restaurant| %>
    <%= restaurant.name %>
  <% end %> 
<% else %>
  <h1>No restaurants yet</h1>
<% end %> 
```

* the tests should all pass now, but what cardinal sin have we committed?

* We're talking directly to our model from our view, and this can lead to dangerous spaghetti code.  We should prefer to have our controller mediate communication between the model and view, e.g.


```ruby
def index
  @restaurants = Restaurants.all
end  
```

* and then we can simplify our view like so:

```erb
<% if @restaurants.any? %>
  <% @restaurants.each do |restaurant| %>
    <%= restaurant.name %>
  <% end %> 
<% else %>
  <h1>No restaurants yet</h1>
<% end %> 
```

So in summary our URL http://localhost:3000/restaurants hits the Rails routing system, which passes the request to the index action in the restaurants controller which queries the database for any restaurant models.  The controller then passes an instance variable containing all the restaurant models to the erb view, where they can be correctlt formatted and the resulting HTML is passed back to the browser for display to the end user.

Resources
----

* [Rails Guides](http://guides.rubyonrails.org/)
* [Michael Hartl Rails Tutorial](http://www.railstutorial.org/book)
















