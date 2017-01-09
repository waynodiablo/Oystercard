# Kickoff and overview of the week

## Learning objectives

### Goals for the week

Ask yourself the same two questions:

* Are you having fun?

* Are you a better developer than you were yesterday?

#### Primary goal

By the end of the week, the goal is to be able to answer "yes" to the week's primary question:

* **Can you use object-oriented design principles to write cleaner code?**

## Refining your process for writing code

* Decide on the smallest unit of functionality.

* Diagram the domain model that will incorporate the functionality.

* Write a test for the functionality.

* Get the test to pass.

* Refactor.

* Repeat

## Writing clean code

Following good processes and principles lets you write code that is:

* Makes code easy to reuse.

* Makes code easy to change.

* Makes code easy to understand.

## Guidelines for writing clean code

As you improve as a programmer, you'll learn a number of different principles, guidelines and processes for writing clean code.  You'll learn about and practice these this week.

### Single Responsibility Principle

Writing classes that only understand how to do one thing.

### Encapsulation

Writing classes that contain methods and the data those methods operate on.  These classes hide the details of their implementation from other classes.

### Meta design patterns

A book called Design Patterns in Ruby has five meta patterns.  These are further guidelines for how to write clean code.  We'll cover these in more detail in workshops this week.

#### Separate out the things that change from the things that stay the same

Imagine wanting to add a Skateboard to this code:

```ruby
if thing.is_a? Car
  thing.drive(200)
elsif thing.is_a? Plane
  thing.fly(200)
end
```

You'd need to write the Skateboard class and then add another case to the code above to accommodate it.  This code is failing to separate out the things that change from the things that stay the same.

Instead, you could standardise the Car and Plane to all call their moving functions `move`.  This means the code above can be refactored to:

```ruby
thing.move(200)
```

Now, writing the Skateboard is just a matter of writing the class.  The code above can accommodate it with no problems.

#### Program to an interface, not an implementation

This is exemplified above.  Car, Plane and Skateboard have all agreed on using the same interface (`move`), rather than exposing their different interfaces (`drive, `fly`, `skate`).

#### Prefer composition to inheritance

```ruby
class Vehicle
  def start_engine
  end

  def add_wheel
  end
end

def Car < Vehicle
end

def Plane < Vehicle
end
```

Plane and Car inherit `start_engine` and `add_wheel` from Vehicle.  Code is being reused!

```ruby
def Skateboard < Vehicle
end
```

Add the Skateboard class and make it inherit from Vehicle so it can inherit `add_wheel`.  But it also inherits `start_engine`, which makes no sense.

Instead, to share the engine functionality, we can remove the inheritance and replace it with composition.  We move the engine functionality to an `Engine` class.  We can then instantiate and attach it as an attribute on Car and Plane.  We can do the same with a new `Wheels` class.

```ruby
class Engine
  def start
  end
end

class Wheels
  def add_wheel
  end
end

def Car
  def initialize
    @engine = Engine.new
    @wheels = Wheels.new
  end
end

def Plane
  def initialize
    @engine = Engine.new
    @wheels = Wheels.new
  end
end

def Skateboard
  def initialize
    @wheels = Wheels.new
  end
end
```

#### Delegate, delegate, delegate

The above code is also an example of delegation.  We took the responsibility of handling the engine and delegated it to its own class, `Engine`.


#### Ya' Ain't Gonna Need it

Write the minimum code you need right now.  This can be done at the method, class, application and product level.
