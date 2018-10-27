# The shovel operator

The shovel operator is used to add new elements to an array.

````ruby
names = ["Jack", "John"]
names << "Alice"
names #=> ["Jack", "John", "Alice"] 
````

It may not look like a method at first but it's actually a method. This code does exactly the same thing using a more conventional syntax of calling a method a passing an argument:

````ruby
names.<<("Alice")
````

This operator can also be used to append a string to another string:

````ruby
friends = "Bob"
friends << " and Alice"
puts friends #=> "Bob and Alice"
````

![Tracking pixel](https://githubanalytics.herokuapp.com/course/pills/shovel_operator.md)
