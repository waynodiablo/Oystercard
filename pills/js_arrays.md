# JavaScript arrays

Arrays in JavaScript are very similar to arrays in Ruby. We create them in the same manner:

~~~javascript
var animals = ['cat', 'dog', 'horse'];
~~~

We can also iterate over them using a method - `forEach` - which is very similar to Ruby's `each` method:

~~~javascript
animals.forEach(function(animal) {
  alert('Old McDonald had a ' + animal);
})
~~~

And we can access them using a numerical index (starting at 0) just as in Ruby:

~~~javascript
animals[0]; //=> 'cat'
animals[2]; //=> 'horse'
~~~

## Appending to arrays

JavaScript doesn't have the `<<` (shovel) operator, so to append to an array, we have to use the `.push` method:

~~~javascript
animals.push('snake');
animals; //=> ['cat', 'dog', 'horse', 'snake']
~~~

## Checking presence of an element in an array

In Ruby we can check if an element is included in an array using the `.include?` method:

~~~ruby
if animals.include?('cow')
  puts 'Mooo'
end
~~~

In JavaScript, there's no direct equivalent of the `.include?` method. Instead we can use the `indexOf` method, which will either return the numerical index of an element in an array **if it exists**, or if the element doesn't exist, return -1.

~~~javascript
if(animals.indexOf('cow') > -1) {
  alert('Mooo');
}
~~~

![Tracking pixel](https://githubanalytics.herokuapp.com/course/pills/js_arrays.md)
