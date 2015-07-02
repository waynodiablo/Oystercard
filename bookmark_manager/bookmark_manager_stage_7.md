# Signing in

The users can sign up on our website but there's no way to sign in if you happen to be logged out (not that we have logging out functionality yet but it's coming). Let's write a test for signing in.

```ruby
feature 'User sign in' do

 let(:user) do
   User.create(email: 'user@example.com',
               password: 'secret1234',
               password_confirmation: 'secret1234')
 end

 scenario 'with correct credentials' do
   sign_in(email: user.email,   password: user.password)
   expect(page).to have_content "Welcome, #{user.email}"
 end

 def sign_in(email:, password:)
   visit '/sessions/new'
   # complete this helper method
 end

end
```

* :white_check_mark: Complete the 'sign_in' helper method in the spec file. This should drive you to an error 'unable to find field email'.

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

You should now have test driving you to create your path and form. To make this pass, we'll need a form in `views/sessions/new.erb`:

A route to show a form:

```ruby
get '/sessions/new' do
  erb :'sessions/new'
end
```

The form itself:

```html
Please sign in.

<form method='post' action='/sessions'>
  Email: <input type='text' name='email'>
  Password: <input type='password' name='password'>
  <input type='submit' value='Sign in'>
</form>
```

The error we get now is superficially similar to the error that we had previously ("Sinatra doesn't know this ditty"), however there is a difference. We will need to create a route to handle this incoming post request:


```ruby
post '/sessions' do
  user = User.authenticate(email: params[:email], password: params[:password])
  if user
    session[:user_id] = user.id
    redirect to('/links')
  else
    flash.now[:errors] = ['The email or password is incorrect']
    erb :'sessions/new'
  end
end
```

and the User.authenticate method that we'll get to in a second.

**Note that we're using the same pattern we used before:** we try to obtain the user object by authenticating using the email and password provided and then check if we got one. If we did, we sign the user in and redirect. If we didn't, we show an error and display the form again.

Finally, we need a class method to authenticate a user. At this stage we have a failing feature test, but the only way to reach a solution is to write a ruby method on our User class. Discuss with your partner why we are only now writing our first unit test:

```ruby
# in /spec/models/user_spec.rb
describe User do

 let!(:user) do
   User.create(email: 'test@test.com', password: 'secret1234',
               password_confirmation: 'secret1234')
 end

 it 'authenticates when given a valid email address and password' do
   authenticated_user = User.authenticate(email: user.email, password: user.password)
   expect(authenticated_user).to eq user
 end

end

```

This then drives us to minimally implement the authenticate method below:

```ruby
def self.authenticate(email:, password:) # clearly there is an issue here.. but let's wait until we have a test that targets it
  User.first(email: email)
end

```

Now let's write the test for a failing authentication:
```ruby
it 'does not authenticate when given an incorrect password' do
  expect(User.authenticate(email: user.email, password: 'wrong_stupid_password')).to be_nil
end
```
So now we should actually create our logic:

```ruby
def self.authenticate(email:, password:)
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

Since we're using BCrypt to generate a one-way hash, we cannot compare the passwords directly. We genuinely have no way of recovering the actual password. It is lost forever. However, what we do have is a digest that we can use to check if the password the user is trying to log in with is correct.

So we pass the password that the user is trying to log in with to the `==` method of the Password class. That method then calculates the digest for that password and compares it to the one in the database.

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
    sign_in(email: 'test@test.com', password: 'test')
    click_button 'Sign out'
    expect(page).to have_content('goodbye!') # where does this message go?
    expect(page).not_to have_content('Welcome, test@test.com')
  end

end
```

Since the sign_in helper is now used for more than one feature (sign in and sign out).
* Extract #sign_in & #sign_up methods out of your feature files and into a separate helper module, then include it as a module within your spec_helper, like so:

```ruby
require_relative 'helpers/session'

RSpec.configure do |config|

  config.include SessionHelpers

end
```

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

The form sends a POST request to /sessions but it also includes a hidden field `_method` (note the underscore) with value "delete". The reason is that the common convention for a url that destroys a resource is sending a DELETE request to /resource_url. However, modern browsers are unable to send any requests other than GET or POST when the form is being submitted. A common solution to this problem, used by both Sinatra and Ruby on Rails, is to include a hidden field called `_method` that will override the actual type of request. So, when Sinatra receives this request, it will behave as if it were a DELETE request and not a POST request. Therefore, the handler for this form needs to specify "delete" as an HTTP verb:

You need to add this line to the Sinatra server

```ruby
class BookmarkManager
  use Rack::MethodOverride
```

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

Now it's a good time to refactor our code a little bit.
* :white_check_mark: Let's install 'sinatra-partial' gem and use it to extract the welcome message and flash from the layout. Let's also extract all actions from server.rb into specific controllers in the /app/controllers folder.
  * After we do this, our app.rb is nice and clean, containing only require statements and high-level configuration.
* :white_check_mark: It's also a good time to consider to deploying our code to cloud hosting service like [Heroku](../pills/heroku.md).

Actually in a real project it would be good to deploy as early as possible to Heroku or similar to ensure that all the gems and techniques we are using work smoothly on a remote server.  If you do too much development locally, without checking the remote operation of the system you may lull yourself into a false sense of security about how many features you can deliver to your customers.  

[ [Next Stage](bookmark_manager_stage_8.md) ]

[ [Return to outline](bookmark_manager.md) ]
