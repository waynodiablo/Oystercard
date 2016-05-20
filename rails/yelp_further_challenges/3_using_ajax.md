# Bonus Stage 4: Using AJAX to update endorsements in real-time

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
Here, the `span` tag with class 'endorsements_count' is populated with the current review endorsements count when the page is first loaded. Then, when the user clicks on 'Endorse', our JS is fired and posts to the URL linked to by the 'Endorse' link. It takes the response and replaces the number in the `span` with it. Your tests should now be passing.

# [Bonus Stage 4: Using Partials](4_using_partials.md)
