Stripe
========

Taking payments is clearly a critical part of many business operations.  There are a number of relatively simple payment gateway solutions, such as Stripe, GoCardless, BrainTree, PayMill etc.  Stripe is perhaps the most developer friendly and has good integration options for popular web application frameworks such as Rails, Django, Sinatra etc., and has javascript only solutions that easily integrate with JavaScript stacks.

Using a 3rd party payment system relieves a huge burden on the developer in terms of not having to by not placing sensitive cardholder data on the developer's server. A 3rd party like Stripe will take care of the hardest parts of PCI (Payment Card Industry) compliance, like redacting logs and encrypting cardholder details.  The developer's site will still need to support https, and the 3rd party will be taking a percentage cut of any sales, but these overheads are very often worth it.

For the sake of an example let's assume we were trying to set up donation payments on a charity directory, and further say that we were starting with a Rails app.  3rd party services like Stripe provide boiler plate code (as well as fine grained APIs) that will make secure submissions to their servers, which will return a response indicating whether or not a user credit card is valid, and process payment as appropriate.

Integrating Stripe with Rails we'll need the concept of an order or a donation to keep a track of things on our side.  Say that we're accepting donations we'll first need a donations controller and model …

```sh
bin/rails g controller donations
```

```sh
bin/rails g model Donation charity:belongs_to
```

Assuming we've migrated we can try creating a donation from the rails console:

```sh
> Donation.create(charity: Charity.last)
```

Given our donation model is in place we'll use Stripe to process the payments for that donation.  We'll show the details of a modified version of the Stripe Rails tutorial:

https://stripe.com/docs/checkout/guides/rails

We start by adding gem to Gemfile:

```
gem 'stripe', :git => 'https://github.com/stripe/stripe-ruby'
```

And run bundle to install the gem.  We will also need to create a [Stripe](http://stripe.com) account.

A nice feature of stripe is being able to switch between test and live environments - you'll need to activate by adding a bank account before you can go live and accept real payments.

In order to start working with Stripe in our Rails app we need to go to our Stripe 'account settings' --> 'API keys' and copy our keys to our secrets.yml file:

```yml
development:
  stripe_secret_key: sk_test_2398yredh298qwehid128hd1
  stripe_public_key: pk_test_w9fh2b98iybe9ibquyebn1oe
```

To start with let's just put our 'test' keys in development so that we can get a tracer bullet to confirm that we can manage payments end to end.

We'll also want to put the following in the config/initializers/stripe.rb file :

```ruby
Stripe.api_key = Rails.application.secrets.stripe_secret_key
```

Now let's build up our payment functionality, starting in routes.rb add a new sub-route for :charges, i.e.

```ruby
resources :charities do
  resources :charges
  ...
```

Then as per the stripe tutorial let's create a charges controller that will display a charge form for us and also provide a callback that Stripe will call when it has processed the charge request.

```ruby
bin/rails g controller charges
```

Now we'll add 'new' and 'create' methods to our controller, which will correspond to a payment form and instructions for what to do with the results of the credit card processing.  The create method shown here is just the default from Stripe:

```ruby
def new
end

def create
  # Amount in cents
  @amount = 500

  customer = Stripe::Customer.create(
    :email => 'example@stripe.com',
    :card  => params[:stripeToken]
  )

  charge = Stripe::Charge.create(
    :customer    => customer.id,
    :amount      => @amount,
    :description => 'Rails Stripe customer',
    :currency    => 'usd'
  )

rescue Stripe::CardError => e
  flash[:error] = e.message
  redirect_to charges_path
end
```

We'll also need to add a payment form to charges view (new.html.erb).  Below is the Stripe default:

```html
<%= form_tag charges_path do %>
  <article>
    <label class="amount">
      <span>Amount: $5.00</span>
    </label>
  </article>

  <script src="https://checkout.stripe.com/checkout.js" class="stripe-button"
          data-key="<%= Rails.configuration.stripe[:publishable_key] %>"
          data-description="A month's subscription"
          data-amount="500"></script>
<% end %>
```

Now let's customize the default Stripe code to suit our purposes. The charges controller will need a change to the new method:

```ruby
def new
  @charity = Charity.find params[:charity_id]
end
```

The create method will need to be modified as follows:

```ruby
def create
  @charity = Charity.find params[:charity_id]
  # Amount in pennies
  @amount = 500

  customer = Stripe::Customer.create(
    :email => params[:stripeEmail], 
    :card  => params[:stripeToken] # encrypted version of their credit card
  )

  charge = Stripe::Charge.create(
    :customer    => customer.id,
    :amount      => @amount,
    :description => “Donation to #{@charity.name}",
    :currency    => 'gbp'
  )

  Donation.create(charity: @charity)
  flash[:notice] = 'Thanks so much for your donation!!'
  redirect_to charity_path(@charity)

rescue Stripe::CardError => e
  flash[:error] = e.message
  redirect_to charity_charges_path(@charity) # adjusted for our nested route
end
```

There's not much in the form since it's going to be generated by stripe JavaScript, but we do need to make a couple of changes; specifically to handle the nested resource path, our updated way of handling the secrets in Rails 4, our donation amount, and description:

```html
<div class='container'>
<%= form_tag charity_charges_path(@charity) do %>
  <h2>Donate £5</h2>

  <script src="https://checkout.stripe.com/checkout.js" class="stripe-button"
          data-key="<%= Rails.application.secrets.stripe_public_key %>"
          data-description="A donation"
          data-amount="500"></script>
<% end %>
</div>
```

Note the amount is in pennies - can see other form options at https://stripe.com/docs/checkout e.g. setting a different currency etc..

We don't have a link to donate yet, but let's just go to the charge being submitted for a particular charity, e.g.

http://localhost:3000/charities/6/charges/new

And hitting 'pay with card' gives us a nice payment form - let's test with a test card number, e.g. 4242 4242 4242 - see http://stripe.com/docs/testing for more details on testing data - and an expiry date at any time in the future and any CVC

The form could be modified in browser but the amount charged is actually fixed on server side by developer, so let's review what's happening in the controller:

```ruby
def create
  @charity = Charity.find params[:charity_id]
  # Amount in pennies
  @amount = 500

  customer = Stripe::Customer.create(
    :email => params[:stripeEmail], 
    :card  => params[:stripeToken] # encrypted version of their credit card
  )

  charge = Stripe::Charge.create(
    :customer    => customer.id,
    :amount      => @amount,
    :description => “Donation to #{@charity.name}",
    :currency    => 'gbp'
  )

  Donation.create(charity: @charity)
  flash[:notice] = 'Thanks so much for your donation!!'
  redirect_to charity_path(@charity)

rescue Stripe::CardError => e
  flash[:error] = e.message
  redirect_to charity_charges_path(@charity) # adjusted for our nested route
end
```

Note, the donation will only be created if charge is successful.

Given that this is working, let's finish up by adding a donate button in the charity show.html.erb view:

```html
<%= link_to 'Donate', new_charity_charge_path(@charity), class: 'nice small radius blue button'%>
```

Which allows us to donate to a specific charity.

Note, that one could use stripe.js to get more flexibility with styling of forms.

Resources
--------
* [Instagram Marketplace Stripe Walkthrough (with video - see resources)](https://github.com/makersacademy/Walkthroughs/blob/master/stripe.md)

Exercises
--------

* Try to implement different donation amounts
* Try to implement user selected donation amount
* Try to style the form to match your site style
