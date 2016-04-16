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

[Forward to the Challenge Map](../00_challenge_map.md)
