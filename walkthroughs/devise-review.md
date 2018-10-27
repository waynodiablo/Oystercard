* let's get some devise user support in there

```ruby
describe 'creating posts' do
  context 'when logged out' do
    it 'is impossible' do
      visit '/posts'
      click_link 'New post'
      expect(page).to have_content 'Sign in'
      expect(page).not_to have_field 'Title'
    end
  end
```

* check that this test fails

* some quick tests to make sure devise working as expected - add to user_feature_spec.rb

```ruby
require 'rails_helper'

describe 'users registration/login' do

  it 'can sign up' do
    visit '/users/sign_up'
    fill_in 'Email', with: 'alex@example.com'
    fill_in 'Password', with:  '12345678'    
    fill_in 'Password confirmation', with:  '12345678'
    click_button 'Sign up'
    expect(page).to have_content 'Signed up successfully'
  end

  it 'can sign in' do
    User.create(email: 'alex@example.com', password: '12345678')
    visit '/users/sign_in'
    fill_in 'Email', with: 'alex@example.com'
    fill_in 'Password', with:  '12345678'    
    click_button 'Sign in'
    expect(page).to have_content 'Signed in successfully'
  end
end
```

* do devise install (add gem, bin/rails g devise:install, follow instructions and generate user model)

* adjust config/locales/devise.en.yml to match our expected messages
* 
```
signed_up: "Signed up successfully."
```
* can use for DRYing out messages, and internationalization of site

* check correct tests have passed, and failed

* to fix text about not being able to post without being logged in, add authentication to PostsController

```
before_action :authenticate_user!, except: [:index]
```

* logged out test will pass, but logged in ones will fail
* fix those with capybara support for devise - add the following to rails helper
```
  config.include Warden::Test::Helpers
  Warden.test_mode!
```
* add user creation in logged in context
```
    before do
      user = User.create(email: 'alex@example.com', password: '12345678')
      login_as user
    end
```
* check tests pass
* you might also want to add this to rails helper to ensure users are logged out between tests:
```
  config.after(:each) do
    Warden.test_reset!
  end
```
* create relationship between posts and user - add test to check for content posted by user in 'adds the post to the homepage'
* 
```ruby
expect(page).to have_content 'Posted by: alex@example.com'
```

* check that fails

* add relations to user and posts

`belongs_to :user` in post.rb
`has_many :posts` in user.rb

* adjust controller so that create method has:

```ruby
@post.user = current_user
```

* should get this failure: `can't write unknown attribute 'user_id'`

* do migration

`bin/rails g migration AddUserIdToPosts user:belongs_to`

* migrate and then run tests to check you get this error:  'expected to find text "Posted by: alex@example.com" in "My new post Lorem ipsum New post"'

* add to view 
```
<p>Posted by: <%= post.user.email %></p>
```

* that test should pass, but should get new error on different test: 'undefined method `email' for nil:NilClass'

* need to adjust earlier test to that post has a user

```ruby
  context 'with posts' do
    before do
      user = User.create(email: 'alex@example.com', password: '12345678')
      user.posts.create(title: 'Cool post', description: 'Hello world') 
    end
```
* tests should now all pass
* delete existing posts from dev system should allow that to work too






















![Tracking pixel](https://githubanalytics.herokuapp.com/course/walkthroughs/devise-review.md)
