Instagram
========

### Completion time - 1 week

![Instagram](http://www.esato.com/gfx/news/img/facebook-buys-instagram_1334005838.jpg)

This week's project is a clone of [Instagram](http://instagram.com). The goal is to continue to enhance our knowledge of Rails, introduce some more advanced concepts:

* Uploading and processing images using Paperclip, hosting via Amazon S3
* Managing secret information (e.g. private keys)
* Many-to-many relationships in Rails (with tagging)
* Geocoding with Google Maps
* Twitter Bootstrap
* Creating APIs using Rails + [jBuilder](https://github.com/rails/jbuilder)

We deployed to Heroku at the end of last week. For this project we should be deploying much more regularly - ideally a few times every day. This allows us to catch any deployment issues early.

***And of course we don't need to tell you again but for safety's sake let us note that as with all Makers Academy materials, there may be subtle errors in the following materials.  Please try to approach those as challenges on which to polish your debugging skills - pull requests always welcome.***

## Version 1 - Image uploading

The fundamental feature of Instagram is that users can upload their photos to the service to share online - this is what we'll focus on first. For performance reasons, and because Heroku offers us very limited disk space, we'll use [Amazon's Secure Storage Service](http://aws.amazon.com/s3/) (S3) to persist our uploaded images.

It's very important to keep your S3 secret key - the key allows anyone use cloud computing resources at your expense! Use Rails's `secrets.yml`, and be sure it's in your `.gitignore`. If you accidentally push your secrets, immediately [revoke your secret key and generate a new one](http://docs.aws.amazon.com/gettingstarted/latest/wah-linux/getting-started-cleanup-key-pair.html).

### Specification

* Users can register/sign up (implemented with Devise)
* Users must be signed in to create a new posts
* Posts can be created by providing a title and attaching an image
* The image should be processed using Paperclip, to generate thumbnail-sized images
* The homepage should list all the uploaded thumbnails - users can click through to see full-sized images
* Images are hosted on S3. Stub calls to S3 for your test environment
* Ensure your S3 secret key *is not stored on Github*

### Version 1.5 - Integrate Bootstrap

![Twitter Bootstrap](http://www.revillweb.com/wp-content/uploads/2013/12/twitter-bootstrap.jpg)

To quickly improve the look of our site, we'll use a popular CSS framework - [Twitter Bootstrap](http://getbootstrap.com/). Integrate Bootstrap using the [official SASS port](https://github.com/twbs/bootstrap-sass), and use it to add:

* A responsive grid of images on the front page
* A fixed navigation bar, with links to Login etc.
* Improved forms
* *Optional* - Full-sized images appear in modals

## Version 2 - Tagging

Next we'll add the ability for photos to be tagged, as in the original Instagram. This will introduce our first [many-to-many relationship](http://guides.rubyonrails.org/association_basics.html#the-has-and-belongs-to-many-association) in Rails. Given the relative complexity of our tags implementation, we'll want to make use of unit tests to ensure we've covered all the various edge cases.

### Specification

* Users can specify a list of space-separated (or comma separated tags) - e.g. "#yolo, #swag"
* Tags should be created in the DB if they're novel (have never been used before), otherwise existing tags should be associated with the new post
* Duplicate tags (e.g. "#yolo, #yolo") should be stripped out
* Tags without a hash (#) at the beginning should be considered invalid
* Tags should be displayed underneath each post
* Users can click on tags to display *only* posts tagged with that tag
* *Optional* - Use a jQuery plugin like [Inputosaurus](http://sproutsocial.github.io/inputosaurus-text/) or [bootstrap-tags](http://timschlechter.github.io/bootstrap-tagsinput/examples/) to give a more pleasant UX for entering tags

## Version 3 - Geocoding and Maps

Finally we'll make our service location-aware. Users can (optionally) enter the address at which a photo was taken. Photos with locations display the option to show a map, with the location of the photo marked.

We have various options for geocoding (turning an address into latitude/longitude). It's more efficient to do it on the server-side, using a gem like [geocoder](https://github.com/alexreisner/geocoder). However, for simplicity's sake, we'll use a pure JS solution, using the [Google Maps API v3](https://developers.google.com/maps/documentation/javascript/), and [gmaps.js](http://hpneo.github.io/gmaps/).

### Specification

* Users can enter an address when creating a post
* Posts with addresses display a link to "View Map"
* When a visitor views the map a call is made to Google server's to geocode the address, then a map is rendered, centered on the resulting location
* *Optional* - A clickable marker should be pinned at the location of the photo. Clicking it displays the photo's title and `created_at` date.
* *Optional* - Use the Geolocation API to prefill the address field with the user's current address.

## Resources

* [Associations (many-to-many)](http://guides.rubyonrails.org/association_basics.html#the-has-and-belongs-to-many-association)
* [Twitter Bootstrap getting started](http://getbootstrap.com/getting-started/)
* [Paperclip quick start](https://github.com/thoughtbot/paperclip#quick-start)
* [GMaps geocoding example](http://hpneo.github.io/gmaps/examples/geocoding.html)

## Walkthroughs

* [Paperclip](https://github.com/makersacademy/course/blob/master/walkthroughs/paperclip.md)
* [S3](https://github.com/makersacademy/course/blob/master/walkthroughs/S3.md)
* [Devise](https://github.com/makersacademy/course/blob/master/walkthroughs/devise.md)
* [Bootstrap](https://github.com/makersacademy/course/blob/master/walkthroughs/bootstrap.md)
* [Tagging](https://github.com/makersacademy/course/blob/master/walkthroughs/tags.md)
* [More Tagging](https://github.com/makersacademy/course/blob/master/walkthroughs/more_tags.md)


![Tracking pixel](https://githubanalytics.herokuapp.com/course/challenges/instagram.md)
