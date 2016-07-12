# News summary project guidance

* How will you serve your app? Maybe a very simple library like :pill: [http-server](../pills/http_server.md)?

* How will you write and run unit tests? Maybe you could write tests as functions and run them from node? Maybe you could write a tiny test framework in 20 lines of code?

* How will you write feature tests? Maybe you could use write tests as functions that use jQuery to click on things, and include your test file into your `index.html` when you want to run your tests?

* How will you intercept form submissions so they don't reload the page? `form submit event` and `preventDefault` may prove useful.

* How will you intercept URL changes so that they don't reload the page? The `hashchange` event may be useful.

* How will you implement the domain model? Maybe the constructor and prototype pattern?

* How will you map URLs to resources? How are you going to render HTML to the page? How are you going to let your HTML interface interact with your models in a clean way? Maybe a controller or two?

* How will you construct your HTML content? Maybe you'll concatenate strings? Maybe you'll implement your own templating engine.

* How will you make requests to external APIs? Maybe Ajax with jQuery? Maybe Ajax with raw XMLHttpRequest objects?
