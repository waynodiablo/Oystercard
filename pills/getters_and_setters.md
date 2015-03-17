Getters and Setters
===================

:construction: UNDER CONSTRUCTION :construction:

'Getters' and 'Setters' are a common term in object oriented programming that refer to object instance methods that 'get' and 'set' the values of object instance variables.  For example, in the simple Ruby class below:

```ruby
class Foo
  def initialize
    @bar = nil
  end
end
```

We have an instance varible `@bar`.  Class Foo above has no getters and setters.  The class is not providing us with any mechanism to access the instance variable.  Let's add a getter:

```ruby
class Foo
  def initialize
    @bar = nil
  end

  def bar
    @bar
  end
end
```

The `bar` method above now allows us to access the internal state, the `bar` instance variable like so:

```sh
→ irb
2.1.5 :001 > foo = Foo.new
 => #<Foo:0x007fd2f1b5d2b0 @bar=nil>
2.1.5 :002 > foo.bar
 => 'hey'
```

We call the method `bar` a 'getter'.  It 'gets' the value of the instance variable.  It is a Ruby convention to name the getter as the same name as the instance variable that it references.  This can sometimes lead to confusion for those coming from other languages where it might it seem that we are accessing the instance variable directly.  Actually this is Ruby's poetry mode in action.  We call `foo.bar`, but this is actually `foo.bar()` and we could give the getter any method name we wanted, e.g.

```ruby
class Foo
  def initialize
    @bar = 'hey'
  end

  def woot
    @bar
  end
end
```

Although this goes against Ruby style guidelines.  Style checkers such as RubuCop will even go so far as to insist that when our getter is doing nothing more than returning the instance variable, that we should replace the method with the `attr_reader` shorthand:

```ruby
class Foo
  attr_reader :bar

  def initialize
    @bar = 'hey'
  end
end
```

`attr_reader :bar` is exactly equivalent to `def bar; @bar; end` and is basically a 'getter' shortcut. The presence of features such as 'attr_reader' in Ruby is a reflection of the desire to reduce unnecessary duplication.  A getter method like `def bar; @bar; end` has the term 'bar', i.e. the name of the instance variable, replicated twice.  It would need to be repeated in the same way for every getter for every instance variable.  The 'attr_reader' shortcut removes a lot of unnecessary duplication.  You can also chain multiple instance variable names on the end like this:

```ruby
class Foo
  attr_reader :bar, :wip, :zoing

  def initialize
    @bar = 'hey'
  end
end
```

It's a way of quickly showing on a single line which instance variables the class is exposing.  Choosing which instance variables to expose is an important part of designing a class's public interface and ensuring that the majority of its state is properly encapsulated (see the [encapsulation pill&nbsp;:pill:](../pills/encapsulation.md)).

Setters are the twins of getters.  They allow the setting of object instance variables, like so:

```ruby
class Foo
  def initialize
    @bar = 'hey'
  end

  def bar= bar
    @bar = bar
  end
end
```

Setter methods can be called anything, but it's a Ruby convention to give them the same name as the instance variable that are setting, suffixed with an equals sign.  This allows us to use them as follows:

```sh
2.1.5 :021 > foo = Foo.new
 => #<Foo:0x007fd2f1b95930 @bar=nil>
2.1.5 :022 > foo.bar = 'boing!'
 => "boing!"
```

Again this can be rather confusing coming from other programming languages.  The `foo.bar = 'boing!'`  statement makes it look like we are setting the instance variable directly, however we are in fact called the setter method.  Ruby poetry mode allows us to represent the underlying call of `foo.bar=('boing!')` as `foo.bar = 'boing!'`, for the purposes of readability.

Setter methods also have their own shorthand, 'attr_writer', which looks like the following:

```ruby
class Foo
  attr_writer :bar

  def initialize
    @bar = 'hey'
  end
end
```

`attr_writer :bar` is exactly equivalent to `def bar= bar; @bar = bar; end`.  Again it's just a shortcut that helps us DRY out our Ruby code.  We avoid repeating the name of the instance variable in a boiler plate setter method, and we can quickly read off the writable instance variables at the top of a class definition on a single line like so:

```ruby
class Foo
  attr_reader :bar, :wip, :zoing
  attr_writer :bar, :wip

  def initialize
    @bar = 'hey'
  end
end
```

Note that in general we want to minimize the number of public reader and writer methods that a class exposes.  In general we want our classes internal state to be kept internal; we want to minimize the outside world's knowledge of our internal state, because we don't want other classes to become dependent on it.  We want other classes to depend on our public interface, as expressed through the methods we expose publicly, in order to ensure a loose coupling between classes so that when classes change the way they represent their internal state that we don't break the entire overarching system that is relying on them.

There is a further shorthand that one can use that combines the properties of 'attr_reader' and 'attr_writer'.  It is called 'attr_accessor' and should be used sparingly.  We can use it to further simplify the example class shown above:

```ruby
class Foo
  attr_reader :zoing
  attr_acccessor :bar, :wip

  def initialize
    @bar = 'hey'
  end
end
```

It's good to know each of these 'attr_*' methods and what they do in Ruby, as they are great way to DRY out repetitive getter and setter methods in your Ruby classes, as well as provide a concise description of the public getting/setting interface that your class provides.  However consider the least power principle.  Always use only the least power that you need to get the job done.  In terms of the least power principle attr_accessors are more powerful that attr_writers which are more powerful than attr_readers.

Each time you are tempted to use an attr_accessor, consider if you can get away with just an attr_reader or an attr_writer.  And whenever using an attr_writer, consider if you really want to give your class's collaborators the power to directly update their internal instance variables with whatever they fancy.
