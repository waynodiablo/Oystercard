* "what we learned Security" - WTF!?
* missing instruction to require User model in server.rb
* sequence of error messages after creating User model that are brushed over by the tutorial
* suggests on how to debug after creating the form for creating users.
* Instruction to add bcrypt to Gemfile is past the point at which it's needed, also refers to deprecated bcrypt ('bcrypt-ruby' rather than 'bcrypt').
* Randomly throws in "layout" file - without much introduction.

##Adding user accounts

Let's implement basic user account functionality using what we learned in Security. We want users to be able to register on the website, so that every link and tag could be attributed to a specific user. This section will rely on your understanding of what we (will) have discussed in Security.

The goal of this exercise is to demonstrate how to create a user management system from scratch without using user management libraries (we'll be using them later in the course, though).

We will add the following functionality:
* Sign up with an email and a password
* Sign in
* Sign out
* A welcome message for the logged in user
* Every link and every tag will be linked to the user that created it, unless the user was anonymous

We want to have a separate database table for all our users. For this we'll need to have a User model that will store the email and password-related information (hash, salt).

# Signing up

Let's begin with a test, as usual. The integration test should go to ```spec/features/user_management_spec.rb```.
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

  def sign_up(email = 'alice@example.com',
              password = 'oranges!')
    visit '/users/new'
    expect(page.status_code).to eq(200)
    fill_in :email, with: email
    fill_in :password, with: password
    click_button 'Sign up'
  end

end
```

Running the test tells us that we haven't got the User class. Let's create a basic model in ```lib/user.rb``` (where the Link model is).

```ruby
class User

  include DataMapper::Resource

  property :id, Serial
  property :email, String

end
```

A word of caution. If you declare a property, you shouldn't declare an accessor (or reader, or writer) for that property because you'll override datamapper's default functionality. Ruby will not throw any warning in this case. In other words, if you do this:

```ruby
# this is wrong!
property :description, Text
attr_reader :description
```

you will not be able to get the description back from the database.

The next error in our test suite is not having the form to fill in to sign up. That's easy to fix by updating ```app/server.rb``` (or just ```server.rb``` if you chose to place it in the root folder). <---- WAT? Ptolemy.

```ruby
get '/users/new' do
  # note the view is in views/users/new.erb
  # we need the quotes because otherwise
  # ruby would divide the symbol :users by the
  # variable new (which makes no sense)
  erb :'users/new'
end

```

and ```views/users/new.erb```.

```html
<h1>Please sign up</h1>

<form action='/users' method='post'>
  Email: <input name='email' type='text'>
  Password: <input name='password' type='password'>
  <input type='submit' value='Sign up'>
</form>
```

Now the test will be able to fill out the form but the form submits to the route POST /users that doesn't exist. Let's fix this in ```app/server.rb```.

```ruby
post '/users' do
  User.create(email: params[:email],
              password: params[:password])
  redirect to('/')
end
```

This code is straighforward enough. However, we already have a problem. Our User model doesn't know anything about the password, so our test still fails. Let's extend our User class ```lib/user.rb```.

```ruby
# bcrypt will generate the password hash
require 'bcrypt'
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

Now our user is created in the database but the test would still fail because it expects to see a welcome message for the user. Let's log in the user automatically on sign up. To do this, we'll store the user id in the session (we looked at how sessions work in Battleships – web version).

First, we need to enable the sessions and set the encryption key to make sure nobody can tamper with our cookies. This is done by changing Sinatra's configuration, so it goes into ```server.rb```.

```ruby
enable :sessions
set :session_secret, 'super secret'
```

Then, let's save the user id in the session after it's created within ```server.rb```:

```ruby
post '/users' do
  user = User.create(email: params[:email],
                     password: params[:password])
  session[:user_id] = user.id
  redirect to('/')
end
```

Then, let's create a helper that will give us access to the current user, if logged in (server.rb).

```ruby
helpers do

  def current_user
    @current_user ||= User.get(session[:user_id]) if session[:user_id]
  end

end
```

Finally, let's use this helper in the layout file (/views/layout.erb)

```html
<body>
  <% if current_user %>
    Welcome, <%= current_user.email %>
  <% end %>
  <%= yield %>
</body>
```

Finally, make sure 'bcrypt-ruby' is in your Gemfile and it's installed. Our test finally passes.

Let's clean the code up a little bit by extracting the helpers and datamapper-related code to external files and moving server.rb, views and helpers to /app. Now the codebase looks a little bit cleaner.

Current state is on Github
https://github.com/makersacademy/bookmark_manager/tree/1b6fada4c9fdaa5e44cc62fdd31ddf5d7706d139

[ [Next Stage](bookmark_manager_stage_3.md) ]

[ [Return to outline](bookmark_manager.md) ]
