### Signing in

The users can sign up on our website but there's no way to sign in if you happen to be logged out (not that we have logging out functionality yet but it's coming). Let's write a test for signing in.

```ruby
feature 'User signs in' do

  before(:each) do
    User.create(email: 'test@test.com',
                password: 'test',
                password_confirmation: 'test')
  end

  scenario 'with correct credentials' do
    visit '/'
    expect(page).not_to have_content('Welcome, test@test.com')
    sign_in('test@test.com', 'test')
    expect(page).to have_content('Welcome, test@test.com')
  end

  scenario 'with incorrect credentials' do
    visit '/'
    expect(page).not_to have_content('Welcome, test@test.com')
    sign_in('test@test.com', 'wrong')
    expect(page).not_to have_content('Welcome, test@test.com')
  end

  def sign_in(email, password)
    visit '/sessions/new'
    fill_in 'email', with: email
    fill_in 'password', with: password
    click_button 'Sign in'
  end

end
```

The only interesting part in this test is "visit '/sessions/new'" in the 'sign_in' method. Why do we want to sign_in at "/sessions/new", and not at "/sign_in", "/users/sign_in", "/login" or something like this? Technically, it would work but it wouldn't be as elegant.

When signing in or out, we are manipulating a session: creating it, destroying it, and displaying a form to create it. By creating urls that define actions that apply to resources, we will achieve more elegant and easy to understand urls. Compare this

```
/users/new
/users
/users/edit
/sessions/new
/sessions
```

to this

```
/create_user_form
/create_user
/edit_user_form
/edit_user
/sign_in_form
/sign_in
/logout
```

The first approach is far more elegant. We've barely touched how urls should be defined (it's a slightly larger topic) but we'll go into details in Routing and REST.

To make this work, we'll need a form in sessions/new

```html
Please sign in.

<form method='post' action='/sessions'>
  Email: <input type='text' name='email'>
  Password: <input type='password' name='password'>
  <input type='submit' value='Sign in'>
</form>
```
a method to show this form:

```ruby
get '/sessions/new' do
  erb :'sessions/new'
end
```

a method to handle form submission

```ruby
post '/sessions' do
  email, password = params[:email], params[:password]
  user = User.authenticate(email, password)
  if user
    session[:user_id] = user.id
    redirect to('/')
  else
    flash[:errors] = ['The email or password is incorrect']
    erb :'sessions/new'
  end
end
```

and the User.authenticate method that we'll get to in a second.

Note that we're using the same pattern we used before: we try to obtain the user object by authenticating using the email and password provided and then check if we got one. If we did, we sign the user in and redirect. If we didn't, we show an error and display the form again.

Finally, we need a class method to authenticate a user.

```ruby
def self.authenticate(email, password)
  # that's the user who is trying to sign in
  user = first(email: email)
  # if this user exists and the password provided matches
  # the one we have password_digest for, everything's fine
  #
  # The Password.new returns an object that overrides the ==
  # method. Instead of comparing two passwords directly
  # (which is impossible because we only have a one-way hash)
  # the == method calculates the candidate password_digest from
  # the password given and compares it to the password_digest
  # it was initialised with.
  # So, to recap: THIS IS NOT A STRING COMPARISON
  if user && BCrypt::Password.new(user.password_digest) == password
    # return this user
    user
  else
    nil
  end
end
```

Since we're using bcrypt to generate a one-way hash, we cannot compare the passwords directly. We genuinely have no way of recovering the actual password. It is lost forever. However, what we do have is a digest that we can use to check if the password the user is trying to log in with is correct.

So we pass the password that the user is trying to log in with to the == method of the Password class. That method then calculates the digest for that password and compares it to the one in the database. It could look like this (not real bcrypt code):

