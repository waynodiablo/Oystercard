# Blocks

Blocks are a fundamental feature of Ruby. In fact, blocks are one of the reasons Ruby is so flexible and easy to use. Let's discuss the basics of using the blocks.

In most cases, when calling a method, you pass simple objects – Symbols (:pill: [Symbols](https://github.com/makersacademy/course/blob/master/pills/symbols.md)), Strings (:pill: [Strings](https://github.com/makersacademy/course/blob/master/pills/strings.md)), numbers – as arguments. However, you can also pass a block of code as an argument. This block of code is not executed immediately when the method is called but may be executed later.

In [Student Directory](https://github.com/makersacademy/course/blob/master/student_directory.md) we iterated over an array of names using this code:

````ruby
students.each do |student|
  puts student
end
````

Here we're calling the method [each()](http://www.ruby-doc.org/core-2.1.2/Array.html#method-i-each) on the object `students` passing a block of code (starting with `do` and ending with `end`) as an argument. All three lines of code are a single method call.

The method [each()](http://www.ruby-doc.org/core-2.1.2/Array.html#method-i-each) invokes the block of code for every value in the array. So, if we had 10 students in the array, this block of code would be called 10 times. Every time, the current value from the students array would be passed to the block of code in the variable between the vertical bars, in this case `student`.

Let's say we have three names in the array

````ruby
students = ["Jack", "John", "Mary"]
````

The method [each()](http://www.ruby-doc.org/core-2.1.2/Array.html#method-i-each) will take each name in turn and assign it to the block variable `student` before executing the block three times. On the first iteration, `student` will be "Jack", on the second – "John" and on the last iteration `student` will be equal to "Mary".

So, if we run this code, it will print all three names on separate lines:

````ruby
Jack
John
Mary
````

This is the most basic example of using blocks. Blocks can take several arguments (not just one) and they can be passed to any method, not just an to one of the methods of class Array.

You'll see blocks in the documentation for many Ruby methods. For example, if we have an array of names and we want to select the names that start with "A", we can use the [select()](http://www.ruby-doc.org/core-2.1.2/Array.html#method-i-select) method.

````ruby
["John", "Alice", "Amanda", "Bob"].select do |name|
  name.chars.first == "A"
end
#=> ["Alice", "Amanda"]
````

The method [select()](http://www.ruby-doc.org/core-2.1.2/Array.html#method-i-select) takes the block of code that is used to decide whether the item from an array should be selected. If a block returns true for a given name, then it will appear among the results.

When you want to repeat the same action several times, you can pass a block to a method [times()](http://www.ruby-doc.org/core-2.1.2/Integer.html#method-i-times) defined in the class [Integer](http://www.ruby-doc.org/core-2.1.2/Integer.html).

````ruby
3.times do |i|
  puts "iteration #{i}"
end
````

This will print:

````ruby
iteration 0
iteration 1
iteration 2
````

The method [times()](http://www.ruby-doc.org/core-2.1.2/Integer.html#method-i-times) will execute the block of code three times, passing the number of the current iteration into the block.

If a block of code fits on one line, you can use alternative but equivalent syntax:

````ruby
3.times {|i| puts "iteration #{i}" }
````

Both forms (do..end or curly braces) are functionally equivalent but curly braces are normally used when the block fits on a single line, whereas do..end form is used for blocks that take more than one line of code.

Consider this example:

````ruby
['hello', 'world'].each do |word|
  puts word
end
````

Output:

````ruby
hello
world
=> ["hello", "world"]
````

Let's see what's happening here. The block is the code between do and end. In this example, this block is executed twice, once for every value in the ['hello', 'world'] array. In plain English, this code asks to take each element of the array (first 'hello' and then 'world') and execute the block of code once for each element, passing the current element into the block in the word variable.

This block of code is technically just an argument to the method, much like other arguments you give in parentheses. A block is similar to a regular method (the one you create with the def keyword) except that it doesn't have a name, so it can only be called by the method that it was passed to. However, just like regular methods, blocks may have arguments. In this example, the block takes a single argument called word. The arguments are specified at the beginning of the block between vertical bars.

It's important to note that the block is not executed immediately. Instead, it is passed to the invoked method that chooses to call this block at some point later. The block can be called once or several times or not called at all. In this example, it is called twice.

The return value of the block is defined by the last executed statement. The return value is only accessible to the invoked method (in our example, that's each). The invoked method may choose to return the value that the block returns but it doesn't have to. In this example, the method each returns the original array that it was called on and not the return value of the block. This is the reason we see ["hello", "world"] in the output as the return value. The block itself returns nil, the return value of the puts method.

If you don't pass the block to a method that expects it, then you'll see this error:

````ruby
LocalJumpError: no block given (yield)
````

The block can only appear immediately after the method invocation. You can't have standalone blocks that are not passed to any methods. However, it's possible to create standalone objects that behave like blocks: they are called procs (:pill: [procs](https://github.com/makersacademy/course/blob/master/pills/procs.md)) and lambdas (:pill: [lambdas](https://github.com/makersacademy/course/blob/master/pills/lambdas.md)).