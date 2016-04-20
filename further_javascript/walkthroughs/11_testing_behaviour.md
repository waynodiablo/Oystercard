# Walkthrough - Testing Behaviour

[Back to the Challenge](../11_testing_behaviour.md)

Let's first change our protractor test to look for multiple ToDos:

```js
// in toDosFeature.js
describe('Todos tracker', function() {
  it('has several ToDos', function() {
    browser.get('/');
    var todos = $$('#todos p');
    expect(todos.first().getText()).toEqual('ToDo1: completed');
    expect(todos.last().getText()).toEqual('ToDo2: not completed');
  });
});
```

This will of course fail. So let's update `index.html`. Note the id has been
updated to `todos` to indicate there are now multiple todos.

```html
<body>
  <div id="todos" ng-controller="ToDoController as controller">
    <p ng-repeat="todo in controller.todos">
      {{ todo.text }}: {{ todo.completed ? "completed" : "not completed" }}
    </p>
  </div>
</body>
```

Our template is looking right, but the controller needs to be changed to get the
feature test passing. To do that, let's update our unit test:


```js
// ToDoController.spec.js
describe('ToDoController', function() {
  beforeEach(module('toDoApp'));

  var ctrl;

  beforeEach(inject(function($controller) {
    ctrl = $controller('ToDoController');
  }));

  it('initialises with several todos', function() {
    var todos = [
      {text: "ToDo1", completed: true},
      {text: "ToDo2", completed: false}
    ];

    expect(ctrl.todos).toEqual(todos);
  });
});
```

Now let's update our controller

```javascript
// in controllers.js
toDoApp.controller('ToDoController', function() {
  // two objects, each with two attributes
  this.todos = [{ text: "ToDo1", completed: true }, { text: "ToDo2", completed: false }];
});
```

Both our unit and e2e tests should be passing now.

## Adding ToDos

A new feature (adding ToDos) calls for a new feature test:


```js
//todosFeature.js

it('can add a ToDo', function() {
  browser.get('/');
  // sendKeys tells protractor to enter the string "NewToDo" into the input
  $('#new-todo-name').sendKeys("NewToDo");
  $('#add-todo').click();

  var todo = $$('#todos p').last().getText();
  expect(todo).toEqual('NewToDo: not completed');
});
```

We're writing out in our feature test what we want our `index.html` to look
like. Updating that file gives us:

```html
  <body>
    <div id="todos" ng-controller="ToDoController as controller">
      <p ng-repeat="todo in controller.todos">
      {{ todo.text  }}: {{ todo.completed ? "completed" : "not
      completed"  }}
      </p>
      <input id="new-todo-name" type="text" ng-model="todoText">
      <button id="add-todo" ng-click="controller.addToDo(todoText);">Add a
ToDo</button>
    </div>
  </body>
```

It's now clear we need a method `addToDo()` in our controller. This will require
a new Karma test:

```js
// toDoController.spec.js
it('adds a new todo', function() {
  ctrl.addToDo('NewTodo');

  var todo = {text: "NewTodo", completed: false};
  expect(ctrl.todos.pop()).toEqual(todo);
});
```

And in the controller

```js
toDoApp.controller('ToDoController', function() {
  var self = this;
  //  two objects, each with two attributes
  self.todos = [{ text: "ToDo1", completed: true   }, { text: "ToDo2",
completed: false   }];

  self.addToDo = function(todoText) {
    self.todos.push({text: todoText, completed: false});
  };
});
```

Karma should be green now, as should our protractor tests.

## Removing ToDos

The exact same process is needed for removing ToDos. Start with a protractor
test:

```js
// todosFeature.js
it('can remove a ToDo', function() {
  browser.get('/');
  var todos = $$('#todos p');
  var initialCount = todos.count();

  $('#remove-todo').click();

  // This has a magic number, how could this magic number be avoided?
  // The solution is actually surprisingly complex so we've kept in the magic
  // number for simplicity's sake
  expect(todos.count()).toEqual(1);
});
```

Update `index.html`

```html
<button id="remove-todo" ng-click="controller.removeToDo();">Remove last ToDo</button>
```

Write a new unit test for the `removeToDo` method we need

```js
// toDoController.spec.js
it('removes the last todo', function() {
  initialCount = ctrl.todos.length;

  ctrl.removeToDo();

  expect(ctrl.todos.length).toEqual(initialCount - 1);
});
```

And make all the tests pass by adding an expression to the controller

```js
// toDoContoller.js
self.removeToDo = function() {
    self.todos.pop();
}
```

[Forward to the Challenge Map](../00_challenge_map.md)
