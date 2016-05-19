# Section 2: Test Setup

### Adding Gems for testing

We created a Rails app without its default testing framework.  Let's add in our preferred RSpec testing framework by adding some gems to our Gemfile.

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

This gets RSpec going by creating a `spec` directory and two helper files ('spec/spec_helper.rb' and 'spec/rails_helper.rb'). It also creates a `.rspec` file to configure RSpec's behaviour.

In your `spec/rails_helper.rb` file add the following require statement below the other require statements:

`require 'capybara/rails'`

This lets you use Capybara in your testing environment for the purpose of writing end user acceptance tests.

#### The first test – home page with a link

Let's start with a top level acceptance test of our site as it would be experienced through the eyes of our users.  Make a `spec/features/` directory, and make a new spec file inside it.

`spec/features/restaurants_feature_spec.rb`:

```ruby
require 'rails_helper'

feature 'restaurants' do
  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end
end
```
> Why are we requiring `rails_helper` in this file? What does `rails_helper` do?

Our test should fail - because we have not yet set up any routes. Let's find out how to do this in the next section!

### [Next Section - Routing](3_routing.md)
