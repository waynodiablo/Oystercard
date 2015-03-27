## Best Practices

* When creating your own asynchronous functions...
  * Error first callback interface
    * module.exports = function(err, cb) {};
* When using asynchronous functions
  * Check for errors in your callbacks!
    * if (err) console.error('Error in X:', err); // and return early, etc.
* Wrap asynchronous operations in process.nextTick when returning EventEmitters
* For teams:
  * Stick to a style guide. We used the Google JavaScript style guide for Node.js in Practice
* Small modules
  * The mantra of the Node community
* npm outdated
  * Life moves pretty fast, if you don't stop and look around once in awhile...
* Browserify
  * Structure client-side scripts the way you write Node
  * Reuse Node code!

**Example**

```javascript
var EventEmitter = require('events').EventEmitter;
var fs = require('fs');

function readThisFile() {
  var eventBus = new EventEmitter();

  process.nextTick(function() {                                               //1
    fs.readFile('./index.js', { encoding: 'utf8' }, function(err, data) {
      if (err) return eventBus.emit('error', err);                            //2
      eventBus.emit('data', data);
    });
  });

  return eventBus;
}

readThisFile().on('data', function(data) {
  console.log('--- Data:', data);
}
```

1. Use process.nextTick to execute something on the next cycle of the event loop. This allows the asynchronous code to run after you've returned the EventEmitter instance
2. Check for errors in the callback and handle it
