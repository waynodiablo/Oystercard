JavaScript Promises
===================

Promises are a technique for ensuring that certain actions will not execute in JavaScript unless certain conditions have been fulfilled.  It might seem like this can already be achieved in JavaScript since once can check for whether images have completed loading with the 'complete' property, and the ability to add event listeners.  The problem is that this might miss images that already error'd before we had the chance to actually add an event listener, and it gets particularly complicated for multiple image download.  Promises are intended to provide a general framework for ensuring that the results of any asynchronous action (such as image downloading) can be handled effectively, at the the time they complete. 

Promises have been available in JavaScript in the form of libraries for some time, and are now making their way into core JavaScript.  Promises operate by providing a 'then' function that allows us to specify the precise actions that will be taken when an asynchronous operation either completes or fails.  For example (code from the [HTML5 Rocks Article on Promises](http://www.html5rocks.com/en/tutorials/es6/promises)):

```javascript
get('story.json').then(function(response) {
  console.log("Success!", response);
}, function(error) {
  console.error("Failed!", error);
});
```

The code above relies on a function 'get', which we might define as follows:

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

The key thing to notice here is that 'get' returns a Promise object, that can signal whether the promise has been rejected or resolved (or fulfilled).  These two states lead to the selection of the successful completion or the failure operations that we pass to the 'then' method of the problem.  As a result there is no chance that the asynchronous request (in this example an AJAX request) can fail before we have a chance to add event listeners, and we have successfuly removed difficult to fix errors that can result from timing issues in the running of our JavaScript related to the speed of network connections and so forth.

Promises are very powerful in that they can also be chained to handle multiple events, and sequenced to ensure that they are presented in a particular order, but they are not yet fully supported on all browsers, so they are not a complete panacea, although support is becoming more widespread and we can look forward to them being a reliable tool in the not too distant future.


Resources
-------

* [HTML5 Rocks Article on Promises](http://www.html5rocks.com/en/tutorials/es6/promises)
* [jQuery Promises are Broken](https://thewayofcode.wordpress.com/tag/jquery-deferred-broken/)
* [ECMAScript 6 Draft on Promises](http://people.mozilla.org/~jorendorff/es6-draft.html#sec-promise-objects)
* [Promises in Node.js](http://12devs.co.uk/articles/promises-an-alternative-way-to-approach-asynchronous-javascript/)
* [Promises in Wicked Detail](http://www.mattgreer.org/articles/promises-in-wicked-detail/)
