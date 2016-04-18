# Walkthrough - Angular Modules

[Back to the Challenge](../02_angular_modules.md)

Everything in Angular is split into **modules**. Modules are containers for different 'bits' of our application, kind of like **classes** in an OOP application.

In this case, our 'top-level' Angular module is our application, which we will call `toDoApp`. Let's declare that module in a new file, `app.js`:

```javascript
// in app.js
// declare a module
var toDoApp = angular.module('toDoApp', []);
```

> What is the empty array for?

Now that we've declared our top-level module, we need to wire it up with the HTML we wrote. Remember to include the `app.js` in our HTML first:

```
<!-- in the <head> of index.html, after Angular -->
<script type="text/javascript" src="app.js"></script>
```

Then we use the `ng-app` directive to 'wire' our module to our HTML (more on **directives** later on):

```html
<html lang="en" ng-app="toDoApp">
  <!-- rest of index.html -->
```

We have now created a named Angular module, `toDoApp`, and all HTML on this page is within its scope. Now, we will attach a controller module to our `toDoApp` module, so we can track (and later, manipulate) application state.

[Forward to the Challenge Map](../00_challenge_map.md)