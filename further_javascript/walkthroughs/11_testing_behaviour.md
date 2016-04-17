# Walkthrough - More than One Thing

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
  <div id="todos" ng-controller="ToDoController as ctrl">
    <p ng-repeat="todo in ctrl.todos">
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
    <div id="todos" ng-controller="ToDoController as ctrl">
      <p ng-repeat="todo in ctrl.todos">
      {{ todo.text  }}: {{ todo.completed ? "completed" : "not
      completed"  }}
      </p>
      <input id="new-todo-name" type="text" ng-model="todoText">
      <button id="add-todo" ng-click="ctrl.addToDo(todoText);">Add a
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
  this.todos = [{ text: "ToDo1", completed: true   }, { text: "ToDo2",
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
<button id="remove-todo" ng-click="ctrl.removeToDo();">Remove last ToDo</button>
```

Write a new unit test

```js
// toDoController.spec.js
```

Let's add a new method to the controller module, `addToDo()`. This method will add another object into our existing `todos` ViewModel.

> Controller methods are called 'expressions' in Angular.

```javascript
// in controllers.js

toDoApp.controller('ToDoController', function() {
  this.todos = [{ text: "ToDo1", completed: true }, { text: "ToDo2", completed: false }];

  // here's our new method
  this.addToDo = function() {
    this.todos.push({ text: "Hello World!", completed: false })
  };
});
```

> The controller module is essentially a constructor. What does that mean? Think back to how you added methods to the Thermostat.

Before we wire this controller expression to our Template, let's rewrite our references to `this`. `this` is very context-dependent, and you should try to avoid referencing one meaning of `this` within a different scope:

```javascript
// in controllers.js

toDoApp.controller('ToDoController', function() {
  // 'hoist' the current context to the controller
  var self = this;

  self.todos = [{ text: "ToDo1", completed: true }, { text: "ToDo2", completed: false }];

  self.addToDo = function() {
    // now, no matter what, we'll push new ToDos
    // to the controller.
    self.todos.push({ text: "Hello World!", completed: false })
  };
});
```

Let's wire this up with the Template! We need to add a button, and then apply the `ng-click` directive to wire clicks on the button to the controller expression:

```html
<body>
  <div ng-controller="ToDoController as ctrl">
    <p ng-repeat="todo in ctrl.todos">
      {{ todo.text }}: {{ todo.completed ? "completed" : "not completed" }}
    </p>
    <!-- here's the new button -->
    <button ng-click="ctrl.addToDo();">Add a ToDo</button>
  </div>
</body>
```

> Again, we're 'wiring together' our Angular modules and HTML using `ng-` directives. In this case, we're listening for events on `click`, scoped to the button. How is this different from how you listened for events in jQuery?

Now that we can add our dummy ToDo, let's try to add a named one. To do this, we need to use the **`ng-model`** directive. `ng-model` bundles many of the features we've been building manually into one directive: it sets aside some of the application's state (which it calls 'scope'), and binds changes in the template to changes in that state. It then immediately displays the results of changes.

Let's add an input to our HTML so we can make a custom ToDo. We'll use `ng-model` to ask our application to put aside some scope for whatever we enter, and we'll pass that named scope to our `addToDo()` method in the controller (so we can use it to build a custom ToDo object in the controller state):

```html
<body>
  <div ng-controller="ToDoController as ctrl">
    <p ng-repeat="todo in ctrl.todos">
      {{ todo.text }}: {{ todo.completed ? "completed" : "not completed" }}
    </p>
    <!-- 
      ng-model will set aside some named scope
      here the named scope is 'todoText'
     -->
    <input type="text" ng-model="todoText">
    <!-- 
      now we can pass that chunk of named scope
      into our controller expression as a parameter
    -->
    <button ng-click="ctrl.addToDo(todoText);">Add a ToDo</button>
  </div>
</body>
```

Let's now update the controller expression to use our custom text:

```javascript
// in controllers.js
toDoApp.controller('ToDoController', function() {
  var self = this;

  self.todos = [{ text: "ToDo1", completed: true }, { text: "ToDo2", completed: false }];

  // we want to accept a parameter...
  self.addToDo = function(todoText) {
    // ...and use that parameter to construct our custom text!
    self.todos.push({text: todoText, completed: true})
  };
});
```

> Where and how do you think you would handle edge cases, like empty ToDos, or ToDos that were too long?

Now we just need a way to remove our ToDos. This one is easier. First we need something in the Template:

```html
<body>
  <div ng-controller="ToDoController as ctrl">
    <p ng-repeat="todo in ctrl.todos">
      {{ todo.text }}: {{ todo.completed ? "completed" : "not completed" }}
    </p>
    <input type="text" ng-model="todoText">
    <button ng-click="ctrl.addToDo(todoText);">Add a ToDo</button>
    <!-- 
      a new button with ng-click, 
      ready for a controller expression 
    -->
    <button ng-click="ctrl.removeToDo();">Remove last ToDo</button>
  </div>
</body>
```

And in the Controller, an expression:

```javascript
// in controllers.js

toDoApp.controller('ToDoController', function() {
  var self = this;

  self.todos = [{ text: "ToDo1", completed: true }, { text: "ToDo2", completed: false }];

  self.addToDo = function(todoText) {
    self.todos.push({text: todoText, completed: false})
  };

  // the simplest thing is to just pop() the last ToDo
  // off our todos array
  self.removeToDo = function() {
    self.todos.pop();
  }
});
```

Great! We can now build custom ToDos and remove them. However, our Controller is starting to do a bit too much. Should Controllers really handle the specifics of constructing objects? Soon, we'll want to mark our ToDos as 'completed' - should the Controller do that, too?

When our Controller is overstuffed, we put logic in...you guessed it, the Model. In Angular, Models are kind of strange. Let's take a look at them.

[Forward to the Challenge Map](../00_challenge_map.md)
