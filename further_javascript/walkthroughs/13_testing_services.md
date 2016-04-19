# Walkthrough - Testing Services

[Back to the Challenge](../13_testing_services.md)

This time around we're going to start with a unit test. We want to write a test for our `ToDoService` that returns a list of ToDo objects created by the `ToDoFactory`

```js
see https://docs.angularjs.org/api/ngMock/service/$httpBackend#flushing-http-requests
// in toDosFeature.js
it('can mark a ToDo as complete', function(){
  browser.get('/');
  var todo = $$('#todos p').last();
  todo.element(by.css('.complete')).click();

  expect(todo.getText()).toEqual("ToDo2: completed");
});
```

Running this indicates that it can't find the element `.complete`. Let's add this in to `index.html` along with the action we want to call on our factory.

```html
<p ng-repeat="todo in ctrl.todos">
{{ todo.text }}: {{ todo.completed ? "completed" : "not
completed" }}
<span class="complete" ng-click="todo.complete();">Complete</span>
</p>
```

Try re-running your feature tests now. Can you work out why the others are now not working?

To fix them, we're going to need to change the [Jasmine matcher](http://jasmine.github.io/2.0/introduction.html#section-Included_Matchers) we're using to `toMatch`:

```js
describe('Todos tracker', function() {
  it('has several ToDos', function() {
    browser.get('/');
    var todos = $$('#todos p');
    expect(todos.first().getText()).toMatch('ToDo1: completed');
    expect(todos.last().getText()).toMatch('ToDo2: not completed');
  });

  it('can add a ToDo', function() {
    browser.get('/');
    $('#new-todo-name').sendKeys("NewTodo");
    $('#add-todo').click();

    var todo = $$('#todos p').last().getText();
    expect(todo).toMatch('NewTodo: not completed');
  });

  it('can remove a ToDo', function() {
    browser.get('/');
    var todos = $$('#todos p');
    var initialCount = todos.count();

    $('#remove-todo').click();

    expect(todos.count()).toEqual(1);
  });

  it('can mark a ToDo as complete', function(){
    browser.get('/');
    var todo = $$('#todos p').last();
    todo.element(by.css('.complete')).click();

    expect(todo.getText()).toMatch("ToDo2: completed");
  });
});
```

Time now to implement our `todo.complete()` method. To do that we're going to need to change todo into a factory to store our logic. Start with a new karma test that tests that `ToDoFactory` can mark a ToDo as complete

```js
// test/unit/ToDoFactory.spec.js
describe('ToDoFactory', function() {
  beforeEach(module('toDoApp'));

  var toDo;

  beforeEach(inject(function(ToDoFactory) {
    toDo = new ToDoFactory('New ToDo');
  }));

  it('is incomplete by default', function(){
    expect(toDo.completed).toBe(false);
  });

  it('can be marked as complete', function() {
    toDo.complete();
    expect(toDo.completed).toBe(true);
  });
});
```

Now build the factory to pass this test.

```js
// ToDoFactory.js
toDoApp.factory('ToDoFactory', function() {
  var ToDo = function(todoText){
    this.text = todoText;
    this.completed = false;
  };

  // we attach a new method to the Todo prototype
  // just like we did Thermostat
  ToDo.prototype.complete = function() {
    this.completed = true;
  };

  return ToDo;
});
```

Now we need to update our controller test as we need to tell our controller to use instances of the `ToDoFactory` we've just built instead of the object literal todos (created using `{text: "Todo2", completed: false}`):

```js
//test/unit/toDoController.spec.js
describe('ToDoController', function() {
  beforeEach(module('toDoApp'));

  var ctrl, ToDoFactory;

  beforeEach(inject(function($controller, _ToDoFactory_) {
    ctrl = $controller('ToDoController');
    // This has underscores around it so we can then set it to a variable called
    // ToDoFactory, see:
    // https://docs.angularjs.org/api/ngMock/function/angular.mock.inject
    ToDoFactory = _ToDoFactory_;
  }));

  it('initialises with several todos', function() {
    // Create todos now using the factory
    var todo1 = new ToDoFactory("ToDo1");
    var todo2 = new ToDoFactory("ToDo2");

    // First todo needs to be marked as complete
    todo1.complete();

    expect(ctrl.todos).toEqual([todo1, todo2]);
  });

  it('adds a new todo', function() {
    ctrl.addToDo('NewToDo');

    // Similarly this now uses a factory
    var todo = new ToDoFactory("NewToDo");
    expect(ctrl.todos.pop()).toEqual(todo);
  });

  it('removes the last todo', function() {
    initialCount = ctrl.todos.length;

    ctrl.removeToDo();

    expect(ctrl.todos.length).toEqual(initialCount - 1);
  });
});
```

And our updated controller:

```js
toDoApp.controller('ToDoController', ['ToDoService', 'ToDoFactory', function(ToDoService, ToDoFactory) {
  var self = this;

  self.todos = [new ToDoFactory('ToDo1'), new ToDoFactory('ToDo2')];

  // The first todo needs to be marked as complete
  self.todos[0].complete();

  self.addToDo = function(todoText) {
    self.todos.push(new ToDoFactory(todoText));
  };

  self.removeToDo = function() {
    self.todos.pop();
  };
}]);
```

To get the feature tests passing we need to include the factory in `index.html` (if only Protractor made this clear in its error messages!). Put in the `<head>` of the page

```html
<script src="js/factories/ToDoFactory.js"></script>
```

And everything should be green. Almost there now!

[Forward to the Challenge Map](../00_challenge_map.md)
