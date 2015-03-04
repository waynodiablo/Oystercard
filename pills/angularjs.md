AngularJS
=========

:construction: UNDER CONSTRUCTION :construction:

AngularJS is a front end JavaScript framework built on JQuery that provides a model view controller architecture and operates on a series of HTML attributes that replaces much of the JavaScript and JQuery that one needs to create a responsive single page app.

For example the following Angular enabled HTML automatically updates the header to greet the name of the person typed into the input:

```html
<!DOCTYPE html>
<html>
<body ng-app>
  <input type='text'
         ng-model='name'
         placeholder = 'Enter your name'>
  <h1>Hello <span ng-bind='name'</span></span><h1>
  <script src='angular.js'></script>
</body>
</html>
```

Here's is the equivalent achieved with inline jQuery:

```html
<!DOCTYPE html>
<html>

<body ng-app>
  <input type='text'
         ng-model='name'
         placeholder = 'Enter your name'>
  <h1>Hello <span ng-bind='name'</span></span><h1>
  <script src='jquery.js'></script>
  <script>
    $(function(){
      $('[ng-model]').on('keyup',function(){
        $('[ng-bind]').html($(this).val());
      });
    })
  </script>
</body>
</html>
```
