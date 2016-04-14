# Walkthrough - Setting up with Angular

[Back to the Challenge](../01_setting_up_with_angular.md)

Let's create a minimal HTML document, and call it `index.html`. Its contents should look like this:

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>title</title>
  </head>
  <body>
    <!-- page content -->
  </body>
</html>
```

Adding in the Angular script, our `index.html` will look like this:

```html
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>title</title>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.5.3/angular.min.js"></script>
  </head>
  <body>
  </body>
</html>
```

And, setting up our Angular app in accordance with the Angular guide, our `index.html` will look like this:

```html
<!doctype html>
<html lang="en" ng-app>
  <head>
    <meta charset="utf-8">
    <title>title</title>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.5.3/angular.min.js"></script>
  </head>
  <body>
    <div>
      <label>Name:</label>
      <input type="text" ng-model="yourName" placeholder="Enter a name here">
      <hr>
      <h1>Hello {{yourName}}!</h1>
    </div>
  </body>
</html>
```

> Open index.html (either by double-clicking or using `open index.html` from the command line). Notice how letters you type in the input immediately reflect in the header. This is Angular's first piece of magic: data-binding. Think of how this process is similar to updating the temperature of the Thermostat by clicking one of its buttons.

[Forward to the Challenge Map](../00_challenge_map.md)
