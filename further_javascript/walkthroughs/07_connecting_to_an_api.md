# Walkthrough - Connecting to an API

[Back to the Challenge](../07_connecting_to_an_api.md)

Let's construct a **Service** that connects to our API:

```javascript
// in todoFetcher.js

toDoApp.service('todoFetcher', function() {
  // service code
});
```

> This is how you construct the barebones of an Angular Service.

Services are a service recipe, like Factories. Services are designed to be **singletons**: there exists only one of them in an application. So, there is only one `todoFetcher` in our entire application, and we can use it from wherever we like. In addition, they will return the return value from a function when injected; where Factories will return a constructor itself. Confused? Here are some [great explanations of the differences](http://stackoverflow.com/questions/15666048/angularjs-service-vs-provider-vs-factory).

Let's write the **code we wish we had** in the controller, and inject this service:

```javascript
// in controllers.js

// add the todoFetcher to the list of injections
toDoApp.controller('ToDoController', ['todoFetcher', 'todoFactory', function(todoFetcher, todoFactory) {
  var self = this;
  // this is the code we wished we had
  self.todos = todoFetcher.index();

  self.addToDo = function(todoText) {
    self.todos.push(new Todo(todoText));
  };

  self.removeToDo = function() {
    self.todos.pop();
  }
}]);
```

Now to make that code work! First, we need it to stop throwing an error because the method isn't defined. So, in our service, we'll define a method `index()`:

```javascript
// in todoFetcher.js

toDoApp.service('todoFetcher', function() {
  this.index = function() {
    // code that constructs an array of Todos from the API
  };
});
```

We can use the Angular module `$http` to fetch data from the API. Let's inject it into our service, and set up the structure:

```javascript
// in todoFetcher.js

// remember Angular's weird array injection thing
toDoApp.service('todoFetcher', ['$http', function($http) {
  this.index = function() {
    // use $http's built-in .get() method
    // that uses promises to stay synchronous
    $http.get('<URL>')
      .then(function(resp) {
        // good response
      }, function(err) {
        // error response
      });
  };
}]);
```

> Notice the `.then()` function. This is a Promise: it won't execute until the .get() method returns a value. This is important in JavaScript, as JavaScript runs **asynchronously**: it won't normally wait for a line of code to finish before running the next one (unlike Ruby). This can lead to **race conditions**: for example, handling the response from an API before the call to that API has even finished.

Inside our `$http.get()` method, we want to call our URL. We know that the base URL is http://quiet-beach-24792.herokuapp.com, and that the resource, todos, are RESTful. So our URL will be `url/resources.json`, or http://quiet-beach-24792.herokuapp.com/todos.json. Let's make a GET request from our service to that URL, and see what we get back:

```javascript
// in todoFetcher.js

toDoApp.service('todoFetcher', ['$http', function($http) {
  this.index = function() {
    // update our URL
    $http.get('http://quiet-beach-24792.herokuapp.com/todos.json')
      .then(function(resp) {
        // and print whatever we get back
        console.log(resp)
      }, function(err) {});
  };
}]);
```

We get an object! That means our service is successfully connecting to an API. Check out the Object in the Chrome Dev Tools: it responds to a `.data()` method, which returns an array of JSON objects: our ToDos.

Our service needs to return an array of `Todo` objects, and it's currently receiving an array of JSON objects. Let's convert them:

```javascript

toDoApp.service('todoFetcher', ['$http', function($http) {
  this.index = function() {
    // let's initialize an empty array...
    var todos = [];
    $http.get('http://quiet-beach-24792.herokuapp.com/todos.json')
      .then(function(resp) {
        // ...and iterate through the JSON objects...
        for(var i = 0; i < resp.data.length; i++) {
          // ...and construct a new Todo from each JSON object
          // pushing them to the todos array...
          todos.push(new Todo(resp.data[i].text))
        }
      }, function(err) {});
    // ...then we return the todos array we constructed
    return todos;
  };
}]);
```

It works! Loading the page, we see a list of Todos loaded from the API. We've built a frontend framework that connects to a backend!

Let's refactor our service a bit, as it's looking super-messy. There are some private methods begging to get out. Here's my efforts (you can do better!):

```javascript
// in todoFetcher.js

toDoApp.service('todoFetcher', ['$http', function($http) {
  var self = this;

  self.index = function() {
    var todos = [];
    self._fetchTodosFromApi(todos);
    return todos;
  };

  self._fetchTodosFromApi = function(todos) {
    $http.get('http://quiet-beach-24792.herokuapp.com/todos.json')
      .then(function(resp) {
        self._handleResponseFromApi(resp.data, todos)
      }, function(err) {});
  };

  self._handleResponseFromApi = function(data, todos) {
    for(var i = 0; i < data.length; i++) {
      todos.push(new Todo(data[i].text))
    }
  }
}]);
```

You should now have an idea of how Services and Factories can be used to construct ViewModels and remove responsibilities from Controllers. That's your basic introduction to Angular: on to Test-Driven Development!

[Forward to the Challenge Map](../00_challenge_map.md)
