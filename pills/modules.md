Modules
----

By now you already have a good understanding of what classes are. Modules are very similar to classes but there are some important differences. Like classes, modules are collections of methods and constants grouped together. For example, this is a module:

```ruby
module Demo
  GREETING = 'Hello'
  
  def greet(name)
    puts "#{GREETING}, #{name}"
  end
end```

It looks just like a class, except that instead of the class keyword on line 1 we use the module keyword. The key difference between modules and classes is that classes can be instantiated but modules cannot.

`Demo.new # this is wrong, modules can't be instantiated!`

So, what are modules good for? We can include them into classes (and other modules). For example:

```ruby
class Person
  include Demo # so all methods from Demo become part of Person
end

Person.new.greet('Mark') #=> 'Hello, Mark'
```

We've just included the module Demo into the class Person. Why not include the method greet() in the class Person directly? Putting it into a separate module allows us to reuse the module several times, including it in other classes. A module that's included in a class is called a mixin.

We've already seen one technique for reusing code: inheritance. Why not create a parent class for Person, put the method greet() there and then subclass from the parent as needed? The problem with this approach is that a class can have only one parent. Often it's desirable to include functionality from several different, unrelated files.