Devise Omniauth
==============

Let's review the devise install https://github.com/plataformatec/devise

* First install the gem

```ruby
gem 'devise'
```

* generate the devise files

```sh
rails generate devise:install
```

* generate a devise model, e.g. user

```sh
rails generate devise user
```

* migrate

* check that it works 

* now let's install OmniAuth

http://github.com/plataformatec/devise/wiki/OmniAuth:-Overview

* we'll need the gem

```ruby
gem 'omniauth-facebook'
```

* bundle install

* we'll then need to add the columns provider (facebook or twitter etc.) and uid (id that we'll get back from facebook or twitter) to our User model

```sh
rails g migration AddColumnsToUsers provider uid
rake db:migrate
```

* and now we'll need to declare our provider in config/initializers/devise.rb

```ruby
require "omniauth-facebook"
config.omniauth :facebook, "APP_ID", "APP_SECRET"
```
* create an app on Facebook --> go to http://developers.facebook.com --> Apps --> create a new app

* grab the app secret and app id and replace the placeholders above (ideally these will be set as environment variables rather than being hardcoded into your config)

* now we need to make our model omniauthable:

```gem
devise :omniauthable, :omniauth_providers => [:facebook]
```

* add a link to our layouts

```html
<%= link_to 'Sign in with Facebook', user_omniauth_authorize_path(:Facebook)%>
```

* for this to work we'll need to add a callback to our routes file:

```ruby
devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
```

* we'll also need to add a file "app/controllers/users/omniauth_callbacks_controller.rb"

```ruby
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
end
```

* from the command line we can 

```sh
mkdir app/controllers/users/
touch app/controllers/users/omniauth_callbacks_controller.rb
```

* check with rake routes

* then we'll need to add an action for the provider

```ruby
def facebook
  @user = User.find_for_facebook_oauth(request.end["omniauth.auth"])

  if @user.persisted?
    sign_in_and_redirect @user, :event => :authentication
    set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
  else
    session["devise.facebook_data"] = request.env["omniauth.auth"]
    redirect_to new_user_registration_url
  end
end
```

* and then we'll also need the following in our users model:

```ruby
def self.find_for_facebook_oauth(auth)
  where(auth.slice(:provider, :uid)).first_or_create do |user|
    user.provider = auth.provider
    user.uid = auth.uid
    user.email = auth.info.email
    user.password = Devise.friendly_token[0,20]
    #user.name = auth.info.name # no name by default
    #user.image = auth.info.image # no image by default
  end
end

```

* It won't work initially, but let's see how far we get.  First error is:

"Given URL is not permitted by the application configuration. One or more of the given URLs is not allowed by the App's settings.  It must match the Website URL or Canvas URL, or the domain of the App's domain"

* So we need to configure the Facebook app for this to work - go to the apps settings on Facebook  --> Settings --> Add Platform (Website)

```
localhost:3000
```

* so restart rails and see if this works - with a bit of luck we can now log in via Facebook











