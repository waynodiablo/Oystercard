# Walkthrough - Setting up Karma and writing unit tests

[Back to the Challenge](../10_karma.md)

## Writing a more interesting feature test

It's rare that it's actually going to be an important enough part of a feature
that you'll want to check for a title, so let's replace the protractor test with
a slightly more interesting feature test

```js
describe('Todos tracker', function() {
  it('has a todo', function() {
    browser.get('/');
    var todo = $('#todo');
    expect(todo.getText()).toEqual('ToDo1');
  });
});
```

To make this pass, we'll need to write a unit test for our controller.

## Setting up Karma

You first need to install a number of Karma packages via npm and bower

```shell
npm install karma --save-dev
npm install karma-jasmine karma-chrome-launcher --save-dev
npm install jasmine-core --save-dev
npm install -g karma-cli
bower install angular-mocks --save-dev
```
> If Bower asks you to choose a version of angular-mocks, just go for the latest
> one and add a ! to persist it to `bower.json`

Then you need to set up your karma config. This can be done with the command `karma init`, which takes you through a series of questions about your project to create the files. However in this case just create a folder called **test** and place inside it a file called **karma.conf.js** with the following code. This will be our Karma config file.

```js
module.exports = function(config){
  config.set({

    basePath : '../',

    files : [
      'app/bower_components/angular/angular.js',
      'app/bower_components/angular-mocks/angular-mocks.js',
      'app/js/**/*.js',
      'test/unit/**/*.js'
    ],

    autoWatch : true,

    frameworks: ['jasmine'],

    browsers : ['Chrome'],

    plugins : [
            'karma-chrome-launcher',
            'karma-jasmine'
    ]
  });
};
```

Now you can fire up your test runner and watch your tests pass and fail.

```bash
karma start test/karma.conf.js
```

Notice that this will throw an error since we haven't got any tests!

## Writing our first unit test

Create a file in your `test/unit` folder called **ToDoController.spec.js** and enter the following code - does any of it look familiar from RSpec?

```js
describe('ToDoController', function() {
  beforeEach(module('toDoApp'));

  var ctrl;

  beforeEach(inject(function($controller) {
    ctrl = $controller('ToDoController');
  }));
});
```

This just sets up our test - the interesting things to look at here are the `beforeEach` and `inject`. `beforeEach` is running before each test. `inject` is a built-in Angular function that allows us to access the Angular app and our controller from inside our tests.

Now let's add a test - place this below the beforeEach within the describe callback.

```js
it('initialises with a toDo', function() {
  expect(ctrl.todo).toEqual("ToDo1");
});
```

Restart karma by running `karma start test/karma.conf.js`. You should be getting a failed test now, this is because we need to define a controller. Create a file named `./app/js/controllers/ToDoController.js` and define a controller inside the file:

```js
toDoApp.controller('ToDoController', [function() {
  this.todo = "ToDo1";
}]);
```

This should pass the Karma test

## Putting it all together

Your Protractor test will still be failing, to make it pass we'll need to wire
up the controller to our `index.html` file, by adding a script tag that points
to the controller

```html
<script src="js/controllers/ToDoController.js"></script>
```

and finally change the body to:

```html
<body>
  <div id="todo" ng-controller="ToDoController as controller">
    {{ controller.todo }}
  </div>
</body>
```

[Forward to the Challenge Map](../00_challenge_map.md)
