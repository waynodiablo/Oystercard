## Stage 7: Feature Tests for Van & Garage

The relevent user stories here are:

```
As a maintainer of the system,
So that members of the public can get usable bikes,
I'd like vans to come to take broken bikes from docking stations, take them to be fixed and then bring them back to the docking stations.

As a maintainer of the system,
So that members of the public can get usable bikes,
I'd like garages to receive broken bikes from vans, fix them, and then pass them back to vans for distribution.
```

okay so I think the below is all back to front, but anyway it should definitely be here before we try and start refactoring out a container

2. Write the `empty?()` method for the docking station.
3. How will the van check out broken bikes if the `available_bikes()` method doesn't return broken bikes? Extend the station to be able to interact with the van.
4. If you chose to create methods that return broken bikes and working bikes separately, why do we need `bike_count()` method? Should we keep it or leave it? If we keep it, when will it be used?
5. Design the methods that the van needs to have to move broken bikes from a station to the garage and back (once they are fixed). Implement them.
6. Write the Garage class. Assume that the bikes are fixed instantly when they are put into the garage. See the discussion above on how to do it.
7. Write the Van class. How is it different from other classes? What extra methods will it have? A van would normally take several bikes in one go. How do we do it? How will it take into account the space available in the van. Write tests for all use cases.

8. The method that releases the bike takes an argument: a bike to release. Would in make sense to rewrite the method to not to take any arguments? What are the pros and cons? How will you release broken bikes in this case? Discuss with other students and update the code, if necessary.

