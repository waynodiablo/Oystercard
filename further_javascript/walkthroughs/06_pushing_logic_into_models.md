# Walkthrough - Pushing Logic into Models

[Back to the Challenge](../06_pushing_logic_into_models.md)

Instead of object literals in our Controller's state, we want real, functional JavaScript instances. Here's how our `ToDoController`'s state looks at the moment:

```javascript
// in controllers.js

self.todos = [{ text: "ToDo1", completed: true }, { text: "ToDo2", completed: false }];
```

Even worse, here's how we construct new objects to add into the state:

```javascript
// in controllers.js

self.todos.push({ text: todoText, completed: false });
```

Ugh. We are literally constructing the JavaScript object in the controller. In Rails, this would be like us passing Hashes around instead of real instances of a class:

```ruby
# in articles_controller.rb

@todos << { text: params[:text], completed: false }
```

_Disgusting._

> Why is that so disgusting?

Let's build a Factory to build real objects for us, not these 'object literal', hash-like things:

```javascript
// in ToDoFactory.js

toDoApp.factory('ToDoFactory', function() {

});
```

> This is how you construct a barebones Factory.

At the moment, our factory doesn't do much. Let's encapsulate within it all the logic we'd need to build a ToDo:

```javascript
// in ToDoFactory.js

toDoApp.factory('ToDoFactory', function() {

  // first, we declare the constructor for the model
  // just like Thermostat
  var Todo = function(todoText){
    this.text = todoText;
    // We can't just set a default value of false until ES6 so we have to do this
    // See: http://stackoverflow.com/questions/894860/set-a-default-parameter-value-for-a-javascript-function
    this.completed = (typeof completed !== 'undefined') ? completed : false;
  };

  // then we return the constructor from the Factory
  return Todo;
});
```

> We can also attach methods to prototypes inside factories, which we'll do next.

Let's refactor our controller to use the Factory we just built instead of object literals.

When we couple modules together in Angular, we have to _inject_ them in to one another. Here's Angular's syntax for injection:

```javascript
// in controllers.js
toDoApp.controller('ToDoController', ['ToDoFactory', function(ToDoFactory) {
  // controller code
}]);
```

Notice how we _inject_ the `ToDoFactory` by passing it as a string and as the first element of an array. This array is the callback to `.controller()`. The `function() { // controller code }` is then the second element of this array. It's a bit crazy, but this is how Angular does it.

OK, let's refactor the `addToDo()` method in our `ToDoController` to use a Factory instead of constructing an object literal on-the-fly:

```diff
// in controllers.js
toDoApp.controller('ToDoController', ['ToDoFactory', function(ToDoFactory) {
  var self = this;

  self.todos = [];

  self.addToDo = function(todoText) {
-    self.todos.push({ text: todoText, completed: false })
+    self.todos.push(new ToDoFactory(todoText));
  };

  self.removeToDo = function() {
    self.todos.pop();
  }
}]);
```

That looks much better! Now it feels like we're constructing a real object. Drawing on our earlier Ruby example, it's like we've refactored our Rails controller:

```diff
# in articles_controller.rb

- @todos << { text: params[:text], completed: false }
+ @todos << Todo.new(text: params[:text])
```

_Much nicer_.

Now that we have a model that handles its own construction, let's add a `complete()` method to it so `Todo`s can be responsible for completing themselves:

```javascript
// in ToDoFactory.js

toDoApp.factory('ToDoFactory', function() {
  Todo = function(todoText, completed){
    this.text = todoText;
    this.completed = (typeof completed !== 'undefined') ? completed : false;
  };

  // we attach a new method to the Todo prototype
  // just like we did Thermostat
  Todo.prototype.complete = function() {
    this.completed = true;
  };

  return Todo;
});
```

Now that `Todo` objects can complete themselves, wiring the functionality up to the Template is trivial:

```html
<body>
  <div ng-controller="ToDoController as ctrl">
    <p ng-repeat="todo in ctrl.todos">
      {{ todo.text }}: {{ todo.completed ? "completed" : "not completed" }}
      <!-- Click this and complete the Todo -->
      <span ng-click="todo.complete();">Complete</span>
    </p>
    <input type="text" ng-model="todoText">
    <button ng-click="ctrl.addToDo(todoText);">Add a ToDo</button>
    <button ng-click="ctrl.removeToDo();">Remove last ToDo</button>
  </div>
</body>
```

We could now, if we wished, add Updating, Deleting, and Ordering functionality to `Todo`s directly - all without changing our Controller. Awesome!

[Forward to the Challenge Map](../00_challenge_map.md)
