gmaps walkthrough
----------

* first up problem with grid when we have pictures that have variable height - can fix this up by giving a fixed height to .panel-default

```css
height: 500px;
```

* but not ideal, what we should do is adjust how many posts are in a particular row - each set of say 3 posts should be in a new row, and there is a helper we can use (in index.html.erb):

```ruby
<% @posts.in_groups_of(3, false).each do |post_triplet| %>
  <div class='row'>
    <% post_triplet.each do |post| %>
      <%= render post %> # shorthand for <%= render 'posts/post', post: post %>
    <% end %>
  </div>
<% end %>
```

* can be refactored to 

```ruby
<% @posts.in_groups_of(3, false).each do |post_triplet| %>
  <div class='row'>
      <%= render post_triplet %> 
  </div>
<% end %>
```

* can adjust controller to change the order to the posts

def index
  @posts = Post.all.order(created_at: :desc)
end

* let's now add the ability to tag photos with address - update posts_feature_spec.rb

fill_in 'Address', with: '25 City Road'

* watch that test fail

* add address to new.html.erb

```html
<%= f.label :address%>
<%= f.text_field :address%>
```

* get undefined method 'address' field

* so create a migration

```
bin/rails g migration AddAddressToPosts address:text
```

* run that migration

```
bin/rake db:migrate
```

* will also need to whitelist the address attribute in posts controller

```ruby
params[:post].permit(:title, :description, :image, :tag_names, :address)
```

* let's just make this work for the moment and do TDD javascript a bit later

* so where should the map actually go?  

* we need a route, but this time, let's have a single instance using resource singular

resources :posts do
  resource :map
end

* run rake routes to see that this new style of resource

* now let's add a link to the map for each post in _post.html.erb

```html
<%= link_to 'Map', post_map_path(post), class: 'btn btn-success' %>
```

* clicking on this should tell us that we don't have a controller

* so generate a controller

```
bin/rails g controller maps
```

* complains that we have no show method

* so create a show method

```ruby
def show
end
```

* then complains we have no template

* so create show.html.erb

```html
<div class='container'>
  <h1>Our awesome map will go here</h1>
</div>
```

* should now be able to click link - and can refer to post in the show method

```ruby
def show
  @post = Post.find params[:post_id]
end
```

* and let's ensure the link is not present if we don't have an address

```html
<% unless post.address.blank? %>
  <%= link_to 'Map', post_map_path(post), class: 'btn btn-success' %>
<% end %>
```

* complete google maps api is very powerful - arguably too powerful in that there are so many different methods we can use - so let's use http://hpneo.github.io/gmaps

* We want to geocode, so drop gmaps.js into our vendor/javascripts directory, and require that in our applications.js

```js
//= require gmaps
```

* this will give us an error in the browser console

Uncaught Google Maps API is required. Please register the following JavaScript Library: http://maps.google.com/maps/api/js?sensor=true

* so add this in application.html.erb

```html
<script src="http://maps.google.com/maps/api/js?sensor=true"></script>
```

* let's start with the simplest example of making a map with some javascript in show.html.erb - this is not the best practice - there are better places to put the javascript, but to keep things simple we'll start with this

```html
<div class='container'>
  <h1>Our awesome map will go here</h1>
  <div id="map"></div>
  <script>
  var map = new GMaps({
    div: '#map',
    lat: -12.043333,
    lng: -77.028333
  });
</script>
</div>
```

* and we'll want some css to give our map a size - let's put that in maps.css.scss

```css
#map {
  width: 600px;
  height: 400px;
}
```

* so a new post can now display a static map, and we can adjust the latitude and longitude to make that static map appear in different places, but what we want is to dynamically set the map location based on the address of our post

* in order to do that let's grab the geocoding example from http://hpneo.github.io/gmaps/examples/geocoding.html


```html
<div class='container'>
  <h1>Our awesome map will go here</h1>
  <div id="map"></div>
  <script>
  var map = new GMaps({
    div: '#map',
    lat: -12.043333,
    lng: -77.028333
  });
  GMaps.geocode({
    address: $('#address').val(),
    callback: function(results, status) {
      if (status == 'OK') {
        var latlng = results[0].geometry.location;
        map.setCenter(latlng.lat(), latlng.lng());
        map.addMarker({
          lat: latlng.lat();
          lng: latlng.lng()
        });
      }
    }
  });
</script>
</div>
```

* we could hard code the address to display, and check for failures in geocoding, e.g. 

