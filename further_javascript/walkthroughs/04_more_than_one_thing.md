# Walkthrough - More than One Thing

[Back to the Challenge](../04_more_than_one_thing.md)

Let's use an array to represent multiple ToDos in our controller:

```javascript
// in controllers.js
toDoApp.controller('ToDoController', function() {
  // let's rename this to todos as well, since
  // there is more than one of them
  this.todos = ["ToDo1", "ToDo2"];
});
```

Now that we have multiple items in our controller's state, let's iterate through them using `ng-repeat`:

```html
<!doctype html>
<html lang="en" ng-app="toDoApp">
  <head>
    <meta charset="utf-8">
    <title>title</title>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.5.3/angular.min.js"></script>
    <script type="text/javascript" src="app.js"></script>
    <script type="text/javascript" src="controllers.js"></script>
  </head>
  <body>
    <div ng-controller="ToDoController as ctrl">
      <!-- 
        ng-repeat assigns temporary variable 'todo' to
        every item in ctrl.todos, our ViewModel. 
      -->
      <p ng-repeat="todo in ctrl.todos">
        {{ todo }}
      </p>
    </div>
  </body>
</html>
```

Simple strings are dull, though: we need to show more complex ToDo items. Let's change the array of strings currently in our `ToDoController` to be objects instead:

```javascript
// in controllers.js
toDoApp.controller('ToDoController', function() {
  // two objects, each with two attributes
  this.todos = [{ task: "ToDo1", completed: true }, { task: "ToDo2", completed: false }];
});
```

Let's take a look at our **View** (that is, the rendered result of our application). Currently we output (some classes omitted for brevity):

```html
<p>{ task: "ToDo1", completed: true }</p>
<p>{ task: "ToDo2", completed: false }</p>
```

> Angular Views are not the same as Rails views. In Angular, the View is what is actually output as the rendered result of combining javascript objects - like the controller - and a **Template**. Rails views are, in Angular-speak, **Templates**. Technically, Angular Views are 'projections' of the ViewModel through a Template.

Our HTML View now prints the entire objects, but we want to _interpolate_ their attributes into a nice, human-readable sentence like this:

```html
<p>ToDo1: completed</p>
<p>ToDo2: not completed</p>
```

So, we need to update the Mustache syntax in our Template:

```html
<!doctype html>
<html lang="en" ng-app="toDoApp">
  <head>
    <meta charset="utf-8">
    <title>title</title>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.5.3/angular.min.js"></script>
    <script type="text/javascript" src="app.js"></script>
    <script type="text/javascript" src="controllers.js"></script>
  </head>
  <body>
    <div ng-controller="ToDoController as ctrl">
      <p ng-repeat="todo in ctrl.todos">
        <!-- I've used a ternary (shorthand) operator to output the completed status -->
        {{ todo.task }}: {{ todo.completed ? "completed" : "not completed" }}
      </p>
    </div>
  </body>
</html>
```

_Voila!_ Our View now prints exactly what we wanted. But we're limited to precisely two items in our application state: what if we want to add or remove others?

[Forward to the Challenge Map](../00_challenge_map.md)
