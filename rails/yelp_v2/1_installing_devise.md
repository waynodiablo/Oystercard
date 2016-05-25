# Section 1: Installing Devise

First, we have refer to [Devise](https://github.com/plataformatec/devise) for documentation.

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
* *configures a set of controllers* (initially contained within devise) which gives Rails the commands to deal with users.

Make sure you then follow the on-screen instructions to finish setting up devise, but change the root declaration in **routes.rb** to:

```ruby
root "restaurants#index"
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

### [Next Stage - Adding links to log in and out](2_adding_links_log_in_out.md)
