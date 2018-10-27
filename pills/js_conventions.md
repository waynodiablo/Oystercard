# JavaScript conventions

Each language has its own unique set of coding conventions. Ignoring conventions won't stop your code working, but it may make your code less easy to understand, and different developers using different conventions can lead to a messy codebase.

Some conventions are different between JavaScript and Ruby, while others will be familiar.

## Variable naming

When naming variables in JS, we tend to use 'camel casing' rather than 'snake casing', as in Ruby. That means for variable names that are more than one word, we mark the start of a new word with a capital letter, instead of preceeding it with an underscore. For example

~~~ruby
the_meaning_of_life = 42
~~~

becomes:

~~~javascript
var theMeaningOfLife = 42
~~~

We also use the keyword `var` whenever creating a new variable, to ensure correct scoping.

## Method naming

Likewise, we'll use camel casing for method names

~~~javascript
Thermostat.prototype.increaseTemperature = function() {
  // ...
}
~~~

We can't use question marks in method names, like in Ruby:

~~~ruby
class Dog
  def purebreed?
    true
  end
end
~~~

So we'll often prefix methods that return boolean values with `is`:

~~~javascript
Dog.prototype.isPurebreed = function() {
  return true;
}
~~~

JavaScript doesn't have the same concept of `private` methods that we have in Ruby. By convention, methods that are meant to be internal to a class are prefixed by an underscore.

~~~ruby
class Banana
  private

  def my_private_method
    # ...
  end
end
~~~

becomes

~~~javascript
Banana.prototype._myPrivateMethod = function() {
  // ...
}
~~~

## Constants

There's no concept of constants in the current version of JS. By convention though, we can mark values we don't expect to change by writing them all in capitals (just like Ruby constants). Unlike Ruby, we won't receive a warning if we change these values though.

~~~javascript
Dog.prototype.NUMBER_OF_LEGS = 4;
~~~

With ES6, there is new way to declare constants:

~~~javascript
const NUMBER_OF_LEGS = 4;
~~~

> Note this won't work in older browsers (for example Internet Explorer 10) - see more [here](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Statements/const)


## Resources

* [Airbnb's JS style guide](https://github.com/airbnb/javascript) - (very in-depth)


![Tracking pixel](https://githubanalytics.herokuapp.com/course/pills/js_conventions.md)
