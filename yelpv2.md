| [← Yelp V1](yelpv1.md) | [Yelp home](yelp.md) | [Yelp V3 →](yelpv3.md) |
|------------------------|----------------------|-----------------------:|

# Yelp

***As you know, as with all Makers Academy materials, there may be subtle errors in the following code snippets.  Please try to approach those as challenges on which to polish your debugging skills - pull requests always welcome.***

### V2 Walkthrough

- [Installing Devise](#installing-devise)
- [How do I log into this thing?](#how-do-i-log-into-this-thing)
- [Adding links to log in and out](#adding-links-to-log-in-and-out)
- [Adding OmniAuth login](#adding-omniauth-login)
    - [Register a Facebook Developer application](#register-a-facebook-developer-application)
    - [Keeping secrets properly](#keeping-secrets-properly)
- [Setting limits on users](#setting-limits-on-users)
    - [A user must be logged in to create restaurants](#a-user-must-be-logged-in-to-create-restaurants)
    - [Users can only edit/delete restaurants which they've created](#users-can-only-editdelete-restaurants-which-theyve-created)
    - [Users can only leave one review per restaurant](#users-can-only-leave-one-review-per-restaurant)
    - [Users can delete only their own reviews](#users-can-delete-only-their-own-reviews)


***Please work through this walkthrough with a pair partner. Please take turns on the keyboard as the driver as described in the [pairing pill](pills/pairing.md) :pill:.   Please swap driver/navigator roles at least as often as you see the :twisted_rightwards_arrows: sign.***

In this version, we want to add user login. In Sinatra, this requires you to manually add a User model, and then create all the usual controller routes – for login, logout, signing up and so on. How tedious.

Rails has a gem that does all of that for you – [Devise](https://github.com/plataformatec/devise). It handles building a user model, routes for your users controller, and even fancy things like OAuth (which handles those 'Log in with Facebook'-type buttons).

Let's get started.

#### Installing Devise

Add Devise to your Gemfile –

```ruby
gem 'devise'
```

and install it with `bundle install`.

Then run the Devise generator:

`$ bin/rails g devise:install`

(Remember, the `g` is short for `generate`.) Now you're ready to tell Devise to make your User model:

`$ bin/rails g devise User`

And run `$ rake db:migrate` to get that lovely users table added to your database.

This does the following:

* *creates a database migration to add a Users table*
* *adds a User model*, which tells Rails about the properties that our users should have
* *updates `config/routes.rb`* with the relevant user signin, signout and signup routes
* *adds a Users controller* (really the Devise controller) which gives Rails the commands to deal with users.

Make sure you then follow the on-screen instructions to finish setting up devise, but change the root declaration in **routes.rb** to:

```ruby
root to: "restaurants#index"
```

#### How do I log into this thing?

Have a look at `app/models/user.rb` to get the gist of your new User class.

That's Devise pretty well done. It's now given you all the necessary kit for creating and logging in users, and running `bin/rake routes` will show you this:

```
                  Prefix Verb   URI Pattern                    Controller#Action
        new_user_session GET    /users/sign_in(.:format)       devise/sessions#new
            user_session POST   /users/sign_in(.:format)       devise/sessions#create
    destroy_user_session DELETE /users/sign_out(.:format)      devise/sessions#destroy
           user_password POST   /users/password(.:format)      devise/passwords#create
       new_user_password GET    /users/password/new(.:format)  devise/passwords#new
      edit_user_password GET    /users/password/edit(.:format) devise/passwords#edit
                         PATCH  /users/password(.:format)      devise/passwords#update
                         PUT    /users/password(.:format)      devise/passwords#update
cancel_user_registration GET    /users/cancel(.:format)        devise/registrations#cancel
       user_registration POST   /users(.:format)               devise/registrations#create
   new_user_registration GET    /users/sign_up(.:format)       devise/registrations#new
  edit_user_registration GET    /users/edit(.:format)          devise/registrations#edit
                         PATCH  /users(.:format)               devise/registrations#update
                         PUT    /users(.:format)               devise/registrations#update
                         DELETE /users(.:format)               devise/registrations#destroy
```

Boot up your server with `$ rails s` and try visiting `/users/sign_in`.

#### Adding links to log in and out

So we've got routes that let our users sign-in/-out/-up, but they have no way of getting to them. Time to update our view logic!

As always, let's test first. **There's no real need to test Devise's internals** – the user model and so on – because we can probably assume that they work pretty well. Instead, let's write a feature test.

`spec/features/users_feature_spec.rb`:

```ruby
require 'rails_helper'

context "user not signed in and on the homepage" do
  it "should see a 'sign in' link and a 'sign up' link" do
    visit('/')
    expect(page).to have_link('Sign in')
    expect(page).to have_link('Sign up')
  end

  it "should not see 'sign out' link" do
    visit('/')
    expect(page).not_to have_link('Sign out')
  end
end

context "user signed in on the homepage" do

  before do
    visit('/')
    click_link('Sign up')
    fill_in('Email', with: 'test@example.com')
    fill_in('Password', with: 'testtest')
    fill_in('Password confirmation', with: 'testtest')
    click_button('Sign up')
  end

  it "should see 'sign out' link" do
    visit('/')
    expect(page).to have_link('Sign out')
  end

  it "should not see a 'sign in' link and a 'sign up' link" do
    visit('/')
    expect(page).not_to have_link('Sign in')
    expect(page).not_to have_link('Sign up')
  end
end
```

Now we need to add these links to the view logic. Specifically, we need to tell the app to show certain links dependent on whether or not a user is logged in. We can use Devise's built-in `user_signed_in?` helper to do this.

In `views/layouts/application.erb`, add a sign out link:

```erb
<% if user_signed_in? %>
  <%= link_to "Sign out", destroy_user_session_path, method: :delete %>
...
```

And now we need sign in and sign up links, so add this to the above:

```erb
...
<% else %>
  <%= link_to "Sign in", new_user_session_path %>
  <%= link_to "Sign up", new_user_registration_path %>
<% end %>
```

And now we should be green. A good time to  commit our latest code to git, and switch Driver/Navigator Roles&nbsp;:twisted_rightwards_arrows:.

#### Adding OmniAuth login

Omniauth allows a user to log in to your site using a 3rd party login such as Facebook, Twitter, Github or other trusted 3rd party. This avoids the need for the user to create a new login/password just for your site.  Omniauth is a particular implementation of 3rd party authentication which involves a callback process as shown in this diagram:

<center>
![Omniauth login flow](http://3.bp.blogspot.com/-AkxYz8Ah9zA/T0rrsOVc0VI/AAAAAAAAIUI/GZUx5TbdecE/s1600/How+Omniauth+works.png)
</center>

For this example, we'll be adding a 'sign in with Facebook' link.

##### Register a Facebook Developer application

Create a [Facebook Developer application](http://developers.facebook.com), making note of the two keys you're given.

Now follow the instructions on the [Devise wiki](https://github.com/plataformatec/devise/wiki/OmniAuth:-Overview), ensuring you read the next section straight after about keeping your private details safe!

Note that Devise will add the link to Facebook sign-up automatically, so you don't need to follow that step on the wiki.

Under Settings => Advanced in your Facebook Developer dashboard, you need to add http://localhost:3000 as a valid redirect URI.

##### Keeping secrets properly

The proper way of saving secrets is to abstract them out into a separate file.

Add your Facebook keys to the Rails `secrets.yml` file. They can then get called into the above code without needing to check them into version control. Call them using the following:

`Rails.application.secret.NAME_OF_SECRET`

Make sure that `config/secrets.yml` is in your `.gitignore` file to prevent it being picked up by version control. (Bear in mind that at this point it's already in your Git history, so it's not actually gone. To remove secrets from a repo's history, try following [this tutorial](https://help.github.com/articles/remove-sensitive-data/).)

Alternatively you can have your secrets.yml file pull in from environment variables like so:

```yml
production:
  secret_key_base: <%= ENV["SECRET_KEY_BASE"] %>
```

which allows the `config/secrets.yml` file to be committed to git, which smoothes Heroku deploy.

**Whichever method you use please please please never commit production secrets to open git repositories. Especially when using Amazon Web Services because *those secrets are linked to your credit card details*.** Be careful!

#### Setting limits on users

Now we want to set limits on what site visitors can do. From our [specification](yelp.md#v2-specification):

* A user must be logged in to create restaurants
* Users can only edit/delete restaurants **which they've created**
* Users can only leave **one review per restaurant**
* Users can delete their own reviews

Let's tackle these one by one. Remember to always write tests first, commit often to git and swap driver/navigator roles frequently&nbsp;:twisted_rightwards_arrows:.


##### A user must be logged in to create restaurants

In `restaurants_controller.rb`, we can add a `before_action` at the top of the controller that checks to see if a user is logged in before the action runs. See if you can write a test first before adding the code below. You'll also need to update some of your other feature specs as this breaks those as well.

```ruby
before_action :authenticate_user!, :except => [:index, :show]
```

As you can guess, this will apply to all of the methods in the controller except for `index` and `show`, so guests will still be able to see the list of restaurants and the individual restaurant pages.

Now try adding tests/code for the following scenarios:

* **Users can only edit/delete restaurants which they've created**
* **Users can only leave one review per restaurant**
* **Users can delete only their own reviews**

### Related Videos

* [Devise/OmniAuth](https://www.youtube.com/watch?v=_nV4ENuO5QA)
* [Scaffold/Bootstrap](https://www.youtube.com/watch?v=pO7_fA2LeAk)
