# Walkthrough - Using a Controller to keep track of State

[Back to the Challenge](../02_using_a_controller_to_keep_track_of_state.md)

Let's start from our current `index.html` file. Since we're not going to be using the input any more, let's remove the contents of the `<body>` tag:

```diff
<!doctype html>
<html lang="en" ng-app="toDoApp">
  <head>
    <meta charset="utf-8">
    <title>title</title>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.5.3/angular.min.js"></script>
  </head>
  <body>
-    <div>
-      <label>Name:</label>
-      <input type="text" ng-model="yourName" placeholder="Enter a name here">
-      <hr>
-      <h1>Hello {{yourName}}!</h1>
-    </div>
  </body>
</html>
```

We need to attach a controller to our application. To do that, we can use the `.controller` function that our `toDoApp`, which is an Angular module, comes with.

This is how you build the barebone basics of an Angular controller in `controllers.js`:

```javascript
// in controllers.js

toDoApp.controller('ToDoController', function() {
  // anything in here is 'controller code'
});
```

See how we:

1. Got the root module (`toDoApp`), which is equal to `angular.module('toDoApp', [])`
2. Used the `controller` method on this root module to attach a controller module
3. Named the controller module `ToDoController`
4. Set up the controller in a callback provided to the `controller()` method.

> As your application grows, you will have more than one controller. It's a bad idea to have them all in one `controllers.js` file: why? How could you solve this?

Let's add an attribute to our `ToDoController`:

```javascript
// in controllers.js

toDoApp.controller('ToDoController', function() {
  // we can set an attribute like any other JavaScript object
  this.todo = "ToDo1";
});
```

Great! We now have a controller with some *state*. The state is a string, equal to `"ToDo1"`. Let's render this state in our HTML.

First, we need to hook our controller module up to our HTML. First, we include our script in the HTML (below Angular and below our root module declaration script, `app.js`). 

Remember how we used `ng-app` to hook our application module up to our HTML? We can do a similar thing; this time using a different `ng-` keyword. Specifically, `ng-controller`.

> These `ng-` (pronounced 'ng' like 'codi*ng*' or 'A*ng*ular') keywords are called `directives`, and they act as the main way to bond your JavaScript modules and HTML. In fact, Angular is essentially directives, modules, and Mustache syntax. Its simplicity is key to its popularity.

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
    <!-- let's put a div for our controller -->
    <div ng-controller="ToDoController as controller">
    </div>
  </body>
</html>
```

> Notice how we put our `ng-controller` in a `<div>`. We could have attached it straight to the `<body>` tag, but here's one of the main benefits of Angular: you can have more than one controller on any one page. That means you can divide your page up into different components, each with their own controller, and you don't risk any data leaking between them.

If you're interested to know why we can't just use `ng-controller="ToDoController"` here, [this is an excellent explanation](https://toddmotto.com/digging-into-angulars-controller-as-syntax/). The short answer: we have to use 'controller as' syntax to _instantiate_ the controller to a variable that can then be accessed in the HTML. 

OK, now let's use {{Mustache}} syntax to interpolate the `todo` attribute on our `ToDoController` into our HTML:

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
    <!-- let's put a div for our controller -->
    <div ng-controller="ToDoController as controller">
      {{ controller.todo }}
    </div>
  </body>
</html>
```

> Notice how {{Mustache}} syntax works kind of like Ruby's "#{string interpolation}".

We're done! We can now track application state using the controller, so long as that state is a simple string. Now let's try using more complex state, containing more than one item.

[Forward to the Challenge Map](../00_challenge_map.md)
