Yelp
=====

### Completion time - 1 week

![Yelp screenshot](images/yelp.jpg)

Rails is a popular web framework. Sinatra, by comparison, is a DSL, not a framework – it gives you much more flexibility and fewer conventions when you're building a website. Rails is, well... like being on rails. There are fewer decisions for you to make, and more decisions that are made for you. It's 'opinionated'.

This week's project is a clone of [Yelp](http://www.yelp.co.uk). The goal is to introduce you to Rails, focusing especially on:

* Creating Rails applications
* The structure of Rails apps (models, views, controllers, the router, helpers)
* TDD on Rails, with RSpec & Capybara
* Associations in Rails
* Validations
* AJAX in Rails


# Version 1 - MVP

For the initial version we want to duplicate the core functionality of Yelp - users should be presented with a list of restaurants which they can leave reviews for.

Remember to drive the addition of all features using feature tests, and unit tests when needed.

### Specification

- Visitors can create new restaurants using a form, specifying a name and cuisine
- Restaurants can be edited and deleted
- Visitors can leave reviews for restaurants, providing a numerical score (1-5) and a comment about their experience
- The restaurants listings page should display all the reviews, along with the average rating of each restaurant
- [Validations](https://github.com/makersacademy/Walkthroughs/blob/master/validations.md) should be in place for the restaurant and review forms - restaurants must be given a name and cuisine, reviews must be given a rating from 1-5 (comment is optional)

## Getting started

### Installing Rails and initialising your app

`$ gem install rails` will install the Rails gem. Expect it to take a while. `rails --help` gives a nice help menu.

Make a new Rails app:

`$ rails new yelp_clone -d postgresql -T`

* `yelp_clone` is the name of your app – Rails will create this in a new directory. 
* By default, Rails uses Test::Unit for testing. The `-T` switch turns off the built-in Rails test suite, because we're going to use RSpec for this project.
* `-d` preconfigures your app for a particular type of database. By default, this is SQLite – which is problematic because Heroku doesn't support it. In this case, we're overriding the default to use PostgreSQL. 

### Where'd all the files go?

True to its 'opinionated' name, Rails is full of files and folders right from the get-go. Here's what some of them do:

* `app` – **where your code goes**. Contains models, views and controllers.
* `vendors` – a place for resources that you haven't written but are needed for the project, like JQuery.
* `public` – public resources. These will remain available even if the server goes down. Includes all your error pages by default.
* `log` – keeps server logs and terminal output.
* `config` – configuration information, including `database.yml` which includes database configuration details, a routes file,
* `bin` – contains your specified version of Rails.

### Boot the server

Start up the server!

`$ rails server`

or

`$ rails s`

will get you started. (Rails has lots of these little command-line shortcuts.) Now visit http://localhost:3000. Don't worry if you see an error – you'll likely need to run a `rake` task to get your database going, so visit the page and you'll be told which.

`$ rake db:create`

If this doesn't work, you may need to run 

`$ rake db:create RAILS_ENV=test`

instead.

### Add some testing gems

Now, add some gems to your Gemfile!

```ruby
gem 'rspec-rails', group: :test
gem 'capybara', group: :test
```

With these, we also want to run this command:

`$ rails generate rspec:install`

This gets RSpec going by creating a /spec directory and a helper file.

In your spec/rails_helper.rb file, add the line:

`require 'capybara/rails'`

This lets you use Capybara in your testing environment.

### The first test – home page with a link

Make a spec/features/ directory, and make a new spec file inside it.

`restaurants_feature_spec.rb`:

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

The config/routes.rb file has lots of clues as to how to write routes – have a look at them.

`routes.db`:

```ruby
resources:restaurants
```

If you now run `rake routes` you'll get a list of the different routes that this has created.

Running `rspec` again, we get another `RoutingError` – this time, there's no Restaurants controller. Time to make one!

`$ rails g controller restaurants`

(Here, 'g' is short for generate.)

Now, RSpec gives us a different error – that there's no action /index for restaurants. Let's fix that.

`app/controllers/restaurants_controller.rb`:

```ruby
class RestaurantsController < ApplicationController

def index
end

end
```

Now we get a different error – that /app/views/ is missing an index view.

`$ touch app/views/restaurants/index.html.erb`

(Note the requirement to use the double file extension here.)

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

And now, our test is passing.

### The second test – creating a restaurant

Add the following to `spec/features/restaurants_feature_spec.rb`:

```ruby
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
```

Now we need a Restaurants model to satisfy our failing test.

`$ rails g model restaurant name:string description:text`

This command will add 'name' and 'description' properties to the database for each restaurant, and make a migration file that you can run to create these properties. Each item gets an ID automatically. Note that 'restaurant' here is singular, but the controller refers to 'restaurants'.

If you make a mistake, you can type the above command but using 'rails d' – for destroy – to remove the migrate.

Then:

`$ rake db:migrate`

which will run all of your database migrations.

(A word on migrations – don't go into those files and edit them. If you want to remove database tables or change the schema, instead write another migration that does that.)

Now, in `restaurants_controller.rb` we want to get all of those restaurants from the database. Let's add a method for that (*the below replaces the old method*):

```ruby
def index
    @restaurants = Restaurant.all
end
```

And in `app/views/restaurants/index.html.erb`:

```
<% if @restaurants.any? %>
    <% @restaurants.each do |restaurant| %>
        <h2> <%= restaurant.name %> </h2>
    <% end %>
<% else %>
    No restaurants yet
<% end %>

<a href='#'>Add a restaurant</a>
```


# Version 2 - User login

Although our initial version serves its purpose - it's limited in a few respects. First any visitor can freely delete or edit restaurants, leaving our site open to vandalism. Additionally, a user can leave multiple reviews for the same restaurant - making it easy for restaurant scores to be skewed.

We can solve both of these problems by adding a user login system, as we did with Bookmark Manager. This time though, we'll use a popular gem - [Devise](https://github.com/makersacademy/Walkthroughs/blob/master/devise.md) - to accelarate the implementation of our user system.

*A note on testing: We generally want to avoid testing code we haven't written, so we won't write exhaustive tests for the functionality Devise provides. However, user login/registration are important features whose functionality we need to ensure - so it's worth adding a few high-level feature tests to make sure users can register and sign in.*

*Any additional functionality regarding users that we add (e.g. users can only write one review per restaurant) should be tested as normal*.


### Specification

* Users can register/login
* A user must be logged in to create restaurants
* Users can only edit/delete restaurants **which they've created**
* Users can only leave **one review per restaurant**
* Users can delete their own reviews
* Some indication should be given on the page (as part of the layout) whether the user is currently logged in, along with links to the available actions (i.e. Logout/Edit account is signed in, otherwise Sign In/Sign Up)
* The email address of the reviewer should be displayed as part of the review
* *Optional* - Users can't review a restaurant which they created

# Version 3 - Enhanced UX

Finally, let's focus on creating a better user experience. This will introduce us to [Rails helper methods] and [AJAX in Rails]. We'll also use CSS to enhance the look of our front-end.

### Specification

* Currently, when writing a review, we have to go to a separate page and trigger a page refresh. Migrate the functionality to happen asynchronously with AJAX. We'll also have to set up [Poltergeist](https://github.com/teampoltergeist/poltergeist) to enable us to run JS-enabled tests.
* Create a helper method to allow ratings and average ratings to be displayed as stars (e.g.) rather than numbers
* Use CSS to enhance the overall design of the site
* Refactor your more complex views to use partials
* *Optional* - Add the ability for users to add an image to a restaurant, by pointing to an external image URL


## Resources

* [Getting Started with Rails](http://guides.rubyonrails.org/getting_started.html)
* [Structure of Rails apps (diagram)](http://images.thoughtbot.com/ember-rails-terminology-differences/rails.png)
* [ActiveRecord basics](http://guides.rubyonrails.org/active_record_basics.html)
* [Associations](http://guides.rubyonrails.org/association_basics.html)
* [Validations](http://guides.rubyonrails.org/active_record_validations.html)
* [Layouts and Rendering](http://guides.rubyonrails.org/layouts_and_rendering.html)
* [Michael Hartl's Rails tutorial](http://www.railstutorial.org/)


## Walkthroughs (under construction)

* [Rails](https://github.com/makersacademy/Walkthroughs/blob/master/rails.md) <-- Under construction
* [More Rails](https://github.com/makersacademy/Walkthroughs/blob/master/more_rails.md) <-- Under construction
* [Validations](https://github.com/makersacademy/Walkthroughs/blob/master/validations.md) <-- Under construction
* One-to-many
* [Helpers](https://github.com/makersacademy/Walkthroughs/blob/master/helpers.md)
* Ajax
* Devise
* JBuilder
* [Rails Create Update](https://github.com/makersacademy/Walkthroughs/blob/master/rails_create_update.md)  <-- Under construction
