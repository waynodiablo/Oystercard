JavaScript Testability
=======================

[Video of Hack Off and Testability](https://www.youtube.com/watch?v=GMsNeXVMIUQ)

***Please note, as with all Makers Academy materials, there may be subtle errors in the following materials.  Please try to approach those as challenges on which to polish your debugging skills - pull requests always welcome.***

We know that we should be testing our code, but our RPSLS game
involves a lot of UI code that isn't tested.

Our game logic code is tested with Jasmine, but the code we've written
in jQuery has no test coverage at all. In other words, if something
breaks the first we'll know about it is if our application stops
working when someone is using it. This is bad.

```javascript
$(document).ready(function(){
  var remove = function(){
    $(this).remove();
  };
  var render = function(game){
    var html = $('#list-item-template').html();
    var data = {message: game.winningMessage()}
    return Mustache.render(html,data);
  };
  var sam = new Player('Sam');
  var henry = new Player('Henry');
  var game = new Game(sam, henry);

  $('.choices img').on('click',function(){
    sam.picks($(this).data('pick'));
    henry.picks('lizard');
    $(render(game)).prependTo('#results').slideDown();
    $('li:nth-child(5)').fadeOut(3000,remove);
  });
});
```

This code is sitting inside an HTML document. We can't test JavaScript that's sitting inside an HTML page, so let's fix this by moving it out into its own file. Save the above in a folder called `lib/app.js` and link to it from your HTML page.

```html
    <script src='lib/app.js'></html>
```

Also it's *long* function, weighing in at a whopping 18 lines. And because it is nested inside:
```javascript
$(document).ready(function(){
    ...
});
```
it is a **black box** that we can't access to test.

How might we go about refactoring this code so that we can add tests? In particular, there are several areas of functionality that we are complecting (i.e. _complicating_) together:

* Presentation and interaction
* Data management and persistence
* Overall application state
* Setup and glue code to make the pieces work together

### Presentation and interaction
Let's think about the results display which is responsible for the
display and management of our game results. This is an important
aspect of our application that is responsible for the *presentation*
of our game history. A test for it might look something like this:

```javascript
describe("ResultsViewer", function() {
    it('displays result messages', function() {
        ... ?
    });
});
```
This test describes the low-level behaviour we want our ResultsViewer to have
(i.e. store result messages).

We could make a good start at implementing this by modelling our results viewer as a separate class: `ResultsViewer`.

```javascript
describe("ResultsViewer", function() {
    it('displays result messages', function() {
        var results = new ResultsViewer();
    });
});
```

In order to stop this test from failing with a "ReferenceError:
ResultsViewer is not defined" error we need to actually create a `ResultsViewer` class. Let's go ahead and create this so that we can proceed with our test. In a new file `lib/ResultsView.js` add the folowing code. Don't forget to include it in your `SpecRunner.html`.

```javascript
var ResultsViewer = function() {

};
```

We know that we would like our `ResultsViewer` to control an area of
our HTML page, so let's pass in that DOM element as an argument to our
initializer. We can update our test:

```javascript
describe("ResultsViewer", function() {
    var container;

    beforeEach(function() {
        container = $("<ul></ul>");
    });

    it('displays result messages', function() {
        var results = new ResultsViewer(container);
    });
});
```

...and update our class initializer accordingly:

```javascript
var ResultsViewer = function(el) {
    this.el = el;
    return this;
};
```
To add our result message we could define a function on our `ResultsViewer` that accepts a message to store. Let's write **the code we wish we had** before we get our test to pass:

```javascript
describe("ResultsViewer", function() {
    var container;

    beforeEach(function() {
        container = $("<ul></ul>");
    });

    it('displays result messages', function() {
        var results = new ResultsViewer(container);
        results.addResult("Test Message");
        expect(container.html()).toMatch(/Test Message/);
    });
});
```
Our test expects that messages added to `ResultsViewer` are visible in the HTML. This seems like a resonable expectation, but our test is currently failing. We could update our `ResultsViewer` to the following code which will allow our test to pass:

```javascript
var ResultsViewer = function (el) {
    this.el = $(el);
    return this;
};

ResultsViewer.prototype.addResult = function (message) {
    this.el.prepend(message);
};
```

We've added an `addResult` function that prepends the message to `this.el`.

### What is "this"?
Remember that the value of the `this` keyword depends on where you use it. In the context of our `addResult` function, `this` refers to object on which the function is defined.

### What is "this.el"?
`this.el` thereforefore refers to the variable we created when our object was initialized on the line `this.el = $(el)`.

### Our Test is Green

Our test passes. Congratulations! Have a cookie.

### Making use of our ResultsViewer
Let's use our new ResultsViewer in our code so we can show it off to our friends. We update `app.js` with the following:

```javascript
$(document).ready(function(){
  var sam = new Player('Sam');
  var henry = new Player('Henry');
  var game = new Game(sam, henry);
  var results = new ResultsViewer("#results");

  $('.choices img').on('click',function(){
    sam.picks($(this).data('pick'));
    henry.picks('lizard');
    results.addResult(game.winningMessage());
  });
});
```
Our code works, but we're not getting the result we want. The reason
    is that the results we're adding are not being fomatted. If you
    inspect the page in your JavaScript console you can see that we're
    not adding `<li></li>` tags to our ResultsViewer, just plain text messages.

### Add a failing test
We know we'd like to add `<li></li>` tags, so let's add a failing test.

```javascript
describe("ResultsViewer", function() {
    var container;

    beforeEach(function() {
        container = $("<ul></ul>");
    });

    it('displays result messages', function() {
        var results = new ResultsViewer(container);
        results.addResult("Test Message");
        expect(container.html()).toMatch(/Test Message/);
    });

    it('creates a list item per message', function() {
        var results = new ResultsViewer(container);
        results.addResult("Test Message");
        results.addResult("Another Message");
        expect(container.find("li").length).toBe(2);
    });
});
```
This test will fail because the results do not contain li elements yet.

### Tests go green

We have already seen how to prepend `<li>` elements to a `<ul>` in our original code. Let's include this in our `addResult` function.

```javascript
var ResultsViewer = function (el) {
    this.el = $(el);
    return this;
};

ResultsViewer.prototype.addResult = function (message) {
    $("<li>" + message + "</li>").prependTo(this.el);
};
```

### Later, rinse repeat

We're now in the **red-green refactor cycle** where we can continue to develop our UI widgets in a test-driven way.

As an advantage, our code inside `$(document).ready(...);` has shrunk, and our test coverage has increased. Win-Win!

Take a look at the [ui-testing-refactor branch of the rpsls-javascript-jquery repository](https://github.com/makersacademy/rpsls-javascript-jquery/tree/ui-testing-refactor) if you'd like more testing inspiration.

Resources
-----

* https://github.com/makersacademy/rpsls-javascript-jquery/tree/ui-testing-refactor
* [Writing Testable JavaScript](http://alistapart.com/article/writing-testable-javascript)


![Tracking pixel](https://githubanalytics.herokuapp.com/course/walkthroughs/javascript_testability.md)
