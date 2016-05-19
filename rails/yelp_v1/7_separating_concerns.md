# Section 7: Separating Concerns

##### Rendering restaurants in the view

Now, in `restaurants_controller.rb` we want to get all of the restaurants from the database. Let's do this in the wrong way first, but see if you can spot what we are doing wrong. Replace the contents of `restaurants/index.html.erb` or `restaurants/index.html.haml` with the following:  

**erb:**
```erb
<% if Restaurant.all.any? %>
  <% Restaurant.all.each do |restaurant| %>
    <h2><%= restaurant.name %></h2>
  <% end %>
<% else %>
  <h1>No restaurants yet</h1>
<% end %>

<a href="#">Add a restaurant</a>
```
**haml:**
```haml
- if Restaurant.all.any?
  - Restaurant.all.each do |restaurant|
    %h2= restaurant.name
- else
  %h1 No restaurants yet!

%a(href='#') Add a restaurant
```
The tests should all pass now, but what cardinal sin have we committed?

We're talking directly to our model from our view, and this can lead to dangerous spaghetti code.  We should prefer to have our controller mediate communication between the model and view.

Let's add a method to suppport that (*the method below replaces the old method*):

```ruby
def index
  @restaurants = Restaurant.all
end
```

This creates an instance variable `@restaurants` that is accessible in our `index` view. Let's refer to it in `app/views/restaurants/index.html.erb` or `app/views/restaurants/index.html.haml`:

erb:
```erb
<% if @restaurants.any? %>
  <% @restaurants.each do |restaurant| %>
    <h2> <%= restaurant.name %> </h2>
  <% end %>
<% else %>
  No restaurants yet
<% end %>

<a href='#'>Add a restaurant</a>
```
haml:
```haml
- if @restaurants.any?
  - @restaurants.each do |restaurant|
    %h2= restaurant.name
- else
  No restaurants yet

%a(href='#') Add a restaurant
```

So in summary our URL http://localhost:3000/restaurants hits the Rails routing system, which passes the request to the index action in the restaurants controller, which queries the database for any restaurant models.  The controller then 'passes' (using some Rails magic) an instance variable containing all the restaurant models to the view, where they can be correctly formatted.  The controller returns the resulting HTML back to the browser for display to the end user.

### [Next Stage - Reading (C"R"UD)](8_reading.md)