[TODO: I have a real problem with extracting out common functionality before we have actually got the functionality appearing in multiple places - it feels like premature refactoring to me - we are introducing a dependency when we don't know what kinds of client requests might be coming down the line.  Furthermore for learning developers, introducing that complexity before we actually see the code replication that it removes feels like we are loading on too much up front ...]

[TODO: rather than exercises, perhaps we should have feature requests, even appearing in a backlog of some kind?  Would be awesome if we can could add them as issues to the repo the student was working on at the appropriate time ...]

Before writing more code, let's discuss what the other classes are and why we need them, starting with the van.

The van is moving broken bikes from the stations to the garage. Once they are fixed, the van moves them back to the stations. So the van must be able to accept the bikes at the source and release them at the destination. Obviously, the van must have some limit on the capacity, just like the station.

However, the van isn't going to be very different from the station. It may have some additional methods to interact with the station and the garage but overall it's fairly similar to the station.

The situation with the garage is very similar. What's the difference between a garage and a docking station? Only a van is supposed to take bikes out of a garage. Also, the bikes get fixed once they get to the garage. Otherwise, the garage is not much different from the station.

## Version 5: Extracting the common functionality

By now it should be obvious that if we just implement the Garage and the Van classes in the same way we've done the DockingStation class, we'll be duplicating significant amounts of code. In this situation you need to extract common functionality into a new class or module that will be reused later.

This week we'll be discussing two strategies for extracting common functionality: inheritance and composition. In this particular case we should use composition over inheritance.

Inheritance is mostly useful when there is a clear **is-a** relationship. For example, an ElectricCar **is a** Car. A Cat **is a** Mammal. A Report **is a** Document.

Composition is usually more suitable when there is a **has-a** relationship. A Car **has a** Gearbox. A Cat **has a** Tail. A Report **has a** Attachment.

In our case three objects – docking station, van and garage – have common functionality. However, they are not the same thing conceptually. Even though the Garage is almost like a DockingStation with minor changes to functionality, we can't say that a garage is a docking station. A van is not a docking station either. We could invent an artificial ObjectThatCanDockBikes but that would be a really poor solution. We must show some compassion for the developers that will be maintaining this code base in the future, trying to make sense of what we've written.

Instead, we need to use composition. A garage has a special area where to store the bikes. So do the docking station and the van. All of them have other things: a van has an engine, a docking station has a payment terminal and a garage has a set of tools but all that doesn't concern us right now. The common thing is that they all have a place to store the bikes. Let's call it a BikeContainer. So a Van has a BikeContainer, a DockingStation has a BikeContainer and a Garage has a Bike Container. Since it's a clear has-a relationship, we must be using composition, and not inheritance in this case.

Let's begin by extracting the common functionality from the DockingStation to BikeContainer. Since we are not adding any new functionality, this process is refactoring. Therefore, we are not writing any new tests but using existing tests to make sure that we are not breaking anything in the process.

Note that we might argue this is a case of 'premature refactoring'.  We haven't yet built the Van and the Garage and so we can't actually see the three replicated pieces of identical code that we will DRY out with this refactoring.  A cautious developer might write those classes first, and only refactor once they've been in use for a whole and it's clear that their functionality won't diverge.  In this simple artificial system it's easier to see that this will be a useful refactoring.  The important thing is to be aware of the tradeoffs regarding when to DRY out and when to hold off until you get more input from stakeholders in your project.  In this case let's create BikeContainer first to avoid writing the same code over and over.

First, run the tests to make sure they pass. Then create `lib/bike_container.rb` file for our new module. Let's extract all methods from the docking station into the bike container. We'll discuss this code in more detail shortly.

````ruby
module BikeContainer

  DEFAULT_CAPACITY = 10

  def bikes
    @bikes ||= []
  end

  def capacity
    @capacity ||= DEFAULT_CAPACITY
  end

  def capacity=(value)
    @capacity = value
  end

  def bike_count
    bikes.count
  end

  def dock(bike)
    raise 'Station is full' if full?
    bikes << bike
  end

  def release(bike)
    bikes.delete(bike)
  end

  def full?
    bike_count == capacity
  end

  def available_bikes
    bikes.reject {|bike| bike.broken? }
  end
end
````

The first thing to note is that this is a module, not a class. A module is just like a class, except it cannot be instantiated, that is, you cannot do `BikeContainer.new`. The second interesting thing is that we have created "accessor" methods for `@capacity` and `@bikes` instance variables.

````ruby
def bikes
  @bikes ||= []
end

def capacity
  @capacity ||= DEFAULT_CAPACITY
end

def capacity=(value)
  @capacity = value
end
````

This enables us to avoid working directly with the instance variables, [encapsulating](http://en.wikipedia.org/wiki/Encapsulation_(object-oriented_programming)) the implementation inside the module. Because of this change, all other methods now use the accessor methods instead of manipulating the instance variables directly. Consider this method:

````ruby
def full?
  bike_count == capacity
end
````

Here, `capacity` refers to the accessor method `capacity()` that we defined above.

The third interesting thing is the use of the `||=` operators to initialise values. Consider this method:

````ruby
def capacity
  @capacity ||= DEFAULT_CAPACITY
end
````

Whenever any other method calls `capacity()`, it will return the value of the instance variable `@capacity`. However, if `@capacity` is nil, it will assign `DEFAULT_CAPACITY` to it first. This operator is short for `@capacity = @capacity || DEFAULT_CAPACITY`.

This trick enables us to call the method `capacity()` before the value was set: it will be set to the default the first time it's accepted.  As with everything in Ruby please experiment with it in IRB to make sure you understand what's happening.

The DockingStation now looks like this.

````ruby
# load BikeContainer
require_relative 'bike_container'

class DockingStation

  # this gives us all the methods that used to be in this class
  include BikeContainer

  def initialize(options = {})
    # self.capacity is calling the capacity=() method
    # (note the equals sign) defined in BikeContainer
    # capacity (the second argument to fetch()) is calling
    # the capacity() method in BikeContainer
    self.capacity = options.fetch(:capacity, capacity)
  end

end
````

Now our DockingStation class is very small because we extracted all methods (except the initialiser) into BikeContainer. We retain the initialiser, though, because we want to be able to set a custom capacity for the station, if we want to.

The tests should still pass because the functionality is equivalent. However, we need to refactor the tests before we check them in. The problem is that all tests that cover the functionality of BikeContainer are in docking_station_spec.rb, which is misleading. Let's create a separate suite of tests for the bike container.

Since we can't instantiate a module, we will need to create an artificial class for test purposes. The only job of that class will be to include BikeContainer. This is what the beginning of the test looks like (most tests omitted for brevity, refactor them on your own).

````ruby
require './lib/bike_container'

class ContainerHolder; include BikeContainer; end

describe BikeContainer do

  let(:bike) { Bike.new }
  let(:holder) { ContainerHolder.new }

  it 'should accept a bike' do
    # we expect the holder to have 0 bikes
    expect(holder.bike_count).to eq(0)
    # let's dock a bike into the holder
    holder.dock(bike)
    # now we expect the holder to have 1 bike
    expect(holder.bike_count).to eq(1)
  end
end
````

This is pretty much the same test we used to have for the station, except that we're using an artificial class instead of a docking station. The DockingStation test now has only one test that checks that the initialiser is working correctly.

````ruby
require './lib/docking_station'

describe DockingStation do

  let(:station) { DockingStation.new(capacity: 123) }

  it 'should allow setting default capacity on initialising' do
    expect(station.capacity).to eq(123)
  end
end
````

Check that all tests still pass. If they do, push your code to Github, and switch Driver/Navigator Roles&nbsp;:twisted_rightwards_arrows:.

Now you can create Van and Garage classes that will reuse BikeContainer. You'll need to think how to extend the functionality of the existing methods, though. For example, the garage must fix the bikes as they arrive. However, the dock() method knows nothing about fixing the bikes:

````ruby
def dock(bike)
  raise "There is no more room for bikes" if full?
  bikes << bike
end
````

There are several way of doing this. The simplest would be to use a different method to put bikes in a garage:

````ruby
def accept(bike)
    bike.fix!
    dock(bike)
end
````

The advantage is the simplicity. The disadvantage is that the interface for docking the bikes is different.

Another way would be to not to fix the bikes automatically in the first place. Then we'd call the fix_bikes() method (or similar) after we dock them.

````ruby
garage.dock(bike)
garage.fix_bikes
````

The advantage is that we have the same interface. The disadvantage is that we have to make two method calls (that's a big one).

There's a really good overview of [potential strategies you could use on StackOverflow](http://stackoverflow.com/questions/4470108/when-monkey-patching-a-method-can-you-call-the-overridden-method-from-the-new-i_). Try using `alias_method` and `prepend` (and maybe others) and discuss their advantages and disadvantages with other students and coaches.
