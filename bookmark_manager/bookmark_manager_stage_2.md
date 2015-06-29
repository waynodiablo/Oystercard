#Adding user accounts

Before we set up user accounts, have a read through this [post](https://crackstation.net/hashing-security.html). Make sure you are sitting comfortably :-)

Now we have an idea of security, let's implement basic user account functionality. We want users to be able to register on the website, so that every link and tag could be attributed to a specific user.

The goal of this exercise is to demonstrate how to create a user management system from scratch without using user management libraries (we'll be using them later in the course, though).

We will add the following functionality:
* Sign up with an email and a password
* Sign in
* Sign out
* A welcome message for the logged in user
* Every link and every tag will be linked to the user that created it, unless the user was anonymous

We want to have a separate database table for all our users. For this we'll need to have a User model that will store the email and password-related information (hash, salt).

## Signing up

Let's begin with a test, as usual. The feature test should go to ```spec/features/user_management_spec.rb```.
```ruby
feature 'User signs up' do

  # Strictly speaking, the tests that check the UI
  # (have_content, etc.) should be separate from the tests
  # that check what we have in the DB. The reason is that
  # you should test one thing at a time, whereas
  # by mixing the two we're testing both
  # the business logic and the views.
  #
  # However, let's not worry about this yet
  # to keep the example simple.


  scenario 'when being a new user visiting the site' do
    expect { sign_up }.to change(User, :count).by(1)
    expect(page).to have_content('Welcome, alice@example.com')
    expect(User.first.email).to eq('alice@example.com')
  end

  def sign_up(email: 'alice@example.com',
              password: 'oranges!')
    visit '/users/new'
    expect(page.status_code).to eq(200)
    fill_in :email,    with: email
    fill_in :password, with: password
    click_button 'Sign up'
  end

end
```

Running the test tells us that we haven't got the User class.
* :white_check_mark: Let's create a basic model in ```app/models/user.rb```.

```ruby
class User
  include DataMapper::Resource

  property :id, Serial
  property :email, String

end
```

* :white_check_mark: The test still fails with 'uninitialized constant User' - what have we forgotten to do?

The next error in our test suite is a Status 404 - not found.
* :white_check_mark: That's easy to fix by updating `app.rb`:

```ruby
get '/users/new' do
  erb :'users/new'
end

```

* :white_check_mark: and ```app/views/users/new.erb```.

```html
<h1>Please sign up</h1>

<form action='/users' method='post'>
  Email: <input name='email' type='text'>
  Password: <input name='password' type='password'>
  <input type='submit' value='Sign up'>
</form>
```

Now the test will be able to fill out the form but the form submits to the route POST /users that doesn't exist yet.
* :white_check_mark: Let's fix this in ```app.rb```:

```ruby
post '/users' do
  User.create(email: params[:email],
              password: params[:password])
  redirect to('/links')
end
```

This code is straighforward enough. However, we already have a problem. Our User model doesn't know anything about the password, so our test still fails.
* :white_check_mark: Let's extend our User class.

```ruby
# bcrypt will generate the password hash
require 'bcrypt' # make sure 'bcrypt' is in your Gemfile

class User

  include DataMapper::Resource

  property :id, Serial
  property :email, String
  # this will store both the password and the salt
  # It's Text and not String because String holds
  # 50 characters by default
  # and it's not enough for the hash and salt
  property :password_digest, Text

  # when assigned the password, we don't store it directly
  # instead, we generate a password digest, that looks like this:
  # "$2a$10$vI8aWBnW3fID.ZQ4/zo1G.q1lRps.9cGLcZEiGDMVr5yUP1KUOYTa"
  # and save it in the database. This digest, provided by bcrypt,
  # has both the password hash and the salt. We save it to the
  # database instead of the plain password for security reasons.
  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end

end
```

Now our user is created in the database but the test would still fail because it expects to see a welcome message for the user. Let's log in the user automatically on sign up. To do this, we'll store the user id in the session.

First, we need to enable the sessions and set the encryption key to make sure nobody can tamper with our cookies.
* :white_check_mark: This is done by changing Sinatra's configuration, so it goes into ```app.rb```.

```ruby
# within the body of the Sinatra class
enable :sessions
set :session_secret, 'super secret'
```

Then, let's save the user id in the session after it's created within ```app.rb```:

```ruby
post '/users' do
  user = User.create(email: params[:email],
                     password: params[:password])
  session[:user_id] = user.id
  redirect to('/')
end
```

* :white_check_mark: Now, create a helper method, `#current_user`, that returns an instance of User associated with the currently logged-in user.

Finally, let's build a layout file in the views folder so that our welcome will be shown on every page.

```html
/*layout.erb*/
<!DOCTYPE html>
<html>
  <head>
    <title>Bookmark Manager</title>
  </head>

  <body>
    <% if current_user %>
      Welcome, <%= current_user.email %>
    <% end %>
    <%= yield %>
  </body>
</html>
```

Our test finally passes. Don't forget to refactor!

[ [Next Stage](bookmark_manager_stage_3.md) ]

[ [Return to outline](bookmark_manager.md) ]
