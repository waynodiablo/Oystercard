# Section 8: Creating ("C"RUD)

#### Creating a restaurant via the client

You remember [CRUD](http://en.wikipedia.org/wiki/Create,_read,_update_and_delete), right? That's all Yelp is, at its core. Just a fancy CRUD app.

Currently we should be able to browse a list of restaurants, but we don't have a way for users of our site to add restaurants to the database. Let's add a test for that now.

`spec/features/restaurants_feature_spec.rb`:

```ruby
context 'creating restaurants' do
  scenario 'prompts user to fill out a form, then displays the new restaurant' do
    visit '/restaurants'
    click_link 'Add a restaurant'
    fill_in 'Name', with: 'KFC'
    click_button 'Create Restaurant'
    expect(page).to have_content 'KFC'
    expect(current_path).to eq '/restaurants'
  end
end
```

The test should fail like so:

```sh
Capybara::ElementNotFound:
Unable to find field "Name"
```

We have an 'Add a restaurant' link, but it doesn't go anywhere! Where should we link to? Run `bin/rake routes` if you want a clue...

If you're feeling advanced see if you can use a rails path helper rather than hardcoding a particular URL.  Once you've got the link set correctly you should get a new error like this:

```sh
AbstractController::ActionNotFound:
The action 'new' could not be found for RestaurantsController
```

This indicates that we should make a new method in `restaurants_controller.rb` to go alongside our `index` method.

`app/controllers/restaurants_controller.rb`:

```ruby
class RestaurantsController < ApplicationController
...
  def new
  end
...
```

This should give us a new test error. In this case the error should be something like:

```sh
ActionView::MissingTemplate:
Missing template restaurants/new, application/new with {:locale=>[:en], :formats=>[:html], :variants=>[], :handlers=>[:erb, :builder, :raw, :ruby, :coffee, :jbuilder]}. Searched in:
* "/Users/sam/Documents/Github/MakersAcademy/Sam/yelp_clone/app/views"
```

The problem is that our `new` method doesn't have a view associated with it. Let's make one.

erb:
`$ touch app/views/restaurants/new.html.erb`
haml:
`$ touch app/views/restaurants/new.html.haml`

This gives us a new test failure:

```sh
Failure/Error: fill_in 'Name', with: 'KFC'
Capybara::ElementNotFound:
Unable to find field "Name"
```

We're currently missing anything on that page to allow a user to submit restaurant details - let's make a form to fix that!

#### Making forms in Rails – `form_for`

HTML forms are the common way to submit data through web applications and Rails provides a lot of helpers to streamline the process of creating them.  Adjust our new template as follows:

`app/views/restaurants/new.html.erb`

```erb
<%= form_for Restaurant.new do |f| %>
  <%= f.label :name %>
  <%= f.text_field :name %>
  <%= f.submit %>
<% end %>
```

`app/views/restaurants/new.html.haml`

```haml
= form_for Restaurant.new do |f|
  = f.label :name
  = f.text_field :name
  = f.submit
```

Here, we're using Rails' built-in `form_for` helper to build a form, which takes care of a lot of things, including verifying the authenticity of the form. You can read more about that in [RailsGuides](http://guides.rubyonrails.org/form_helpers.html).

Run your tests again – RSpec will now say it doesn't know what to do with the information submitted into that form.

```sh
Failure/Error: click_button 'Create Restaurant'
AbstractController::ActionNotFound:
The action 'create' could not be found for RestaurantsController
```

### `create`

We need a `create` method!  Before implementing the following, please experiment with create doing a `raise params` instead of the below and see what that gives you.  The params is what is returned from the form submisson and it's very important to understand how it works.

```ruby
class RestaurantsController < ApplicationController
...
  def create
    Restaurant.create(params[:restaurant])
    redirect_to '/restaurants'
  end
...
```

Looks good. However there's a problem:

```sh
Failure/Error: click_button 'Create Restaurant'
ActiveModel::ForbiddenAttributesError:
ActiveModel::ForbiddenAttributesError
```

Hmmm... why doesn't this work?

Well, before Rails 3.2, it would have worked – and that was a huge security hole. `params[:restaurant]` passes in *all* the params received from the submitted form. If an unscrupulous user were to modify the form in their browser to include extra form fields, then our controller would blindly accept them as well!

### `permit`

As a result, we need to explicitly state which params we're going to allow our controller to accept, using `permit`. Let's create a private method that does this for us and add it to our controller:

```ruby
  def restaurant_params
    params.require(:restaurant).permit(:name)
  end
```

Now replace

```ruby
Restaurant.create(params[:restaurant])
```

to instead say

```ruby
Restaurant.create(restaurant_params)
```

which tells Rails that we should allow only the field labelled 'name' to be accepted by the form.

Now let's clean up that form a bit – using `Restaurant.new` inside the view logic isn't good practice, so instead we'll use `@restaurant` and let the controller deal with what that means.

`app/views/restaurants/new.html.erb`:

```erb
<%= form_for @restaurant do |f| %>
  <%= f.label :name %>
  <%= f.text_field :name %>
  <%= f.submit %>
<% end %>
```

`app/views/restaurants/new.html.haml`:

```haml
= form_for @restaurant do |f|
  = f.label :name
  = f.text_field :name
  = f.submit
```

`app/controllers/restaurants_controller.rb`:

```ruby
class RestaurantsController < ApplicationController
...
  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.create(restaurant_params)
    redirect_to '/restaurants'
  end
...
```

Much better.

### [Next Section - Reading (C"R"UD)](9_reading.md)
