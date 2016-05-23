# Section 10: Updating (CR"U"D)

#### Adding a description to restaurants – migrations

Currently, our database has a restaurants table with a few columns (much like a spreadsheet in Excel). Let's say it looks something like this:

| ID | Name      |
|----|-----------|
| 1  | KFC       |
| 2  | Hawksmoor |
| 3  | Trade     |


We want to add another column to the table for a description, so it would look like this:

| ID | Name      | Description                            |
|----|-----------|----------------------------------------|
| 1  | KFC       | The filthiest 'chicken' money can buy. |
| 2  | Hawksmoor | Best steak in London - hands down.     |
| 3  | Trade     | Heart-stopping melted cheese sarnies.  |

In Rails, the way you do this is by creating a **migration**. Let's look at migrations again.

Migrations describe a set of changes you're making to your database – Rake can interpret them and run the actual SQL commands that make those changes happen without you having to get your hands dirty. They're also super-useful because if something goes wrong, you can roll your database back to a previous state by using those migration files (which provide a record of every change to your data).

```shell
$ bin/rails g migration AddDescriptionToRestaurants description:text
$ bin/rake db:migrate
```

The first command above creates a migration with adds a 'description' column (of type text) to our 'restaurants' table. The second command actually runs that migration, updating our database schema to add that column.

So if we go and [take a look at our database](https://github.com/makersacademy/course/blob/master/pills/playing_with_postgres_and_datamapper.md), we expect to see a `description` field. We also need to update our views to incorporate this new information.

`app/views/restaurants/show.html.erb`:

```erb
<p><%= @restaurant.name %></p>
<p><%= @restaurant.description %></p>
```

`app/views/restaurants/show.html.haml`:

```haml
%p= @restaurant.name
%p= @restaurant.description
```

And now the good news - we get to go back and amend our old tests to accomodate this new data! 

#### Updating restaurants

Now let's tackle updating restaurants. Testing first:

`spec/features/restaurants_feature_spec.rb`:

```ruby
...
context 'editing restaurants' do

  before { Restaurant.create name: 'KFC' }

  scenario 'let a user edit a restaurant' do
   visit '/restaurants'
   click_link 'Edit KFC'
   fill_in 'Name', with: 'Kentucky Fried Chicken'
   click_button 'Update Restaurant'
   expect(page).to have_content 'Kentucky Fried Chicken'
   expect(current_path).to eq '/restaurants'
  end

end
...
```

(Note the `before` hook which creates a restaurant in the database before running our test).

Run RSpec and follow the path it leads you down... Again, a quick look at `bin/rake routes` will show you that Rails has some built-in routes for you to use.

First, we need to add an edit link for each restaurant. In `app/views/restaurants/index.html.erb` or `app/views/restaurants/index.html.haml` add to the code that loops through each restaurant:

erb:
```erb
<%= link_to "Edit #{restaurant.name}", edit_restaurant_path(restaurant) %>
```
haml:
```haml
= link_to "Edit #{restaurant.name}", edit_restaurant_path(restaurant)
```

Note that `edit_restaurant_path` takes an argument – the restaurant you want to edit!

We need to make an `edit` method. We can use `Restaurant.find` to find a restaurant by its id.

`app/controllers/restaurants_controller.rb`:

```ruby
...

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

...
```

Now we need to create the missing `edit` view.

`app/views/restaurants/edit.html.erb`:

```erb
<%= form_for @restaurant do |f| %>
  <%= f.label :name %>
  <%= f.text_field :name %>
  <%= f.submit %>
<% end %>
```

`app/views/restaurants/edit.html.haml`:

```haml
= form_for @restaurant do |f|
  = f.label :name
  = f.text_field :name
  = f.submit
```

Cool. But we still haven't got an `update` action, as RSpec will tell you – so time to add that to `restaurants_controller.rb`.

```ruby
...
  def update
    @restaurant = Restaurant.find(params[:id])
    @restaurant.update(restaurant_params)

    redirect_to '/restaurants'
  end
...
```

And we're done for this section! Next, we'll tackle what happens when you want something to go away forever...

### [Next Section - Destroying (CRU"D")](11_destroying.md)
