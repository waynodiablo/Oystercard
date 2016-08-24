# Section 11: Destroying (CRU"D")

##### Deleting restaurants

To finish off CRUD, we need a *delete* method.

In `restaurants_feature_spec.rb`, let's add a test:

```ruby

...

context 'deleting restaurants' do

  before { Restaurant.create name: 'KFC', description: 'Deep fried goodness' }

  scenario 'removes a restaurant when a user clicks a delete link' do
    visit '/restaurants'
    click_link 'Delete KFC'
    expect(page).not_to have_content 'KFC'
    expect(page).to have_content 'Restaurant deleted successfully'
  end

end
...
```

If you look at `rake routes`, you'll see a `destroy` route that takes the verb `DELETE` – that's what we'll be using. Let's link this up in our restaurant view so that users can access it by adding the following line:

`app/views/restaurants/index.html.erb`:

```erb
<%= link_to "Delete #{restaurant.name}", restaurant_path(restaurant), method: :delete %>
```
`app/views/restaurants/index.html.haml`:

```haml
= link_to "Delete #{restaurant.name}", restaurant_path(restaurant), method: :delete
```

Again, `restaurant_path` takes a restaurant as an argument, but here we have to explicitly specify the `delete` method so that Rails knows we want to delete the item.

Running RSpec again will throw a different error – this time that there's a method missing.

To the restaurants controller, add a destroy method:


```ruby
...
  def destroy
    @restaurant = Restaurant.find(params[:id])
    @restaurant.destroy
    flash[:notice] = 'Restaurant deleted successfully'
    redirect_to '/restaurants'
  end
...
```

Don't forget to display the `flash[:notice]` in `application.html.erb` or `application.html.haml` , by adding it above `<%= yield %>` or `= yield`

```erb
<%= notice %>
<%= yield %>
```
```haml
= notice
= yield
```

If you are using Haml rather than ERB, delete the file `application.html.erb`, as Rails will attempt to use it by default. 

And now our tests pass and we've got all four CRUD methods!

### [Next Section - Associations](12_associations.md)
