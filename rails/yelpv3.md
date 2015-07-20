| [← Yelp V2](yelpv2.md) | [Yelp home](yelp.md) | Yelp V3 |
|------------------------|----------------------|--------:|

# Yelp

***As you know, as with all Makers Academy materials, there may be subtle errors in the following code snippets.  Please try to approach those as challenges on which to polish your debugging skills - pull requests always welcome.***


### V3 Walkthrough

In this version of our app, we want to tidy up the UX (user experience). It would be nice if our restaurants showed their average rating. It would also be cool if the page didn't refresh when we clicked on a link but updated dynamically.

Let's see what we can do.

- [Average ratings](#average-ratings)
    - [Feature and unit tests](#feature-and-unit-tests)
    - [Making an `average_rating` helper](#making-an-averagerating-helper)
    - [Displaying the average rating](#displaying-the-average-rating)
    - [Stars make things pretty](#stars-make-things-pretty)
    - [DIY helper methods](#diy-helper-methods)
- [Adding endorsements](#adding-endorsements)
    - [Test first](#test-first)
    - [Add a new route](#add-a-new-route)
    - [Creating endorsements controller](#creating-endorsements-controller)
    - [Creating the model](#creating-the-model)
    - [Showing endorsements on the main page](#showing-endorsements-on-the-main-page)
- [Using AJAX to update endorsements in real-time](#using-ajax-to-update-endorsements-in-real-time)
    - [Testing JS on web pages](#testing-js-on-web-pages)
    - [Write the test](#write-the-test)
    - [Let's add some JavaScript](#lets-add-some-javascript)
    - [Updating the controller](#updating-the-controller)
    - [Updating the view](#updating-the-view)
- [Refactoring using partials](#refactoring-using-partials)
- [Adding images to restaurants](#adding-images-to-restaurants)
    - [Install ImageMagick](#install-imagemagick)
    - [Getting started with Paperclip](#getting-started-with-paperclip)
    - [Adding file uploads](#adding-file-uploads)
- [Uploading images to Amazon Web Services S3](#uploading-images-to-amazon-web-services-s3)
    - [Sign up for AWS](#sign-up-for-aws)
    - [Install the gem](#install-the-gem)
    - [Setting AWS environment vars](#setting-aws-environment-vars)
    - [Deploy](#deploy)
- [Done](#done)

***Please work through this walkthrough with a pair partner. Please take turns on the keyboard as the driver as described in the [pairing pill](pills/pairing.md) :pill:.   Please swap driver/navigator roles at least as often as you see the :twisted_rightwards_arrows: sign.***

#### Average ratings

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
    remainder = (5 - rating)
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

#### Adding endorsements

We want users to be able to 'endorse' reviews. We're going to follow the same method as last time: testing, then adding a new resource to routes, then creating a model and a controller.

##### Test first

Let's make a new feature test for adding endorsements.  For our purposes here feature test == acceptance test.

`spec/features/endorsements_feature_spec.rb`:

```ruby
require 'rails_helper'

feature 'endorsing reviews' do
  before do
    kfc = Restaurant.create(name: 'KFC')
    kfc.reviews.create(rating: 3, thoughts: 'It was an abomination')
  end

  scenario 'a user can endorse a review, which updates the review endorsement count' do
    visit '/restaurants'
    click_link 'Endorse Review' #are we endorsing restaurants or the review of the restaurants?
    expect(page).to have_content('1 endorsement')
  end

end
```

##### Add a new route

Now that we've got our failing test, time to add a new route so we have a way of accessing our endorsements. We need to think about what kind of relationship endorsements and reviews are going to have before we do this - specifically, each review is going to have many endorsements.

To get a ping pong rotation based on red you should swap driver/navigator roles here &nbsp;:twisted_rightwards_arrows:.

Open up `config/routes.rb`. We want to add a nested resource route to reviews, so update your routes with the following code:

```ruby
resources :restaurants, shallow: true do
  resources :reviews do
    resources :endorsements
  end
end
```

Note that we are using [shallow nesting](http://guides.rubyonrails.org/routing.html#shallow-nesting). Follow that link and have a read about shallow nesting, and see what adding `shallow: true` does to your Rails routes - in short it means we can avoid ever having resources nested more than one level deep in our URL structure.

Check your tests and amend any routes that may have changed.

##### Creating endorsements controller

Great. Now let's make an endorsements controller.

```shell
$ bin/rails g controller endorsements
```

Cool. Let's create the first method for the controller:

`app/controllers/endorsements_controller.rb`:

```ruby
class EndorsementsController < ApplicationController

  def create
    @review = Review.find(params[:review_id])
    @review.endorsements.create
    redirect_to restaurants_path
  end

end
```

This is a pretty standard `create` method, but note that at the end it takes the user back to the list of restaurants. As a result, we won't need a `show` method for endorsements (which makes sense, as we probably don't want each individual endorsement to have a whole page devoted to it!).  With the controller in place let's commit to git and swap driver/navigator roles &nbsp;:twisted_rightwards_arrows:.

##### Creating the model

Now run

```shell
$ bin/rails g model endorsement review:belongs_to
```

to generate your model. This command tells Rails that there is a `belongs_to` relationship here – specifically, that each Endorsement will belong to a Review. Running this command generates an appropriate migration for updating your database to reflect this (the migration will make a table for endorsements and an index to link them to reviews).

We don't want our endorsements to have any other properties (unlike restaurants, which have a name and a rating, or reviews, with their comment and rating), so we don't need to specify any other columns.

We also need to update the Review model to reflect this. Let's open it up and add in the `has_many` relationship.

`/app/models/review.rb`:

```ruby
has_many :endorsements
```

Now run

```shell
$ bin/rake db:migrate
```

to run your database migrations.

##### Showing endorsements on the main page

We now need to update the view to show each review's endorsements. Have a look in `app/views/restaurants/index.html.erb` – you probably have something like:

```erb
<% @restaurant.reviews.each do |review| %>
```

```haml
- @restaurant.reviews.each do |review|
```
In that block you want to call the number of endorsements that each review has. Try using something like this:

```erb
<p><%= pluralize review.endorsements.count, 'endorsement' %></p>
```
```haml
%p= pluralize review.endorsements.count, 'endorsement'
```

Note that because we are relying on basic rails functionality up to this point that we haven't had to write any unit tests yet - we are assuming that Rails own unit tests will already cover this functionality effectively and our acceptance test is sufficient for us to get the necessary test coverage.  We're also being a bit naughty in that we're adding a display to the view without an acceptance test to cover it ...!

**Exercise:** Go back and make an acceptance test that checks for the correct number of endorsements is displayed for each review.  This is not TDD, but sometimes it happens.  You wrote some functionality in your excitement.  It's not the end of the world, but if you are a professional software engineer you will go back, put the acceptance test in place, watch it pass AND THEN comment out the code in your app, **watch it fail**, and then get it to pass again.  This ensures you have not written a vacuous test after the fact and keeps you on the straight and narrow!

#### Using AJAX to update endorsements in real-time

This is where it gets fun. :twisted_rightwards_arrows: We can use AJAX to update the page in real-time without having to refresh. Broadly, it works like this:

1. User clicks 'Endorse' link next to a review
2. Click event invokes some JavaScript in the page, which tells the server that the endorsements count for that review should go up
3. The server responds with a JSON object containing the new endorsements count
4. Client-side JavaScript listens out for that JSON, parses it, and updates the count on the page

It's pretty neat. How do we get started?

##### Testing JS on web pages

We test!

But not so fast. Capybara's default web driver has trouble with JavaScript, so we need something that won't hiccup on this task. In this case, we'll use [Poltergeist](https://github.com/teampoltergeist/poltergeist), which is a headless browser for Capybara based on [PhantomJS](http://phantomjs.org/).

Since Poltergeist relies on PhantomJS, we'll need to install this ourselves using Homebrew. Run in your terminal:

```shell
brew install phantomjs
```

Now to get poltergeist working, we need to add two gems to our Gemfile: `poltergeist` (for the reasons discussed above) and `database_cleaner`, because running Poltergeist means running code outside of our normal test process, so the database otherwise won't be properly cleared between tests as it is currently.

Add these to your `Gemfile` in the test group:

```ruby
gem 'poltergeist'
gem 'database_cleaner'
```

Don't forget to run `bundle install` to install those shiny new gems.

In your RSpec helper file, you need to require Poltergeist, and tell Capybara that it's your JavaScript web driver of choice.

`spec/rails_helper.rb`:

```ruby
require 'capybara/poltergeist'
Capybara.javascript_driver = :poltergeist
require 'support/database_cleaner'
```

In that same file, change this line:

```ruby
config.use_transactional_fixtures = true
```

to be `false`.  Transactions are a unit of work within a [database management system](http://en.wikipedia.org/wiki/Database_transaction).  Rails uses these to ensure that the database removes everything created during individual tests.

Now you need to configure Database Cleaner as below. (The instructions here are taken from the [Virtuous Code blog](http://devblog.avdi.org/2012/08/31/configuring-database_cleaner-with-rails-rspec-capybara-and-selenium/) where you can find a full explanation of what's happening).

`spec/support/database_cleaner.rb`:

```ruby
RSpec.configure do |config|

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, :js => true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

end
```

Phew! Now we're good to go. Run your tests again and make sure nothing is broken.

##### Write the test

In `spec/features/endorsements_feature_spec.rb`, you want to change your existing test to look something like this:

```ruby
...
it 'a user can endorse a review, which increments the endorsement count', js: true do
  visit '/restaurants'
  click_link 'Endorse'
  expect(page).to have_content("1 endorsement")
end
...
```

Notice the `js: true` bit. That's important – it tells Capybara to use Poltergeist/Phantom for this test so the JavaScript stuff that we're about to add works. Commit and :twisted_rightwards_arrows:.

##### Let's add some JavaScript

Rails actually accepts CoffeeScript natively. Have a look in `app/assets/javascripts` – you'll see some files ending in `.coffee`.

This time, we're going to write pure JS, so let's change that file extension:

`app/assets/javascripts/endorsements.js.coffee` -> `app/assets/javascripts/endorsements.js`

Sweet. Now let's actually put some JavaScript in that file. **But first**, make sure you remove the comments at the top of the file! CoffeeScript comments start with a '#', but JavaScript comments start with '//' – so those comments will break your JavaScript.

```js
$(document).ready(function() {

  $('.endorsements-link').on('click', function(event){
      event.preventDefault();

      var endorsementCount = $(this).siblings('.endorsements_count');

      $.post(this.href, function(response){
        endorsementCount.text(response.new_endorsement_count);
    })
  })
})
```
If you're interested to see what it would look like in CoffeeScript, here it is:
```coffeescript
$ ->
  $('.endorsements-link').on 'click', (event) ->
    event.preventDefault()

    endorsementCount = $(this).siblings '.endorsements_count'

    $.post this.href, (response) ->
      endorsementCount.text response.new_endorsement_count

```
There's a lot going on here, so let's break it down line by line.

* `$(document).ready` is a jQuery method that makes sure the page is fully loaded before the JS fires.
* `$('.endorsements-link').on('click',` – when the user clicks on an HTML element with the class 'endorsements-link'...
* `var endorsementCount` – make a new variable called `endorsementCount`...
* `$(this).siblings('.endorsements_count')` – and tell that to refer to the HTML element with class 'endorsements_count' that's next to the current element (we need to do this weirdness because we're getting a `span` element that's *next to* the link being clicked)...
* `$.post` – and then make a post request...
* `this.href` – to the very same URL specified by the link that just got clicked...
* `response.new_endorsement_count` – and grab the response of that request...
* `endorsementCount.text(response.new_endorsement_count)` – and overwrite the endorsementCount element we defined before with that response (which will be the number of endorsements).

And... breathe. And ... commit and :twisted_rightwards_arrows:.

##### Updating the controller

Now we need to tell our controller to serve up JSON objects that our JS on the client side can parse.

`app/controllers/endorsements_controller.rb`:

```ruby
class EndorsementsController < ApplicationController

  def create
    @review = Review.find(params[:review_id])
    @review.endorsements.create
    render json: {new_endorsement_count: @review.endorsements.count}
  end

end
```

The `create` method now serves up a JSON which has a single item, `new_endorsement_count`, whose value is computed when the method is called.

##### Updating the view

Now we need to update the view so that the JS has something to actually modify when it gets a JSON from the server.

In `app/views/restaurants/index.html.(erb/haml)`, add this code replacing your existing code where appropriate:

```erb
<ul>
  <% restaurant.reviews.each do |review| %>
    <li>
      <%= review.thoughts %> <%= review.rating %>
      <%= link_to "Endorse", review_endorsements_path(review), class: 'endorsements-link' %>
      <span class="endorsements_count"> <%= review.endorsements.count %> </span> <%= 'endorsement'.pluralize(review.endorsements.count) %>
    </li>
  <% end %>
</ul>
```

```haml
%ul
  - restaurant.reviews.each do |review|
    %li
      #{review.thoughts} Average rating: #{star_rating(restaurant.average_rating)}
      = link_to "Endorse", review_endorsements_path(review), class: 'endorsements-link'
      %span.endorsements_count= review.endorsements.count 
      = 'endorsement'.pluralize review.endorsements.count
```
Here, the `span` tag with class 'endorsements_count' is populated with the current review endorsements count when the page is first loaded. Then, when the user clicks on 'Endorse', our JS is fired and posts to the URL linked to by the 'Endorse' link. It takes the response and replaces the number in the `span` with it.

Your tests should now be passing. Commit and :twisted_rightwards_arrows:.

#### Refactoring using partials

A good rule of thumb is that if you do something twice, you should consider refactoring (if you're doing it three times, *definitely* refactor).

We've used the same form for restaurants twice (in create and edit) – exactly the same code. This is unnecessary duplication, and it also makes life more difficult for us. If we updated our restaurants model – say we wanted it to include an address – then we have two forms to update. If we forgot to do that, things would break.

Much better would be to have the same form abstracted out, and *refer* to it twice. Rails makes this easy with [partials](http://guides.rubyonrails.org/layouts_and_rendering.html#using-partials).

Let's do that now. Create `app/views/restaurants/_form.html.erb` (the prepended '_' indicates this is a partial) and copy and paste the form there.

Now, in both places we refer to the form (`app/views/restaurants/edit.html.erb` and `app/views/restaurants/new.html.erb`), remove the form and type this line instead:

```erb
<%= render "form" %>
```

So much cleaner! Rails knows to refer to the `_form` file we just created and slot it into the layout when the page is rendered.  Commit and :twisted_rightwards_arrows:.

#### Adding images to restaurants

It's all looking a bit plain-text at the moment. Why can't we add an image to our restaurants?

This actually requires quite a lot of magic to happen – user uploads, resizing and compression of images on the server side, storing the images somewhere – so we'll do this in steps.

We're going to 'spike' that part of the walkthrough – that is, do it in one big go without testing – but you'll be expected to write tests for it afterwards (it requires a bit of research to get your testing suite to be able to upload images to the site).

##### Install ImageMagick

ImageMagick is a code library that deals with image compression. Install it using Homebrew:

```shell
$ brew install imagemagick
```

This might take a little while.

##### Getting started with Paperclip

Paperclip is a gem that makes file uploads to Ruby apps a bit simpler.

Add the Paperclip gem to your Gemfile—

`gem 'paperclip'`

—and run `bundle install`.

Have a look at the boilerplate text from the [Paperclip repo](https://github.com/thoughtbot/paperclip) below:

```ruby
class User < ActiveRecord::Base
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
end
```

This looks pretty good. Add this into your Restaurant model, but change `:avatar` to `:image` so you get something like this:

```ruby
...
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
...
```

Now, we need a migration to add this image to our restaurant model – each restaurant item in the database needs to know what image is associated with it, so we need an image column. Generate it using

```shell
$ rails generate paperclip restaurant image
```

and then run `rake db:migrate` to add the new column to your database.

##### Adding file uploads

Have a look at `app/views/restaurant/_form.html.(erb/haml)`. Change the form tag to the following – this lets you send files to the server using your HTML form:

```erb
<%= form_for @restaurant, html: {multipart: true} do |f| %>
```

```haml
= form_for @restaurant, html: {multipart: true} do |f|
```
and then add

```erb
<%= f.file_field :image %>
```

```haml
= f.file_field :image
```
to your form, which will add a file picker for users to select an image from their local machine and upload it.

Go to your restaurants controller and add `:image` to your `permit` statement, to tell Rails that it's okay that users are submitting forms with images.

Now, when a user creates a restaurant and includes an image, it gets saved to the `/public` directory.

In `views/restaurants/index.html.(erb/haml)`, you now want to include a photo.

```erb
<%= image_tag restaurant.image.url(:thumb) %>
```

```haml
= image_tag restaurant.image.url(:thumb)
```
**Exercise – work out how to test this with Capybara!** Then commit and :twisted_rightwards_arrows:.

#### Uploading images to Amazon Web Services S3

So far we've got images being saved straight to your web server – which is okay, and certainly fine for testing, but in practice may not be what you'd do. For example, Heroku has a strict size limit on dynos, which you'll quickly exceed if you upload files directly onto Heroku. So we want to store images somewhere else.

For this, we'll use Amazon Web Services (AWS) **S3**, which stands for **Simple Storage Service**.

Getting Paperclip to work with S3 is pretty well documented in [this Heroku tutorial](https://devcenter.heroku.com/articles/paperclip-s3). We'll give you the choice parts here.

##### Sign up for AWS

An obvious first step. [http://aws.amazon.com](http://aws.amazon.com) is probably where you want to be looking.

##### Install the gem

AWS has a gem (of course), so let's start by installing that.

`Gemfile`:

```ruby
gem 'aws-sdk'
```

Now run `bundle install`.

##### Setting AWS environment vars

We need to tell Paperclip what our AWS keys are. First we add references to some environment variables that we'll set in a moment:

`config/environments/production.rb` and `config/environments/development.rb`:

```ruby
config.paperclip_defaults = {
  :storage => :s3,
  :s3_credentials => {
    :bucket => ENV['S3_BUCKET_NAME'],
    :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
    :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
  }
}
```

What we're doing here is setting environment variables so we don't have to store our AWS secrets naked in a configuration file – which is checked into version control and visible to the public internet. That would be **a Very Bad Thing**.

You will need to check your S3 hostname is set correctly if you are on a non-US server.

##### Deploying to Heroku

Ideally you've been deploying to Heroku as you've added each new piece of functionality.  Heroku deploys are a lot smoother than what we had to do back in the day but they can have tricky issues.  In particular features that require secret keys for 3rd party services may take a few goes to deploy successfully and securely. Here's some hints to help you on your way:


Unfortunately we can't use secrets.yml on Heroku, instead we need to manually tell Heroku about our secret variables, for example in the case of getting AWS working we would do:

```shell
$ heroku config:set S3_BUCKET_NAME=your_bucket_name
$ heroku config:set AWS_ACCESS_KEY_ID=your_access_key_id
$ heroku config:set AWS_SECRET_ACCESS_KEY=your_secret_access_key
```
This will set these values to the ENV hash.

You can use gems such as [Figaro](https://github.com/laserlemon/figaro) or [Dotenv](https://github.com/bkeepers/dotenv) to manage your secrets rather than `secrets.yml`
##### Deploy

Commit, run `git push heroku master` and watch as your users are able to upload items and have them saved on S3!

However you will still need to find a way to get all of the values in your secrets.yml file working with Heroku which uses ENV variables instead. Remember to be careful not to expose any of your secrets

#### Finally

**Exercise:** Get your app looking as close as possible to the actual Yelp site using bootstrap and other CSS wizardry.

## Related Videos

* [Rails Helpers and Acceptance/Unit Testing Cycle](https://www.youtube.com/watch?v=M7pUtGRO-zg)
* [Rails Ajax and AWS](https://www.youtube.com/watch?v=OIjiJotzTnA)
