# Guidance

* How will you serve your app? Maybe a very simple library like :pill: [http-server](../pills/http_server.md)?

* How will you write and run unit and functional tests? Have a look at [Mocha](https://mochajs.org).

* How will you let your functional tests interact with a realistic imitation of your app running in a web browser? Have a look at [Zombie.js](http://zombie.js.org).

* How will you intercept form submissions so they don't reload the page? `form submit event` and `preventDefault` may prove useful.

* How will you intercept URL changes so that they don't reload the page? The `hashchange` event may be useful.

* How will you implement the domain model? Maybe the constructor and prototype pattern?

* How will you map URLs to resources? How are you going to render HTML to the page? How are you going to let your HTML interface interact with your models in a clean way? Maybe a controller or two?

* How will you construct your HTML content? Maybe you'll implement your own templating engine.  Maybe you'll use [Mustache.js](https://github.com/janl/mustache.js).

* How will you make requests to external APIs? Maybe Ajax with jQuery? Maybe Ajax with raw XMLHttpRequest objects?