```html
<div class='container'>
  <h1>Our awesome map will go here</h1>
  <div id="map"></div>
  <script>
  var map = new GMaps({
    div: '#map',
    lat: 0,
    lng: 0
  });
  GMaps.geocode({
    address: '25 City Road, London',
    callback: function(results, status) {
      if (status == 'OK') {
        var latlng = results[0].geometry.location;
        map.setCenter(latlng.lat(), latlng.lng());
        map.addMarker({
          lat: latlng.lat();
          lng: latlng.lng()
        });
      } else {
        alert('Could not find address');
      }
    }
  });
</script>
</div>
```

* this should work, but let's remove the error handling for now and make this fully dynamic by using erb tags to insert the actual post address

```html
<div class='container'>
  <h1>Our awesome map will go here</h1>
  <div id="map"></div>
  <script>
  var map = new GMaps({
    div: '#map',
    lat: 0,
    lng: 0
  });
  GMaps.geocode({
    address: '<%= @post.address %>',
    callback: function(results, status) {
      if (status == 'OK') {
        var latlng = results[0].geometry.location;
        map.setCenter(latlng.lat(), latlng.lng());
        map.addMarker({
          lat: latlng.lat();
          lng: latlng.lng()
        });
      }
    }
  });
</script>
</div>
```

* and now we can create posts with maps that will point to their specified addresses

* so this is not best practice - we should prefer that this javascript was in a separate javascript file - and at the moment it is mixed up with erb (multiple languages code smell) and we'll get lots of very similar but slightly different pieces of javascript being run in our browser, which is not very efficient

* best practice is to prefer to use ajax and json 

* so the url to get the address information about the post is http://localhost:3000/posts/12.json and if we go there we see we don't have a show action for the PostsController, so let's create that in posts_controller.rb

```ruby
def show
  @post = Post.find params[:id]
end
```

* now let's create a show.json.jbuilder view to return JSON, e.g.

```
json.address @post.address
```

* this could also be used to get all sorts of other information about posts via json

* back to the map, let's wrap our gmap javascript in an ajax request, where we can replace our ugly erb with a reference to the post object returned from the json request


```html
<div class='container'>
  <h1>Our awesome map will go here</h1>
  <div id="map"></div>
  <script>
  $.get('/posts/12.json', function(post){
    var map = new GMaps({
      div: '#map',
      lat: 0,
      lng: 0
    });
    GMaps.geocode({
      address: post.address,
      callback: function(results, status) {
        if (status == 'OK') {
          var latlng = results[0].geometry.location;
          map.setCenter(latlng.lat(), latlng.lng());
          map.addMarker({
            lat: latlng.lat();
            lng: latlng.lng()
          });
        } 
      }
    });
  })

</script>
</div>
```

* the problem now is that the id is hard coded, but we can fix that using a data-id in our map div

```html
<div class='container'>
  <h1>Our awesome map will go here</h1>
  <div id="map" data-id=<%= @post.id %>></div>
  <script>
  var postId = $('#map').data('id');
  $.get('/posts/'+postId+'.json', function(post){
    var map = new GMaps({
      div: '#map',
      lat: 0,
      lng: 0
    });
    GMaps.geocode({
      address: post.address,
      callback: function(results, status) {
        if (status == 'OK') {
          var latlng = results[0].geometry.location;
          map.setCenter(latlng.lat(), latlng.lng());
          map.addMarker({
            lat: latlng.lat();
            lng: latlng.lng()
          });
        } 
      }
    });
  })

  </script>
</div>
```

* and this javascript can now be extracted into maps.js file in our app/assets/javascripts directory

```javascript
$(document).ready(function(){
  var postId = $('#map').data('id');
  $.get('/posts/'+postId+'.json', function(post){
    var map = new GMaps({
      div: '#map',
      lat: 0,
      lng: 0
    });
    GMaps.geocode({
      address: post.address,
      callback: function(results, status) {
        if (status == 'OK') {
          var latlng = results[0].geometry.location;
          map.setCenter(latlng.lat(), latlng.lng());
          map.addMarker({
            lat: latlng.lat();
            lng: latlng.lng()
          });
        } 
      }
    });
  })
})
```

* and our html is now clean:

```html
<div class='container'>
  <h1>Our awesome map will go here</h1>
  <div id="map" data-id=<%= @post.id %>></div>
  </div>
```

* note that we could have just put the address directly in as a data attribute and avoided the json call, but that leaves us with rather a lot of control in the html
, and here we are opening up a generic channel for grabbing data about our posts via json


