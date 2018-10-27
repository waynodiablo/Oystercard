# Reopening classes

Ruby provides another interesting method of modifying the functionality of existing classes and modules that can be incredibly useful at times.  Let's say you want to give the [Array class](http://www.ruby-doc.org/core-2.1.2/Array.html) new functionality: a method to return the second element. The original implementation only has the `first()` method:

````ruby
[1,2,3].first #=> 1
[1,2,3].second #=> NoMethodError: undefined method `second'
````

How do we add the `second()` method to the [Array class](http://www.ruby-doc.org/core-2.1.2/Array.html)? It turns out that we can reopen the class and add the necessary method:

````ruby
class Array # Array class already exists
  def second # a new method we're adding
    self[1] # self here refers to the instance of the array
  end
end
````

Now we can use the method we added:

````ruby
[1,2,3].first #=> 1 # note that the first() method is intact
[1,2,3].second #=> 2
````

This technique is called **reopening the class**. By declaring a class with the name of an already existing class we can add new methods to it.

What happens if the name of the method you write is the same as the name of the method that's already declared? Let's say you do this:

````ruby
class Array
    def size
      42
    end
end
````

Then all instances of the array class will return _42_ when you call the method `size()`. Ruby will not generate any warning if you do this, so please be careful that you aren't overwriting the methods that you don't want to overwrite.

````ruby
[1,2,3].size #=> 42
````

![Tracking pixel](https://githubanalytics.herokuapp.com/course/pills/reopening_classes.md)
