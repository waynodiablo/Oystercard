JavaScript Promises
===================

Promises are a technique for ensuring that certain actions will not execute in JavaScript unless certain conditions have been fulfilled. Immediately this might sound familiar to you as something that usually we simply use callbacks for.
Consider the following code that does an AJAX request:

```javascript
get('story.json', function(response) {
  console.log("Success!", response);
});
```

Remember AJAX is asynchronous, which means that javascript will keep on running after this line of code any other code that follows it, and only runs that callback when it gets a response from the server.

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

This is perfectly valid code, but it's already looking messy and we've created pretty much the most simple code possible. What if we want to do another action which needs another callback following this? Before long we're going to be in a complete mess:

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

Enter Promises! Promises take this mess of callback code and give us a way for asyncronous request can be handled effectively and neatly, and at the the time they complete. They work by providing a `then` function that handles in a much more clean way what to do when our asyncronous request has been completed, and any error handling as well.

Now by getting our get function to use promises we can tidy up the code: 

```javascript
get('story.json')
  .then(function(response){
    console.log("Success!", response);
  }, function(error) {
    console.error("Failed!", error);
  });
```

Already things are looking better. But what's actually going on here? What we've done is refactored the original `get` method to return a `Promises` object which provides us with the `then` method that we've used instead of callbacks. An example of how we could do this is below:

```javascript
function get(url) {
  // Return a new promise.
  return new Promise(function(resolve, reject) {
    // Do the usual XHR stuff
    var req = new XMLHttpRequest();
    req.open('GET', url);

    req.onload = function() {
      // This is called even on 404 etc
      // so check the status
      if (req.status == 200) {
        // Resolve the promise with the response text
        resolve(req.response);
      }
      else {
        // Otherwise reject with the status text
        // which will hopefully be a meaningful error
        reject(Error(req.statusText));
      }
    };

    // Handle network errors
    req.onerror = function() {
      reject(Error("Network Error"));
    };

    // Make the request
    req.send();
  });
}
```

The key thing to notice here is that 'get' returns a Promise object, that tells us whether the promise has been rejected (i.e. there's an error) or resolved (i.e. everything was successful). If it was resolved the first function in our `then` method is called, if rejected the second callback is called instead, simple as that.

Now there is no chance that the asynchronous request (in this example an AJAX request) can fail before we have a chance to add event listeners, and we have successfuly removed difficult to fix errors that can result from timing issues in the running of our JavaScript related to the speed of network connections and so forth.

Promises are especially powerful in that the `then` method will always return another promise so they can be chained. This means we can tidy up the really messy example from before with multiple callbacks like so:

```javascript
get('story.json').then(function(response){
  console.log("Success!", response);
}).then(get('story.json')).then(JSON.parse, function(error) {
  console.error("Failed!", error);
});
```

You'll notice we've only defined the error handler once as the final argument in the last `then` method - Promises are clever enough to keep looking down the chain until they find an error callback that can be called. Only having to define one error handler which handles all the errors is one of the biggest advantages that Promises offers us - it allows us to essentially create a `try`/`catch` block that works with asynchronous code.

> Unfortunately Promises are not yet fully supported natively on all browsers, support is becoming more widespread but until then you will have to use a [library](https://github.com/jakearchibald/es6-promise) to make sure they work in all browsers.

## Promises in NodeJS

NodeJS doesn't support Promises natively but we can use a library like [Bluebird](https://github.com/petkaantonov/bluebird) to use Promises. You'll notice this offers other methods apart from just `then` such as `catch`, this is just a neater way of handling errors rather than passing a callback as the second argument of `then`.

Let's have a look at some code that we can tidy using Promises - take this example where we're doing an asynchronous file read (the comments explain what we're doing):

```javascript
var fs = require('fs');

// Without promises
fs.readFile('./file.json', 'utf8', function (err, val) {
  if (err) {
    // Handle any errors passed back from the readFile method
    console.error("unable to read file, beacuse: ", err.message);
  }
  else {
    try {
      val = JSON.parse(val);

      // If the file reads successfully and we parse the JSON with no errors log the result
      console.log(val.name);
    }
    catch (e) {

      // If we get a SyntaxError the JSON has failed to parse
      if (e instanceof SyntaxError) {
        console.error("invalid json in file");
      }
      else {
        throw e;
      }
    }
  }
});
```

Now by using the Bluebird library we can again hugely tidy up this code:

```javascript
var Promise = require('bluebird');
var fs = require('fs');

// First we need to "promisfy" the fs library using bluebird:
// now if we add "Async" as a suffix to any method in the fs library
// it will return the result as a promise
Promise.promisifyAll(fs);

// This allows us to clean up the code above into something more readable
fs.readFileAsync('./file.json', 'utf8').then(JSON.parse).then(function(val) {

  // If the file reads successfully and we parse the JSON with no errors log the result
  console.log(val.name);

}).catch(SyntaxError, function(e) {

  // If we get a SyntaxError the JSON has failed to parse
  console.error('invalid json in file');

}).catch(Promise.OperationalError, function (e) {

  // Handle any errors passed back from the readFile method
  console.error("unable to read file, because: ", e.message);

});
```

Resources
-------

* [Introduction to Promises](https://www.promisejs.org/)
* [HTML5 Rocks Article on Promises](http://www.html5rocks.com/en/tutorials/es6/promises)
* [jQuery Promises are Broken](https://thewayofcode.wordpress.com/tag/jquery-deferred-broken/)
* [ECMAScript 6 Draft on Promises](http://people.mozilla.org/~jorendorff/es6-draft.html#sec-promise-objects)
* [Promises in Node.js](http://12devs.co.uk/articles/promises-an-alternative-way-to-approach-asynchronous-javascript/)
* [Promises in Wicked Detail](http://www.mattgreer.org/articles/promises-in-wicked-detail/)
