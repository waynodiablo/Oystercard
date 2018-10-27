JavaScript Promises
===================

Promises are a technique for ensuring that certain actions will not execute in JavaScript unless certain conditions have been fulfilled. Immediately this might sound familiar to you as something that we usually use callbacks for.
Consider the following code that does an AJAX request:

```javascript
get('story.json', function(response) {
  console.log("Success!", response);
});
```

Remember AJAX is asynchronous, which means that JavaScript will keep on running after this line of code and any other code that follows it. It only runs that callback when it gets a response from the server.

One issue with this code is it doesn't handle errors. We could pass the error into our callback like so:

```javascript
get('story.json', function(error, response) {
  if (error) {
    console.error("Failed!", error);
  }
  else {
    console.log("Success!", response);
  }
});
```

This is perfectly valid code, but it's already looking messy and we've created pretty much the simplest code possible. What if we want to do another action which needs another callback following this? Before long we're going to be in a complete mess:

```javascript
get('story.json', function(error, response) {
  if (error) {
    console.error("Failed!", error);
  }
  else {
    
    console.log("First success!", response);
    
    get('story2.json', function(error, response) {
      if (error) {
        console.error("Failed!", error);
      }
      else {
        try {
          response = JSON.parse(response);
          console.log("Success!", response);
        }
        catch(error) {
          console.error("Failed!", error);
        }
      }
    }
  }
});
```

## Promises to the rescue

Enter Promises! Promises take this mess of callback code and give us a way for asyncronous request can be handled effectively and neatly, at the very time they complete. They work by providing a `then` function that handles the task in a much cleaner way once our asynchronous request has been completed together with any error handling.

Now by getting our get function to use promises we can tidy up the code: 

```javascript
get('story.json')
  .then(function(response){
    console.log("Success!", response);
  }, function(error) {
    console.error("Failed!", error);
  });
```

Promises are especially powerful in that the `then` method will always return another promise so they can be chained. This means we can tidy up the really messy example with multiple callbacks from before like so:

```javascript
get('story.json')
  .then(function(response){
    console.log("Success!", response);
  })
  .then(get('story2.json'))
  .then(JSON.parse, function(error) {
    console.error("Failed!", error);
});
```

You'll notice we've only defined the error handler once as the final argument in the last `then` method - Promises are clever enough to keep looking down the chain until they find an error callback that can be called. Only having to define one error handler which handles all the errors is one of the biggest advantages that Promises offers us - it allows us to essentially create a `try`/`catch` block that works with asynchronous code.

> Unfortunately Promises are not yet fully supported natively on all browsers, support is becoming more widespread but until then you will have to use a [library](https://github.com/jakearchibald/es6-promise) to make sure they work in all browsers.

Resources
-------

* [Promises lecture at Maker's](https://www.youtube.com/watch?v=QujWZUYpeNk)
* [Introduction to Promises](https://www.promisejs.org/)
* [HTML5 Rocks Article on Promises](http://www.html5rocks.com/en/tutorials/es6/promises)
* [jQuery Promises are Broken](https://thewayofcode.wordpress.com/tag/jquery-deferred-broken/)
* [Promises in Wicked Detail](http://www.mattgreer.org/articles/promises-in-wicked-detail/)


![Tracking pixel](https://githubanalytics.herokuapp.com/course/pills/js_promises.md)
