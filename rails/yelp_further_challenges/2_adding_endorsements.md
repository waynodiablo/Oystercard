# Bonus Stage 2: Adding endorsements

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

# [Bonus Stage 3: Using AJAX](3_using_ajax.md)
