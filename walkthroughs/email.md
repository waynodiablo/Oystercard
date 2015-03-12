Email Walkthrough
=============

Let's send an email whenever the user makes an order

* first let's authenticate_users coming to the charges controller

```ruby
class ChargesController < ApplicationController
  before_action :authenticate_user!

```

* check that payments are working

* to test emails we can use the capybara-email gem so add that to our gem file and bundle

* add `require 'capybara/email/rspec'` to our rails_helper.rb

* now we can write a feature spec in orders_feature_spec.rb (make sure objects are properly created to db)

```ruby
  describe 'email confirmation' do
    before do
     clear_emails
    end
    
    it 'is sent when an order is created' do
      Order.create(post:post, user: user)
      open_email('customer@blah.com')
      expect(current_email).to have_content 'Order successful!'
    end
  end
```

* check that this fails with expected to find text "Order successful!" in "" which means the email has no content

* so let's create a mailer in rails

```
bin/rails g mailer OrderMailer
```

* will generate the following

```ruby
class OrderMailer < ActionMailer::Base
  default from: "from@example.com"
end
```

* let's now add some methods (see action_mailer_basics in rails guides) which in contrast to standard controllers we can pass args to


```ruby
class OrderMailer < ActionMailer::Base
  default from: "no-reply@instagrammay.com"

  def confirmation(order)
    mail(to: order.user.email, subject: 'Order confirmed')
  end
end
```
* we'll also need a view which goes into our app/views/order_mailer/confirmation.html.erb  (there is support for text emails to - goes in confirmation.text.erb - for plain text emails)

```html
<h1>Order successful!</h1>

<p>Thanks for your order :)</p>
```

* to experiment with emails we can use the mail catcher gem http://mailcatcher.me

* add the following to development.rb

```ruby
config.action_mailer.delivery_method = :smtp
config.action_mailer.smtp_settings = {:address => 'localhost', :port => 1025}
```

* with that we can send emails from the console and see what they look like in mail catcher - start by creating an order then

```ruby
OrderMailer.confirmation(Order.last).deliver
```

* and mail catcher will give us a link we can go to in our browser to check what the email looks like

* there are certificates that we can set up to try and ensure the reliability of where emails are coming from

* now we want to get the email to be sent when we receive an order - could drop our existing mail call into our charges_controller.rb, but we are now putting rather a lot of responsibility on the controller

* let's prefer to put that functionality in a callback in the Order model so that whenever an order is created

```ruby
class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  after_create :send_confirmation_email

  def send_confirmation_email
    OrderMailer.confirmation(self).deliver
  end
end
```

* all our tests should pass now

* let's update our tests so we add the name of the print in the email

```ruby
  describe 'email confirmation' do
    before do
     clear_emails
    end
    
    it 'is sent when an order is created' do
      Order.create(post:post, user: user)
      open_email('customer@blah.com')
      expect(current_email).to have_content 'Order successful!'
      expect(current_email.subject).to have_content 'You just ordered a print of Pretty picture'
    end
  end
```

* so we can adjust the order mailer like so

```ruby
class OrderMailer < ActionMailer::Base
  default from: "no-reply@instagrammay.com"

  def confirmation(order)
    @order = order
    mail(to: order.user.email, subject: "You just ordered a print of #{order.post.title}")
  end
end
```

* and update the template as follows:

```html
<h1>Order successful!</h1>

<p>Thanks for your order :)</p>
<p>You just ordered a print of <%= @order.post.title%></p>
```

* and our tests should pass and can see our order in mail catcher

* let's also put the image in the email

```html
<h1>Order successful!</h1>

<p>Thanks for your order :)</p>
<p>You just ordered a print of <%= @order.post.title%></p>
<%= link_to image_tag(@order.post.image.url(:medium)), posts_url(host: localhost:3000) %>
```

* note we use posts_url here to ensure we get the full url to the post in the email rather than a relative link

* finally deploy to heroku, we need an email provider such as mail gun or send grid - send grid is easy to use on heroku

* add and commit all to heroku

* push heroku secrets up

```
bin/rake heroku:secrets RAILS_ENV=production
```

* then push to heroku

```
git push heroku master
```

* add basic send grid add-on

```
heroku addons:add send grid:starter
```

* need to add settings for mailer to our production.rb file

```ruby
ActionMailer::Base.smtp_settings = {
  :address        => 'smtp.sendgrid.net',
  :port           => '587',
  :authentication => :plain,
  :user_name      => ENV['SENDGRID_USERNAME'],
  :password       => ENV['SENDGRID_PASSWORD'],
  :domain         => 'heroku.com',
  :enable_starttls_auto => true
}
```

* add and commit the new send grid setup and push to heroku

```
git push heroku master
```

* run migrations on heroku environment

```
heroku run rake db:migrate
```

* and should work but can use `heroku logs` to check for any errors

[careful with styles on images in _post.rb medium/thumb]













