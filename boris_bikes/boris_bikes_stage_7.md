## Stage 7: Feature Tests for Van & Garage

***As with all Makers Academy materials, there may be subtle errors in the following materials.  Please try to approach those as challenges on which to polish your debugging skills - pull requests always welcome.***

The relevant user stories here are:

```
As a maintainer of the system,
So that members of the public can get usable bikes,
I'd like vans to come to take broken bikes from docking stations, take them to be fixed and then bring them back to the docking stations.

As a maintainer of the system,
So that members of the public can get usable bikes,
I'd like garages to receive broken bikes from vans, fix them, and then pass them back to vans for distribution.
```

Follow the technique from the previous stages to design feature tests and then unit tests to drive the functionality of the first the Van and then the Garage.  The user stories above have multiple clauses in their Task components - perhaps we should break them out into separate features?

Also Before writing more code, let's think about what the other classes are and why we need them, starting with the van.

The van is moving broken bikes from the stations to the garage. Once they are fixed, the van moves them back to the stations. So the van must be able to accept the bikes at the source and release them at the destination. Obviously, the van must have some limit on the capacity, just like the station.

However, the van isn't going to be very different from the station. It may have some additional methods to interact with the station and the garage but overall it's fairly similar to the station.

The situation with the garage is very similar. What's the difference between a garage and a docking station? Only a van is supposed to take bikes out of a garage. Also, the bikes get fixed once they get to the garage. Otherwise, the garage is not much different from the station.

It seems likely that if we just implement the Garage and the Van classes in the same way we've done the DockingStation class, we'll be duplicating significant amounts of code. In this situation you need to extract common functionality into a new class or module that will be reused later.  However in order to see how this works, we recommend that you first implement the Van class in a similar way to the DockingStation, i.e. as a holder of bikes.  However once you've done so we recommend extracting the common 'container' functionality into a module.  If you're not feeling so confident please do go on and implement the Garage in the same way, and then extract the functionality that you can clearly see replicated three times over.

Assuming that you have completed the Van and/or Garage functionality, here's a walkthrough of how one would extract the common functionality.  We assume that you implemented the variable capacity functionality mentioned at the end of stage 5.

First, run all tests to make sure they pass. Then create `lib/bike_container.rb` file for our new module. Let's extract all methods from the docking station into the bike container. We'll discuss this code in more detail shortly.

````ruby
module BikeContainer

  DEFAULT_CAPACITY = 20

  def bikes
    @bikes ||= []
  end

  def capacity
    @capacity ||= DEFAULT_CAPACITY
  end

  def capacity=(value)
    @capacity = value
  end

  def dock bike
    fail 'Station Full' if full?
    bikes << bike
  end

  def release_bike
    fail 'No Bikes Available' if empty?
    bikes.pop
  end

  private

  def full?
    bikes.length >= DEFAULT_CAPACITY
  end

  def empty?
    bikes.reject(&:broken?).length == 0
  end
end
````

The first thing to note is that this is a module, not a class. A module is just like a class, except it cannot be instantiated, that is, you cannot do `BikeContainer.new`. The second interesting thing is that we have created an "accessor" methods for the `@bikes` instance variables.

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
  bikes.length >= DEFAULT_CAPACITY
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

The DockingStation now looks something like this.

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

  subject { described_class.new(capacity: 123) }

  it 'can set a default capacity on initialising' do
    expect(subject.capacity).to eq(123)
  end
end
````

Check that all tests still pass. If they do, push your code to Github, and switch Driver/Navigator Roles&nbsp;:twisted_rightwards_arrows:.

Now you can create refactor your Van and/or Garage classes so that they will reuse BikeContainer. You'll need to think how to extend the functionality of the existing methods, though. For example, the garage must fix the bikes as they arrive. However, the dock() method knows nothing about fixing the bikes:

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

Once you've finished up here check out the [Stage 8](boris_bikes_stage_8.md) extension!
