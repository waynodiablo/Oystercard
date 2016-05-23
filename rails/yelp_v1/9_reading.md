# Section 9: Reading (C"R"UD)

So far we've got creating restaurants down, but we can't update or delete them, nor can we really 'read' them (though we can see an index page of them).

##### Reading (showing) restaurants

We want to be able to click on the name of a restaurant and be taken to its individual profile page, just like on the real Yelp.

Let's write a test:

```ruby
...
context 'viewing restaurants' do

  let!(:kfc){ Restaurant.create(name:'KFC') }

  scenario 'lets a user view a restaurant' do
   visit '/restaurants'
   click_link 'KFC'
   expect(page).to have_content 'KFC'
   expect(current_path).to eq "/restaurants/#{kfc.id}"
  end

end
...
```

Great: so we're expecting that a user can click on the restaurant's name on the main page and get to the restaurant's profile page (whose path should be a subroot of restaurants with the ID of the restaurant in question). The test should fail – let's walk through the steps needed to make it pass.

First, we need to update the view to show that link.

In the `@restaurants.each do |restaurant|` loop in `app/views/restaurants/index.html.erb` or `app/views/restaurants/index.html.haml`, add this line (removing the existing `restaurant.name`):

erb:
```erb
<%= link_to restaurant.name, restaurant_path(restaurant) %>
```

haml:
```haml
= link_to restaurant.name, restaurant_path(restaurant)
```
Now each restaurant should have its name displayed as a clickable link. But we're still missing a 'show' method in the restaurants controller, so let's add one.

`app/controllers/restaurants_controller.rb`:

```ruby
def show
  @restaurant = Restaurant.find(params[:id])
end
```

This method gets called when you go to `/restaurants/:restaurant_id`, and uses the ID passed in the URL to look up the correct record from the database.

Now all we need is a view for the restaurant show method. Let's make one.

`app/views/restaurants/show.html.erb`:

```erb
<p><%= @restaurant.name %></p>
<p><%= @restaurant.description %></p>
```

`app/views/restaurants/show.html.haml`:

```haml
%p= @restaurant.name
```
That'll do for this view for the moment, but we'll be coming back here as we expand the app to have reviews for restaurants.

### [Next Section - Updating (CR"U"D)](10_updating.md)
