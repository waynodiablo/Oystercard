# Walkthrough - Controller Expressions

[Back to the Challenge](../05_controller_expressions.md)

Let's add a new method to the controller module, `addToDo()`. This method will add another object into our existing `todos` ViewModel.

> Controller methods are called 'expressions' in Angular.

```javascript
// in controllers.js

toDoApp.controller('ToDoController', function() {
  this.todos = [{ text: "ToDo1", completed: true }, { text: "ToDo2", completed: false }];

  // here's our new method
  this.addToDo = function() {
    this.todos.push({ text: "Hello World!", completed: false });
  };
});
```

> The controller module is essentially a constructor. What does that mean? Think back to how you added methods to the Thermostat.

Before we wire this controller expression to our Template, let's rewrite our references to `this`. `this` is very context-dependent, and you should try to avoid referencing one meaning of `this` within a different scope:

```javascript
// in controllers.js

toDoApp.controller('ToDoController', function() {
  // Save this to a variable as this can change depending on the context of
  // where it is being called, see
  // https://github.com/johnpapa/angular-styleguide/tree/master/a1#style-y032
  var self = this;

  self.todos = [{ text: "ToDo1", completed: true }, { text: "ToDo2", completed: false }];

  self.addToDo = function() {
    // now, no matter what, we'll push new ToDos
    // to the controller.
    self.todos.push({ text: "Hello World!", completed: false });
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
      ng-model allows us to tell angular to link
      what happens on the input to a parameter in
      our controller, in this case one called "todoText"
     -->
    <input type="text" ng-model="todoText">
    <!-- 
      now we can pass that parameter (todoText)
      into our controller expression as an argument
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
    self.todos.push({text: todoText, completed: false});
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
    self.todos.push({text: todoText, completed: false});
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
