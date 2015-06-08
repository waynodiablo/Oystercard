# Angular Factories, Services (and Providers)

## Overview

### Why?

You have an Angular app. You don't know where to put the business logic. You want somewhere to put your business logic. You could put it in the controllers. You may have already put it in the controllers. This might make you a **bad person**... if you don't refactor. But, you really want to be a **good person** and not have logic in the controllers. So, to make sure that your controllers stay thin and logic-free, we need somewhere to put all that code.

### What?

Angular has three concepts to help you organize code: services, factories and providers. These give you a way of grouping bits of logic into objects that can then be injected into anything that needs them. Angular itself has many built-in services that you may have already used, such as `$http` and `$resource`.

### How?

At a deeper level, all three of these are actually providers, with factories and services providing syntactic sugar to make them easier to use. But, at a simpler level, you can think of services and factories as a "recipe" telling the injector how to create the object in question.

If that's confusing, maybe it's time for some code. Let's build a very stupid calculator to illustrate the differences between each concept.

## Factory

```javascript
app.factory('calculatorFactory', function() {
  return {
    add: function(x, y) {
      return x + y;
    },
    subtract: function(x, y) {
      return x - y;
    },
    divide: function(x, y) {
      return x / y;
    },
    multiply: function(x, y) {
      return x * y;
    }
  }
});
```

A factory **returns** whatever you tell it to. In most cases, this will be an object, but it could equally be a primitive or a function.

## Service

A service creates a **new** object, using the `new` keyword. If you understand how `new` works, factories and services are *almost* identical. Services are usually used to create objects written with a function constructor, while factories give you the option to return something that won't have `new` called on it (e.g. object literals, primitives, etc.)

```javascript
app.service('calculator', function() {
  this.add = function(x, y) {
    return x + y;
  }

  this.subtract = function(x, y) {
    return x - y;
  }

  this.divide = function(x, y) {
    return x / y;
  }

  this.multiply = function(x, y) {
    return x * y;
  }
});
```

You can also use a service to wrap code you have written by injecting the function into your service, like so:

```javascript
function Calculator() {

}

Calculator.prototype.add = function(x, y) {
  return x + y;
}

//...other functions go here

app.service('calculator', Calculator);
```

Generally speaking, once you get comfortable with JavaScript, converting between the two becomes relatively trivial.

## Provider

Providers allow you to set configuration options before your application starts. As the Angular documentation actually covers how to set a provider up quite well, creating a provider is left as an exercise for a reader.

## Using these in controllers

Inject them like you would any built-in Angular service:

```javascript
app.controller('exampleCtrl', ['calculatorFactory', function(calculatorFactory) {
  //whatever your controller does
}])
```

Now you can call `calculatorFactory.add`, `calculatorFactory.subtract` etc. in your controller. Passing in a service or provider will behave in the same way.

By using factories and services, your logic can be broken down into small chunks and can be re-used anywhere else in your app. And yes, you can inject factories and services into each other just as you can with a controller. So now, you can structure your app in a more object-oriented way and follow SRP.

## Resources
- [Factory vs Service vs Provider](http://tylermcginnis.com/angularjs-factory-vs-service-vs-provider/)
- [Factory vs Service with example](http://blog.manishchhabra.com/2013/09/angularjs-service-vs-factory-with-example)
- [StackOverflow Answer](http://stackoverflow.com/questions/15666048/service-vs-provider-vs-factory)
- [Official Angular docs](https://docs.angularjs.org/guide/providers)
