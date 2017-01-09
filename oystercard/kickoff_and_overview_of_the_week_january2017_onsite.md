# Kickoff and overview of the week

## Learning objectives

### Goals for the week

Ask yourself the same two questions:

* Are you having fun?

* Are you a better developer than you were yesterday?

#### Primary goal

By the end of the week, the goal is to be able to answer "yes" to the week's primary question:

* **Can you use object-oriented design principles to write better code?**

## Refining your process for writing code

* Decide on the smallest unit of functionality.

* Diagram the domain model that will incorporate the functionality.

* Write a test for the functionality.

* Get the test to pass.

* Refactor.

* Repeat

## Writing better code

Following good processes and principles lets you write code that is:

* Makes code easy to reuse.

* Makes code easy to change.

* Makes code easy to understand.

## Guidelines for writing better code

As you improve as a programmer, you'll learn a number of different principles, guidelines and processes for writing better code.  You'll learn about and practice these this week.

### Single Responsibility Principle

Writing classes that only understand how to do one thing.

You started to learn about this in week 1 and will practice it more this week.

### Encapsulation

Writing classes that contain methods and the data those methods operate on.  These classes hide the details of their implementation from other classes.

You started to learn about this in week 1 and will practice it more this week.

### Separate out the things that change from the things that stay the same

Imagine wanting to add a Skateboard to this code:

```ruby
def move_200(thing)
  if thing.is_a? Car
    thing.drive(200)
  elsif thing.is_a? Plane
    thing.fly(200)
  end
end
```

You'd need to write the Skateboard class and then add another case to the code above to accommodate it.  This code is failing to separate out the things that change from the things that stay the same.

Instead, you could standardise the Car and Plane to all call their moving functions `move`.  This means the code above can be refactored to:

```ruby
def move_200(thing)
  thing.move(200)
end
```

### Delegate, delegate, delegate

Imagine we have the idea of a car and the idea of a plane.

```ruby
class Car
end

class Plane
end
```

Each one needs an engine that can be started.

```ruby
class Car
  def start_engine
  end
end

class Plane
  def start_engine
  end
end
```

But, now, we're duplicating code.

Instead, we could delegate the engine code to a separate class.  We can use that class in Car and Plane:

```ruby
class Engine
  def start
  end
end

class Car
  def initialize
    Engine.new.start
  end
end

class Plane
  def initialize
    Engine.new.start
  end
end
```
