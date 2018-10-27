Payments with Stripe
---------------

So you want to accept payments through your website?  One option that is popular and developer friendly is [Stripe](http://stripe.com).  Before the existence of systems like Stripe it used to take a long time (perhaps a couple of weeks) to implement this kind of functionality in your website, and if you were keeping track of customer credit cards there was a lot of due diligence required to secure that data.  Stripe saves us from that hassle, allows us to avoid storing sensitive customer data and handles everything in a black box.  That does mean that we won't be able to test drive the actual payment functionality in the same way as we might with other plugins.

Let's use Stripe's complete checkout solution (less complete solutions also available) to allow people to buy a print from our instagram system. First up we'll create an admin user who can see all the payments that have taken place. This means we need the concept of an admin user - could use existing table with an admin column, or we could use a completely different table, which is what we'll do now:

First create an admin feature spec in `spec/features/admin_feature_spec.rb`

```ruby
require 'rails_helper'

describe 'admins' do
  it 'cannot sign up' do
    visit '/admins/sign_up'
    expect(page).not_to have_content 'Sign up'
  end
end
```

Watch this fail: 'No route matches [GET] "/admins/sign_up"'

[Note: we might need to add if post.picture.exists? if image links are breaking our tests]

To fix this let's generate a new devise model for admins:

`bin/rails g devise Admin`

And migrate

`bin/rake db:migrate`

And change the error message to "expected not to find text 'Sign up'"

Note that we can get in trouble here if the devise_for :admins is above devise_for :users in routes.rb --> 'Unable to find field "Title"' failures in posts_fe etc.

Inn order to fix this - let's remove :registrable from Admin model and adjust test:

```ruby
require 'rails_helper'

describe 'admins' do
  it 'cannot sign up' do
    expect{visit '/admins/sign_up'}.to raise_error
  end
end
```
The tests should now pass and the next step is to create admins via seed file, e.g. in seeds.rb

```ruby
Admin.delete_all
Admin.create(email: 't@t.com', password: '12345678', password_confirmation: '12345678')
```

Running `rake db:seed` will now create an admin account that we can use to log into development.  So let's create an order feature spec:

```ruby
require 'rails_helper'

describe 'orders page' do
  let(:post){Post.create}
  let(:user){User.create email: 'customer@blah.com', password: '12345678', password_confirmation: '12345678'}
  let(:admin){Admin.create email: 't@t.com', password: '12345678', password_confirmation: '12345678'}

  context 'logged in as admin' do
    context 'no orders' do
      it 'sees a message' do
         visit '/orders'
         expect(page).to have_content 'No orders yet'
      end
    end
  end

  context 'not logged in as admin' do
    it 'prompts to sign in' do
      visit '/orders'
      expect(page).to have_content 'sign up'
    end
  end

```

Which should get complaint about routes.  The fix is to add `resources :orders` in routes.rb which will then move us on to an error about a controller: 'uninitialized constant OrdersController'

Which prompts us to generate an orders controller:

```
bin/rails g controller orders
```

This changes the error to one about a view: "The action 'index' could not be found for OrdersController", which naturally inclines us to add a view index.html.erb

```html
No Orders yet
```

Then to login as an admin we need:

```ruby
  context 'logged in as admin' do
    before do
      login_as admin, scope: :admin
    end
```

And we'll also need to authenticate the user in controller

```ruby
def index
  authenticate_admin!
end
```

The tests should now pass.  Next let's create some order, and test that we can see the product name, customer email and order number.

```ruby
require 'rails_helper'

describe 'orders page' do
  let(:post){Post.create title: 'Pretty picture'}
  let(:user){User.create email: 'customer@blah.com', password: '12345678', password_confirmation: '12345678'}
  let(:admin){Admin.create email: 't@t.com', password: '12345678', password_confirmation: '12345678'}

  context 'logged in as admin' do

    context 'with orders' do
      before do
        login_as admin, scope: admin
        christmas_day = Date.new(2013, 12, 25)

        Order.create(id: 1, post: post, user: user, created_at: christmas_day)
        visit '/orders'
      end

      it 'displays the product' do
        expect(page).to have_link 'Pretty picture'
      end

      it 'displays the customer email' do
        expect(page).to have_content 'customer@blah.com'
      end

      it 'displays an order number' do
        expect(page).to have_content '2512130001'
      end
  end
```

The tests should now fail with an error 'uninitialised constant Order'

This indicates that it is time to generate our order model like so:

`bin/rails g model Order post:belongs_to user:belongs_to`

Follow up with a migration and the tests should now have new error related to the page contents.

Assuming we are grabbing our orders from the database in controller:

```ruby
class OrdersController < ApplicationController
  def index
    authenticate_admin!
    @orders = Order.all
  end
end
```

We can fix these errors by filling out the view correctly:

```html
<% if @orders.any? %>
  <% @orders.each do |order| %>
    <%= order.user.email %>
    <%= link_to order.post.title, '/posts' %>
    <%# order.number %>
  <% end %>
<% else %>
  No orders yet
<% end %>
```

Some tests will now pass, but the order number test will fail, and to fix that we need to update order.rb:

```ruby
class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  def number
    date_section = created_at.strftime('%d%m%y')
    number_section = "%04d" % id

    date_section + number_section
  end

end
```
And remove comment from view:

```html
<% if @orders.any? %>
  <% orders.each do |order| %>
    <%= order.user.email %>
    <%= link_to order.post.title, '/posts' %>
    <%= order.number %>
  <% end %>
<% else %>
  No orders yet
<% end %>
```

And the tests should all now pass.  So let's try creating an order from the rails console:

```ruby
> Order.create(user: User.last, post: Post.last)
```

And check how that looks at http://localhost:3000/orders

So now we want people to create orders and this is what we'll use Stripe for - so let's work through this tutorial:

https://stripe.com/docs/checkout/guides/rails

We start by adding gem to Gemfile:

```
gem 'stripe', :git => 'https://github.com/stripe/stripe-ruby'
```

And run bundle to install the gem.  We will also need to create a Stripe account.

A nice feature of stripe is being able to switch between test and live environments - you'll need to activate by adding a bank account before you can go live and accept real payments.

Go to your stripe account settings --> API keys to get secret keys to add to your app

Put the test keys into development and live keys into production, by updating secrets.yml

Then put the following in the config/initializers/stripe.rb file :

```ruby
Stripe.api_key = Rails.application.secrets.stripe_secret_key
```

Now let's build up our payment functionality, starting in routes.rb add a new sub-route for :charges, i.e.

```ruby
resources :posts do
  resources :charge
  ...
```

Then as per the stripe tutorial let's create a charges controller

```ruby
rails g controller charges
```

Now we'll add a new and create to our controller, which will correspond to a payment form and then when we click pay that will go to create and actually charge the credit card:

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

We'll also need to add a payment form to charges view (new.html.erb), with some changes due to nesting the route:

```html
<%= form_tag post_charge_path(@post) do %>
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

The charges controller will need a change to the new method:

```ruby
def new
  @post = Post.find params[:post_id]
end
```

There's not much in the form since it's going to be generated by stripe javascript, but we do need to make a couple of changes:

```html
<div class='container'>
<%= form_tag post_charge_path(@post) do %>
  <h2>Buy print for $20</h2>

  <script src="https://checkout.stripe.com/checkout.js" class="stripe-button"
          data-key="<%= Rails.application.secrets.stripe_public_key %>"
          data-description="A beautiful print"
          data-amount="2000"></script>
<% end %>
</div>
```

Note the amount is in pennies or cents - can see other form options at https://stripe.com/docs/checkout e.g. setting a different currency.

We don't have a link to by yet, but let's just go to the charge for an existing post, e.g.

http://localhost:3000/posts/6/charges/new

And hitting 'pay with card' gives us a nice payment form - let's test with a test card number, e.g. 4242 4242 4242 - see http://stripe.com/docs/testing for more details on testing data - and an expiry date at any time in the future and any CVC

The form could be modified in browser but the amount charged is actually fixed on server side by developer, so let's review what's happening in the controller:

```ruby
def create
  @post = Post.find params[:post_id]
  # Amount in cents
  @amount = 2000

  customer = Stripe::Customer.create(
    :email => params[:stripeEmail], # OR current_user.email
    :card  => params[:stripeToken] # encrypted version of their credit card
  )

  charge = Stripe::Charge.create(
    :customer    => customer.id,
    :amount      => @amount,
    :description => "Print of #{@post.title}",
    :currency    => 'usd'
  )

  Order.create(user: current_user, post: @post)

rescue Stripe::CardError => e
  flash[:error] = e.message
  redirect_to post_charges_path(@post) # adjusted for our nested route
end
```

The order will only be created if charge is successful.

Now let's add a buy button in _post.html.erb

```html
<%= link_to "Buy", new_post_charge_path(post), class: 'btn btn-lg btn-default'%>
```

This should now allow creation of an order, but we should ensure user is logged in and provide some response.

We should be able to see the new orders at http://localhost:3000/orders and §also on our stripe dashboard

Note, that one could use stripe.js to get more flexibility with styling of forms.

Challenges:

* different sizes and prices of prints
* shopping carts

Resources:

* [Video of walkthrough](http://youtu.be/7sRsLgG75Gs)


![Tracking pixel](https://githubanalytics.herokuapp.com/course/walkthroughs/stripe.md)
