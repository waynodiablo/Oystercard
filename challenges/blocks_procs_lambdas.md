# Blocks, Procs and Lambdas

1. Write a unit test for the [map()](http://www.ruby-doc.org/core-2.1.2/Array.html#method-i-map) method, then reopen the [Array class](http://www.ruby-doc.org/core-2.1.2/Array.html) and implement it. You will need to use the yield keyword to call the block passed to [map()](http://www.ruby-doc.org/core-2.1.2/Array.html#method-i-map). Don't forget that [map()](http://www.ruby-doc.org/core-2.1.2/Array.html#method-i-map) returns a new array, instead of modifying the array it's called on.

2. Do the same for [select()](http://www.ruby-doc.org/core-2.1.2/Array.html#method-i-select) method.

3. Do the same for [each()](http://www.ruby-doc.org/core-2.1.2/Array.html#method-i-each) method. Use the for loop to iterate over all elements of the array.

4. Create a proc and use it with the [map()](http://www.ruby-doc.org/core-2.1.2/Array.html#method-i-map) method instead of a block:

````ruby
my_proc = # for you to complete
result = [1,2,3].map# for you to complete, pass the proc here
expect(result).to eq([2,4,6]) # make it pass
````

5. Read the documentation for the [inject method](http://www.ruby-doc.org/core-2.1.2/Enumerable.html#method-i-inject). It's significantly more complex than [map()](http://www.ruby-doc.org/core-2.1.2/Array.html#method-i-map) or [select()](http://www.ruby-doc.org/core-2.1.2/Array.html#method-i-select). Write several unit tests demonstrating how to use inject using arrays of elements of different types (numbers, strings, hashes, arrays, etc.). Don't implement the inject method itself, though.

6. If you'd like a harder challenge, implement the [map()](http://www.ruby-doc.org/core-2.1.2/Array.html#method-i-map) method without iterations, using [recursion](https://github.com/makersacademy/course/blob/master/pills/recursion.md). You'll need a recursive helper function that will need to have a different signature than normal [map()](http://www.ruby-doc.org/core-2.1.2/Array.html#method-i-map). Don't forget that you may need to operate on a copy of the original array. Think about the base case when the recursion should stop. If you do this, the teachers will be seriously impressed because this is hard, even though you can write the solution in only two lines of code.