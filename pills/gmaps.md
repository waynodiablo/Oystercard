Google Maps
================

:construction: UNDER CONSTRUCTION :construction:

[Video](https://www.youtube.com/watch?v=rAH78ga58_c)

Google Maps is a JavaScript library that makes use of a Google API to display an interactive map in the browser.  You can embed a Google Map in a simple static web page:

https://developers.google.com/maps/tutorials/fundamentals/adding-a-google-map

but there are also wrappers that help web application frameworks like Rails to convert data stored on the server side into JSON data that can be rendered in the template that will eventually be processed as an HTML page on the client.  [GoogleMap4Rails](https://github.com/apneadiving/Google-Maps-for-Rails) is a popular Rails GMaps wrapper

```sh
rails g scaffold Model AddLatLongAddressToCharity latitude:float longitude:float address:string
```

In Gemfile

```ruby 
gem ‘geocoder’
```

bundle install

```ruby
class Charity
  geocoded_by :address
  after_validation :geocode
end
```

Run server, make a charity, and then following the rest of the github read add following to Gemfile

```ruby
gem 'gmaps4rails'
```

restart the server and run bundle install


2) HTML

Add a div to bear your map, example:

```html
<div style='width: 800px;'>
  <div id="map" style='width: 800px; height: 400px;'></div>
</div>
```
2) Javascript Dependencies:

Insert google scripts in your index page

```html
<script src="//maps.google.com/maps/api/js?v=3.13&amp;sensor=false&amp;libraries=geometry" type="text/javascript"></script>
<script src='//google-maps-utility-library-v3.googlecode.com/svn/tags/markerclustererplus/2.0.14/src/markerclusterer_packed.js' type='text/javascript'></script>
```

You'll require underscore.js too, see here: underscorejs.org/ (`lo-dash` is compatible too, your choice!). —> put that in vendors directory

3) put 

```sh
//= require underscore
//= require gmaps/google
```

in app/assets/javascripts/application.js

...

However as you might imagine, GMaps is not tied to a Rails backend.  Here's an example of a GMap application communicating with a Rails backend:

https://github.com/ToastShaman/nodejs-socketio-gmaps



 

