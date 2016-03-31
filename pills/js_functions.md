# `function` in JavaScript

As you become familiar with JavaScript, you will see the `function` keyword used in ways that appear roughly equivalent to three concepts in Ruby: _classes_, _blocks_ and _methods_.

`function` looks like a class declaration:
```javascript
function Car() {

}

var car = new Car();
```

`function` looks like a block:
```javascript
['one', 'two', 'three'].forEach(function(number) {
    console.log(number);
});
```

`function` looks like a method definition:
```javascript
dog = {}; //creates a new, empty object
dog.bark = function()  {
  return 'Woof!';
}

dog.bark();  // returns 'Woof!'
```

While it's convenient to use these analogies, they can lead to an inaccurate picture of how JavaScript really works.  As a language, JavaScript is fundamentally different to Ruby and understanding these differences will make you a better programmer.

So let's begin with a simple **tl;dr**:

The `function` keyword in JavaScript creates an object that can be **called**.  (We say _call_ in JavaScript, but that will make for confusing reading since 'call' has lots of meanings in English; let's use _invoke_ instead).  What makes a function _appear_ to behave like a Ruby class, block or method has nothing to do with the function itself; and everything to do with **how the function is _invoked_**.

> In Ruby, we invoke (call) _methods_, not objects (a method belongs to an object).  But imagine that's just semantics.  Can you visualize a method as being just another object?  Perhaps it would help to think of it as an instance of a `Method` class or something similar?  Don't worry if you're only vaguely grasping this; you're already ahead of many JavaScript hobbyists!

## The anatomy of `function`
We've become familiar in Ruby with _literals_.  These are expressions that directly create a new object whenever they are evaluated:
```ruby
"Ben"  # creates a new String object
[]  # creates a new Array object
{}  # creates a new Hash object
```
The `function` keyword in JavaScript creates a new Function object (i.e. an object that can be invoked):
```javascript
var bark = function() {
  return 'Woof';
}

bark();  //invoking the function will return 'Woof'
```
You must include the parentheses when invoking a function, even if there are no arguments.  Can you reason why?  What is `bark;` on its own with no parentheses?

You can declare arguments in functions, as you would expect:
```javascript
var bark = function(name) {
  return name + ' says Woof';
}

bark('Barney');  //will return 'Barney says Woof'
```
> If you want to return a value from a JavaScript function, you must explicitly use `return`, otherwise it will just return `undefined`.


**Now let's talk about how JavaScript functions look like Ruby concepts...**

## `function` is like `class`
This is probably the biggest source of confusion, so we'll deal with it first.

In Ruby, we define a class and instantiate it like this:
```ruby
class Car

end

car = Car.new
```
In JavaScript, we see this:
```javascript
function Car() {

}

var car = new Car();
```

Which looks very similar.  It's easy to think of `Car` as a class in JavaScript.  But it's not; _it's just a function_.  **There are no classes in JavaScript**, but we do use functions as a convenient way to instantiate objects that share behaviour.

The important thing to notice is _how the function is invoked_.  It is invoked using JavaScript's `new` keyword and that makes it behave in a very specific way.

> The detail of what `new` actually does here is beyond the scope of this pill.  For now, it just creates a new object and initializes it with the function `Car`.

### Initialization code
In Ruby, we have an `initialize` method, which is called when a new object is created:
```ruby
class Dog
  def initialize(name)
    @name = name
  end
end
```

In JavaScript, _there are no classes_, only objects.  To initialize an object created with the `new` keyword, we add code to the function:

```javascript
function Dog(name) {
  this.name = name;
}

var barney = new Dog('Barney');
```
> inside the function, `this` will be the newly created object.

By convention, functions that are intended to be used with `new` are named with a capital letter.  

## `function` is like a block

In Ruby, we can pass a block to another method like so:
```ruby
['one', 'two', 'three'].each do |number|
  puts number
end
```
In JavaScript, we can do a very similar thing by passing an **anonymous function**.
> An **anonymous** function is a function without a name.

```javascript
['one', 'two', 'three'].forEach(function(number) {
  console.log(number);
});
```

Of the three analogies, this is the most accurate.  But don't allow the syntax to confuse you; what are we actually passing to the `forEach` function?  It's just a Function object.  The following is exactly the same:
```javascript
var callback = function(arg) {
  console.log(arg);
};

['one', 'two', 'three'].forEach(callback);
```
> It's common to refer to this use of a function as a **callback**.

## `function` to define methods

In Ruby, we define a method like so:
```ruby
def bark(name)
  "#{name} says Woof!"
end
```
In JavaScript we see this:
```javascript
function Dog(name) {
  this.name = name
}

Dog.prototype.bark = function() {
  console.log(this.name + ' says Woof!')
};
```

We can then call the `bark` 'method' on any instance of `Dog`:
```javascript
fido = new Dog('fido');
fido.bark();
```
It's easy to think of `bark` as being a method of `Dog`.  But it isn't.  Objects in JavaScript are just bags of properties.  So `fido` is just a bag of properties, some of which it inherits from the prototype of `Dog`.  And `bark` is just a property that happens to contain a Function object.  It behaves like a method _because of the way it is invoked_:
```javascript
fido.bark();
```
This syntax invokes the function inside the `bark` property...
```javascript
Dog.prototype.bark = function() {
  console.log(this.name + ' says Woof!')
};
```
...making sure that `this` points to `fido`; which is why it looks like a method.

## Summary
It takes a while to understand JavaScript and the worst way to start is to try to force your understanding of Ruby onto it.  Once you are comfortable with the idea that a function is an object that can be invoked; and there are different ways to invoke a function, you are well on your way.

*Tip: in Sublime Text, you can type `proto` and hit Tab in a JS file to autocomplete the boilerplate code for defining a function on a prototype*
