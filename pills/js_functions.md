# `function` in JavaScript

The `function` keyword in JavaScript serves three distinct purposes - and is effectively equivalent to three keywords in Ruby: `class` and `do` and `def`.

## `function` to define a 'class'

Very strictly speaking, there's no true concept of classes in JavaScript - but for now, we can think of the `function` keyword as being conceptually equivalent to the Ruby `class` keyword, which we can then use to create "function objects" (in Ruby terms, instances of a class) 

~~~javascript
function Car() {
  
}
~~~

is equivalent to:

~~~ruby
class Car

end
~~~

To define a new kind of object, we need to provide the object name. Unlike Ruby, object names don't have to be capitalized, but it's convention to capitalize them anyway. To create a function object, where in Ruby we would write:

~~~ruby
bmw = Car.new
~~~

In JavaScript we would write

~~~javascript
var bmw = new Car();
~~~

### Initialization code

Instead of an `initialize` method, the code inside the curly braces after the function definition will be run when we create a new function object. For instance:

~~~javascript
function Dog(name) {
  this.name = name;
}
~~~

is equivalent to:

~~~ruby
class Dog
  def initialize(name)
    @name = name
  end
end
~~~

To pass arguments the initialization function, we pass them in inside the parentheses following the function name, e.g.:

~~~javascript
new Dog('Fido');
~~~

## `function` in place of a block

In the first use of `function` we have to provide the name of the object we're defining (`Car`, `Dog` etc.). We can also create a function without a name: an **anonymous** function. These are equivalent to blocks in Ruby. For instance this Ruby code:

~~~ruby
['one', 'two', 'three'].each do |number|
  puts number
end 
~~~

could be rewritten in JavaScript like so:

~~~ruby
['one', 'two', 'three'].forEach(function(number) {
    alert(number);
});
~~~

Beyond the difference in method names (`each` vs. `forEach`), in JS we use `function` instead of `do` to mark off our 'block'. Just as in Ruby, the name we give to our argument (`number`) is arbitrary.

## `function` to define methods

Finally we can use `function` to define methods:

~~~javascript
Dog.prototype.bark = function() {
  alert('Woof')
};
~~~

We can then call the `bark` method on any instance of `Dog`:

~~~javascript
fido = new Dog();
fido.bark()
~~~

Just as in Ruby, a method can accept arguments:

~~~javascript
Dog.prototype.bark = function(suffix) {
  alert('Woof' + suffix);
};

fido = new Dog();
fido.bark('!')
~~~

And just like Ruby's procs and lambdas, we can also create functions that are not methods - they can exist independently as first class citizens:

~~~javascript
function bark(suffix) {
  alert('Woof' + suffix);
}

bark('!')
~~~

*Tip: in Sublime Text, you can type `proto` and hit Tab in a JS file to autocomplete the boilerplate code for defining a method*
