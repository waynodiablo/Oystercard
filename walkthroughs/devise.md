Devise
=======

Devise is an authentication system that allows users to sign up, login, reset their passwords etc.

* For a standard CRUD model anyone can edit/delete - we will need authentication to control this just like the sign up and login created by hand in the sinatra app
* In rails we have the devise gem - let's use that to support the following:
  - only signed in users can see the edit/delete links
  - clicking "create restaurant" takes you to sign in page --> add that link

* Let's start by adding contexts to handle being logged in and logged out
* And let's comment out the logged in contexts for the moment to focus on logged out
---> note for reviews: expect(page).not_to have_field 'Thoughts'


* devise  
--- add `gem 'devise'` to Gemfile  
--- install devise: `bin/rails g devise:install`  
--- generate user: `bin/rails g devise user`  
--- changing document root  
--- adding alert to app/views/layouts/applicaton.html.erb  
```html
<p class="notice"><%= notice %></p>
<p class="alert"><%= alert %></p>
```
--- rake db:migrate

* check we can log in 
* add forms to sign up https://github.com/plataformatec/devise/wiki/How-To:-Add-sign_in,-sign_out,-and-sign_up-links-to-your-layout-template
* devise controller is hidden 

* RESTful thinking
* only show review form and links if user signed in --> if user_signed_in?
* for create new restaurant do in controller --> authenticate_user!
* then also authenticate_user! in other controller actions
* can DRY out with before_action --> before_action :authenticate_user!, except: [:index]
* logging in with tests … --> add warden config to rails_helper.rb
* adding log in operation to test:

```ruby
before do
  user = User.create email: 'tansaku@gmail.com', password: '12345678', password_confirmation: '12345678'
  login_as user
end
```

* will also need the following in 'spec/rails_helper.rb' to give tests access to login related methods
```
include Warden::Test::Helpers
Warden.test_mode!
```

* Follow up challenges 
    - only allow user to edit/delete restaurants they created 
    - only one review per user

