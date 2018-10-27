# Procs

A proc is an object that is associated with a block of code. It's convenient to use [procs](http://www.ruby-doc.org/core-2.1.2/Proc.html) when the block of code doesn't need to be invoked but needs to be passed to other methods. 

Consider this example:

````ruby
def passing_block(&block)
  puts block.inspect #=> #<Proc:0x007fd63c1cfec0@(irb):63>
end
````

So, if we inspect the [block](https://github.com/makersacademy/course/blob/master/pills/blocks.md) inside a method, it'll turn out it's actually a proc. What can we do with a proc? Apart from passing it to other methods, we can call it:

````ruby
def passing_block(&block)
  block.call
end
````

If you need to create a proc manually, you can do it like this:

````ruby
my_proc = Proc.new {|name| puts "Hello, " + name }
````

As you would expect, you can pass arguments to the [call() method](http://www.ruby-doc.org/core-2.1.2/Proc.html#method-i-call), just like you can do this with the [yield keyword](http://www.ruby-doc.org/core-2.1.2/Proc.html#method-i-yield). However, unlike ordinary methods, [procs](http://www.ruby-doc.org/core-2.1.2/Proc.html) don't care if you pass the correct number of arguments.

![Tracking pixel](https://githubanalytics.herokuapp.com/course/pills/procs.md)
