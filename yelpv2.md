# Yelp

### V2 Walkthrough

@@TOC@@

In this version, we want to add user login. In Sinatra, this requires you to manually add a User model, and then create all the usual controller routes – for login, logout, signing up and so on. How tedious.

Rails has a gem that does all of that for you – [Devise](https://github.com/plataformatec/devise). It handles building a user model, routes for your users controller, and even fancy things like OAuth (which handles those 'Log in with Facebook'-type buttons).

Let's get started.

#### Installing Devise

Add Devise to your Gemfile –

```ruby
gem 'devise'
```

and install it with `bundle install`.

The run the Devise generator:

`$ rails g devise:install`

(Remember, the `g` is short for `generate`.) Now you're ready to tell Devise to make your User model:

`$ rails g devise User`

This does the following:

* *creates a database migration to add a Users table*
* *adds a User model*, which tells Rails about the properties that our users should have
* *updates `config/routes.rb`* with the relevant user signin, signout and signup routes
* *adds a Users controller* (really the Devise controller) which gives Rails the commands to deal with users

#### How do I log into this thing?

Have a look at `app/models/user.rb` to get the gist of your new User class.

That's Devise pretty well done. It's now given you all the necessary kit for creating and logging in users, and running `rake routes` will show you this:

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

As always, let's test first.