```ruby
module BCrypt
  class Password
    def initialize(digest)
        @digest = digest
    end
    def ==(password)
        @digest == digest(salt(@digest), password)
    end
    def digest(salt, password)
        # compute the digest
        # by using bcrypt magic.
        # return something like
        # "$2a$10$vI8aWBnW3fID.ZQ4/zo1G.q1lRps.9cGLcZEiGDMVr5yKUOYTa"
    end
  end
end
```

Current state is on Github
https://github.com/makersacademy/bookmark_manager/tree/3beb8ac44357ceedf643bcbc9fccd92459faa92d

### Signing out

So far we learned how to create the users and sign them in. Let's see how we can log them out.

Since "signed in" only means that there's a user_id in the session, logging the user out is as simple as setting the session[:user_id] to nil. Let's write a test.

```ruby
feature 'User signs out' do

  before(:each) do
    User.create(email: 'test@test.com',
                password: 'test',
                password_confirmation: 'test')
  end

  scenario 'while being signed in' do
    sign_in('test@test.com', 'test')
    click_button 'Sign out'
    expect(page).to have_content('Good bye!') # where does this message go?
    expect(page).not_to have_content('Welcome, test@test.com')
  end

end
```

Since the sign_in helper is now used for more than one feature (sign in and sign out), let's extract it into an separate helper and include it as a module:

```ruby
require_relative 'helpers/session'

include SessionHelpers
```

The module now contains the methods sign_in and sign_up that we used to have in user_management_spec.

We will now need to display the Sign Out button that the test expects. The layout is a good place to do it since we'll need it on all pages of our site.

```html
  <% if current_user %>
    Welcome, <%= current_user.email %>
    <form method='post' action='/sessions'>
      <input type='hidden' name='_method' value='delete'>
      <input type='submit' value='Sign out'>
    </form>
  <% end %>
```

The form sends a POST request to /sessions but it also includes a hidden field _method (note the underscore) with value "delete". The reason is that the common convention for a url that destroys a resource is sending a DELETE request to /resource_url. However, modern browsers are unable to send any requests other than GET or POST when the form is being submitted. A common solution to this problem, used by both Sinatra and Ruby on Rails, is to include a hidden field called _method that will override the actual type of request. So, when Sinatra receives this request, it will behave as if it were a DELETE request and not a POST request. Therefore, the handler for this form needs to specify "delete" as an HTTP verb:

You need to add this line to the Sinatra server

```use Rack::MethodOverride```

This will allow us to use a new method in our server file, 'delete'. The final piece to this puzzle is that we need a Sinatra 'delete' method to handle the incoming signout request.  It will need to set a flash message, invalidate the session for the user who is signing out and then redirect appropriately.  See if you can set it up correctly.

Finally, let's add support for flash[:notice] in our layout.
```html
  <% if flash[:notice] %>
    <div id='notice'>
      <%= flash[:notice] %>
    </div>
  <% end %>
```

The tests should now pass, so we know that the user can now be signed out.  Although it doesn't hurt to check manually that everything works.

Now it's a good time to refactor our code a little bit. Let's install 'sinatra-partial' gem and use it like we did in BattleShip – web version to extract the welcome message and flash from the layout. Let's also extract all actions from server.rb into specific controllers in the /app/controllers folder. After we do this, our server.rb is nice and clean, containing only require statements and high-level configuration. Let's also move the models from /lib to /app/models to make sure that the models, views and controllers are in one place (incidentally, we're following Ruby on Rails naming conventions to some extent).

It's also a good time to consider to deploying our code to cloud hosting service like [Heroku](../pills/heroku.md).  Actually in a real project it would be good to deploy as early as possible to Heroku or similar to ensure that all the gems and techniques we are using work smoothly on a remote server.  If you do too much development locally, without checking the remote operation of the system you may lull yourself into a false sense of security about how many features you can deliver to your customers.  

Current state is on Github
https://github.com/makersacademy/bookmark_manager/tree/2e09228d334fd8009296653dfd55768520734654

[ [Next Stage](bookmark_manager_stage_9.md) ]

[ [Return to outline](bookmark_manager.md) ]
