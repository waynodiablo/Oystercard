# Walkthrough - Testing Services

[Back to the Challenge](../13_testing_services.md)

This time around we're going to start with a unit test. We want to write a test for our `ToDoService` that returns a list of ToDo objects created by the `ToDoFactory`. Note that our test has forced us to change how `getIndex` works so it now returns a promise rather than an empty array of `todos` that gets updated later:

```js
describe('ToDoService', function() {
  beforeEach(module('toDoApp'));

  var ToDoService, httpBackend;

  var toDoData = [{text: "ToDo1", completed: true}, {text: "ToDo2", completed: false}];

  beforeEach(inject(function(_ToDoService_, _ToDoFactory_, $httpBackend) {
    ToDoService = _ToDoService_;
    ToDoFactory = _ToDoFactory_;
    httpBackend = $httpBackend;
  }));

  it('fetches a list of todos', function(){

    // Mock out our http call
    httpBackend.expectGET("http://quiet-beach-24792.herokuapp.com/todos.json").respond(toDoData);

    var todo1 = new ToDoFactory("ToDo1", true);
    var todo2 = new ToDoFactory("ToDo2", false);

    ToDoService.getAll().then(function(todos) {
      // Wait for the response to come back before doing our expectation
      expect(todos).toEqual([todo1, todo2]);
    });

    // We have to flush httpBackend at the end of the test see
    // see https://docs.angularjs.org/api/ngMock/service/$httpBackend#flushing-http-requests
    httpBackend.flush();
  });
});
```

To get this passing we'll need to do a refactored version of our `ToDoService`

```js
//test/unit/ToDoService.spec.js
toDoApp.service('ToDoService', ['$http', 'ToDoFactory', function($http, ToDoFactory) {
  var self = this;

  self.getAll = function() {
    // Here we're now just returning the value of the `then` method
    // Due to how promises work this returns another promise, which in our test
    // or controller we can call `.then` on again, and it will pass this method
    // the array of `ToDoFactory` objects returned from the `then` method below
    //
    // It sounds complicated, but basically it's a way of being able to in our
    // controller do
    //
    // ToDoService.getAll().then(function(todos) {
    //   self.todos = todos;
    // });
    //
    // More on this here
    // http://blog.ninja-squad.com/2015/05/28/angularjs-promises/
    return $http.get('http://quiet-beach-24792.herokuapp.com/todos.json')
      .then(_handleResponseFromApi);
  };

  function _handleResponseFromApi (response) {
    return response.data.map(function(toDoData){
      return new ToDoFactory(toDoData.text, toDoData.completed);
    });
  }
}]);
```

Now this needs to be integrated into our controller. We'll update our `toDoController.spec.js` to use `$httpBackend`:

```js
describe('ToDoController', function() {
  beforeEach(module('toDoApp'));

  var ctrl, httpBackend, ToDoFactory;
  var toDoData = [{text: "ToDo1", completed: true}, {text: "ToDo2", completed: false}];

  beforeEach(inject(function($httpBackend, $controller, _ToDoFactory_) {
    ctrl = $controller('ToDoController');
    ToDoFactory = _ToDoFactory_;
    httpBackend = $httpBackend;

    // Mock out our http call
    httpBackend.expectGET("http://quiet-beach-24792.herokuapp.com/todos.json").respond(toDoData);

    // We have to flush straight away here so that by the time we do our tests
    // the ToDos have been set to `self.todos`
    httpBackend.flush();
  }));

  ...
```

And we can finally use our new service, injecting it into our `ToDoController.js`

```js
toDoApp.controller('ToDoController', ['ToDoService', 'ToDoFactory', function(ToDoService, ToDoFactory) {
  var self = this;

  // Use the ToDoService to fetch our todos
  ToDoService.getAll().then(function(todos){
    self.todos = todos;
  });

  self.addToDo = function(todoText) {
    self.todos.push(new ToDoFactory(todoText));
  };

  self.removeToDo = function() {
    self.todos.pop();
  };
}]);
```

Now turning to our feature tests, they'll be failing for the same reason as in [Challenge 12](12_testing_factories.md), so add to the `index.html` in the `<head>` a link to the `ToDoService`

But it's still failing! And it's taking ages...that's because it's actually hitting the API (four times) and it's not returning the data we want. We're going to need to mock http controllers in Protractor.

[Forward to the Challenge Map](../00_challenge_map.md)
