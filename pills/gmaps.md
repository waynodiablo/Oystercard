Google Maps
================

:construction: UNDER CONSTRUCTION :construction:

[Video](https://www.youtube.com/watch?v=rAH78ga58_c)

Google Maps is a JavaScript library that makes use of a Google API to display an interactive map in the browser.  You can embed a Google Map in a simple static web page:

https://developers.google.com/maps/tutorials/fundamentals/adding-a-google-map

but there are also wrappers that help web application frameworks like Rails to convert data stored on the server side into JSON data that can be rendered in the template that will eventually be processed as an HTML page on the client.  [GoogleMap4Rails](https://github.com/apneadiving/Google-Maps-for-Rails) is a popular Rails GMaps wrapper

```sh
rails g scaffold Charity title:string description:text address:string latitude:float longitude:float
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

Run server, make a charity (with an address, but not latitude and longitude), and then following the rest of the github read add following to Gemfile

```ruby
gem 'gmaps4rails'
```

restart the server and run bundle install

Add a div to bear your map, e.g. 

```html
<div style='width: 800px;'>
  <div id="map" style='width: 800px; height: 400px;'></div>
</div>
```
Insert google scripts at the top of your index page

```html
<script src="//maps.google.com/maps/api/js?v=3.13&amp;sensor=false&amp;libraries=geometry" type="text/javascript"></script>
<script src='//google-maps-utility-library-v3.googlecode.com/svn/tags/markerclustererplus/2.0.14/src/markerclusterer_packed.js' type='text/javascript'></script>
```

Grab underscore.js from http://underscorejs.org/ and put that in vendors directory

Also put the following:

```sh
//= require underscore
//= require gmaps/google
```

in app/assets/javascripts/application.js

Add the following to the bottom of your index page:

```html
<script type="text/javascript">
  handler = Gmaps.build('Google');
  handler.buildMap({ provider: {}, internal: {id: 'map'}}, function(){
    markers = handler.addMarkers(<%=raw @hash.to_json %>);
    handler.bounds.extendWith(markers);
    handler.fitMapToBounds();
  });
</script>
```

and adjust your charities controller like so:

```rb
  def index
    @charities = Charity.all

    @hash = Gmaps4rails.build_markers(@charities) do |charity, marker|
      marker.lat(charity.latitude)
      marker.lng(charity.longitude)
    end

  end
```

and voila you should have a map in your index page with markers corresponding to your charity addresses.  There are lots the way to extend the map - see the github repo for details:

https://github.com/apneadiving/Google-Maps-for-Rails

However as you might imagine, GMaps is not tied to a Rails backend.  Here's an example of a GMap application communicating with a Rails backend:

https://github.com/ToastShaman/nodejs-socketio-gmaps

[TODO: add notes on node setup]



 

