# Array

An array, in programming, is an indexed collection of related items. Let's put all our capitals in an array

````ruby
capitals = ['London', 'Paris', 'Berlin']
````

In Ruby, an array is denoted by square brackets. The elements are separated by commas. We mentioned above that an array is an indexed collection. This means two things. First, all elements are ordered: Paris comes after London but before Berlin in our array. Second, we can access any element by specifying its index.

````ruby
capitals[2]
=> “Berlin”
capitals[0]
=> “London”
````

By putting an index in a square brackets, we can get the elements out of the array. That's why `capitals[2]` gives us "Berlin". Try it for yourself in the console.

You must have noticed that the indexes start with 0 instead of 1, so the first element of the array (London) is accessed as `capitals[0]`, whereas `capitals[1]` gives us the second element – Paris. This may seem strange at first but this is the convention many programming languages use because of its [convenience](http://en.wikipedia.org/wiki/Zero-based_numbering).

If you use an index that exceeds the array bounds (`capitals[25]`), you'll get nil.

What if the array index is negative? In this case it'll just start counting from the end. So, the last element will have an index -1, the next to last -2 and so on.

````ruby
capitals[25]
=> nil
capitals[-1]
=> “Berlin”
capitals[-4]
=> “nil”
````

This may seem counterintuitive but it may be very useful at times. 

In addition to giving the exact location of an array's element, you can also call the "first" or "last" method on the array.

````ruby
capitals.first #=> London
capitals.last #=> Berlin
````

There are a few other useful methods that you can use to get information about an array:

````ruby
capitals.length #=> 3
capitals.empty? #=> false
capitals.include?("London") #=> true
capitals.include?("Moscow") #=> false
````

Most of these are self-explanatory. The method length() provides us with the number of elements in the array. empty?() returns a simple boolean true or false telling us if it's empty. include?() takes a parameter and searches through the array to see if any element of the array matches it, then returns a boolean letting us know.

How do you find out what methods are available? Google "ruby array": the first link will be to the [documentation for this class](http://ruby-doc.org/core-2.0.0/Array.html). Take a look there, find the methods we discussed above.

It wouldn't be much fun if we could only read from the arrays but not change them. Fortunately, the arrays in Ruby are mutable. This is a programming term meaning you can change them: add elements, delete them, etc. Go to the documentation for the Array class to find out what you can do with the array. Learn how to add a new element, change an element at a given index and delete an element.

````ruby
capitals << “Madrid”
[“London”, “Paris”, “Berlin”, “Madrid”]
capitals.sort!
[“Berlin”, “London”, “Madrid”, “Paris”]
capitals.delete(“Paris”)
“Paris”
[“Berlin”, “London”, “Madrid”]
````

Finally, you can mix and match various types of data inside of an array - even other arrays!

````ruby
mixed_array = ["some string", 5, 17.42]
fun_with_arrays = ["a string", ["an", "array"], 5]
````

If you wanted to access "array" inside the nested array, you'd do it like this:

````ruby
fun_with_arrays[1][1] #=> "array"
````

The first operation `fun_with_arrays[1]` would give you the nested array (`["an", "array"]`) and the second operation (`[1]`) would give you the second element of the nested array.

You can create empty arrays using either a literal construct or by simply calling the "new" method on the "Array" object of Ruby. Both of these will create new empty arrays:

````ruby
empty_array = []
another_empty_array = Array.new # exactly the same as []
````