# Boris Bikes intro
```
As a member of the public,
So that I am not frustrated trying to find a bike,
I'd like to know if a docking station has working bikes available.

As a member of the public,
So that I am not frustrated trying to return a bike,
I'd like to know if a docking station has reached capacity and cannot receive any more bikes.
```

Running our tests now we should have a matching unit and acceptance test.  BTW, can you see any code that could safely be deleted now?

Now, assuming that we have no more unrevealed feature test errors, what's the simplest thing we could possibly do to make this unit test pass?  How about updating our Docking Station as follows:

```ruby
class DockingStation
  def release_bike
    Bike.new
  end
end
```


Notice that this code still doesn't check that the Bike is initially not broken.  This corresponds to a more rigorous test, actually checking what the method returns.  We can do that with the following [predicate](https://www.relishapp.com/rspec/rspec-expectations/
docs/built-in-matchers/predicate-matchers) syntax:

````ruby
require 'bike'
describe Bike do
  it { is_expected.to respond_to :broken? }
  context 'when created' do
    it { is_expected.not_to be_broken}
  end
end
````


However interestingly even though this is a more rigorous test it will just pass as is.  Can you work out why?

Notice also that our first it statement is redundant.  Since we call the method 'broken?' in the second 'it' statement DockingStation is implicitly checked for responding to 'broken?'.  Arguably we could delete the first 'it' statement with no loss.  Let's do that.  It's good habit to get into; deleting code that is not doing anything for you.


# Boris Bikes Stage 4
Our feature test is passing, ensuring that we are delivering value to our client.  We've got unit tests for the `Bike` and `DockingStation` classes.  However our DockingStation is very tightly coupled to the Bike class.  It might seem obvious that all a DockingStation ever needs to do is release Bikes, but Ruby programmers pride themselves on removing dependencies between objects.

Our feature test requires an object that responds to the 'working?' method.  Ultimately, it doesn't care what the *class* of the object is.  In the future our client might want docking stations to release objects of class `MountainBike` or `Scooter` and we expect our user will continue to want objects that are working.  You can see an example of how we might decouple our objects in the [dependency injection pill&nbsp;:pill:](../pills/dependency_injection.md).


Here is the corresponding test:

```ruby
it 'releases bikes that are not broken' do
  bike = subject.release_bike
  expect(bike).not_to be_broken
end
```

The initial bike in a DockingStation is nil.  We might be tempted to try and dock a symbol :bike as we do with the 'can dock a bike' test, however in this case we need something that will respond to the broken? method.  But this is a DockingStation unit test, we can't use Bike ... so let's use a double:

```ruby
it 'releases bikes that are not broken' do
  subject.dock double :bike, broken?: false
  bike = subject.release_bike
  expect(bike).not_to be_broken
end
```

Here we've created a mock object that will always respond to the 'broken?' method with a false return value.  It's a bit of a self fulfilling test in that we pass in something that is not broken and check that what we get back is not broken.  Either way it's testing the DockingStation completely independently of Bike. Now we just have to throw an error when we try to release a bike and none is present.

To do that we'll have to at least partially back out of the 'alias_method' fix like so:

```ruby
class DockingStation
  attr_writer :bike
  alias_method :dock, :bike=

  def release_bike
    fail 'No bikes available' unless @bike
    @bike
  end
end
```
# Boris Bikes stage 5

Notice anything wrong here? We've just broken the independence of the docking station unit test.  It now requires knowledge of the Bike class.  If we think about things carefully we realise that we don't actually have to pass in a bike object at all in order to check this aspect of the DockingStation functionality.  We could just pass in symbols but we should probably switch to making consistent use of doubles since they will report any unexpected usage in a more consistent fashion:

```ruby
require 'docking_station'

describe DockingStation do
  # other tests omitted for brevity
  it 'raises an error when full' do
    subject.dock double :bike
    expect { subject.dock double :bike }.to raise_error 'Docking station full'
  end
end
```

This is also called the London style of unit-testing and we prefer it since it means our unit-tests are focused exclusively on testing a single class.  Our integration tests (that happen to be feature tests in this example) use the Chicago style of testing with multiple classes and check that our classes interact together effectively.

Let's go on and make both levels of test pass with the following:



Notice how in the process of making this functionality we've completely removed the alias_method and attr_* operations that were required by the ruby style guide?  This is a perfectly normal process of code revision that will take place time and time again.  We're not expecting our code to be perfect first time round.  We'll do the minimum to support an individual feature test, and then refactor and add more features as appropriate.


Reflecting on our domain model so far, we see that in response to several user stories, we have created a bike which responds to the 'working?' method; a docking station that can dock a bike, release that bike and will raise errors if we try to dock a bike in a station that already has one, or release a bike when the docking station is empty.  Interestingly at the moment there is nothing that strongly ties the two objects together, although clearly we intend for bikes to the objects that docking stations hold.  Now it seems clear that we'd like to allow a docking station to hold multiple objects, specifically bikes.  Let's start implementing the user story that specifies a default capacity of 20.

Both feature and unit tests should now pass, but something else fails:

```sh
1) DockingStation can dock a bike
   Failure/Error: expect(subject.dock :bike).to eq :bike

     expected: :bike
          got: [:bike]

     (compared using ==)
```

One of our earlier tests that relied on dock returning an instance of the bike that was docked is now getting an array of bikes as a side effect.  We can fix that easily, but this is a great example of the unexpected changes that we can get when we update code.  In the absence of the test, we might not have realized the change.  The 'can dock a bike' test starts to seem a little redundant (we test it implicitly when testing the docking station gets full) - should we delete it?  However it also seems like returning the entire array of bikes when docked is poor form - we're exposing internal state of the docking station that ideally we keep concealed unless absolutely necessary.  Let's fix that :

```ruby
it 'can dock a bike' do
  expect(subject.dock :bike).to be nil
end
```

Can you fix the DockingStation code to make this updated test pass.  Once you have, we should be all green and our docking station is starting to have some meat on it. There's also a some room for refactoring now.  Can you think of any possible changes to the DockingStation class?

# Stage 6


Our two different tests fail in two different ways now.  Our unit test catches the problem at the lower level that our broken? method returns nil rather than true or false and our higher level feature test finds that a broken bike is still released by the docking station when it should be giving an error indicating that no working bikes are currently available.

As was the case with the docking station needing an instance variable to store a docked bike, we have a combination of tests that force us to write some logic.  The simplest thing we can do to make the currently failing tests pass is to have the broken? method just return true.  Try it and see.  A different combination of tests will fail.  Apparently, our bike should maintain some internal state that should be changed when we break it.

Let's introduce an instance variable that holds this information. This must be an instance variable because this data is applicable only to a specific instance of the `Bike` class. One bike (instance of `Bike`) may be broken, whereas another one may not be. So we need an instance variable to save it.

````ruby
class Bike

  # the initialize method is always called when you create a new
  # class by typing Bike.new
  def initialize
    # all instance variables begin with "@"
    # this must be an instance variable because we'll need it
    # in other methods
    @broken = false
  end

  def broken?
    # instance variables are accessible in all methods
    @broken
  end

  def break
    # and any instance method can update them
    @broken = true
  end

end
````

Although RuboCop will ask us to use attr_reader to define trivial reader methods like broken?  Let's go ahead and do that:

```ruby
class Bike
  attr_reader :broken
  alias_method :broken?, :broken

  def intialize
    @broken = false
  end

  def break
    @broken = true
  end
end
```

Now our bike's unit tests will all pass, but our feature test is still failing.  Nothing is stopping the docking station from releasing broken bikes.  Again we might be tempted to get straight in and fix code but note that it's a feature test that's failing, so we should respond by creating another unit test; this time for the docking station.  However we have a quandary, we need to write a unit test that will rely on a bike being in a particular state, i.e. broken.  We might be tempted to write a docking station unit test like so:

```ruby
describe DockingStation do
  # other tests omitted for brevity
  it 'does not release broken bikes' do
    broken_bike = Bike.new
    broken_bike.break
    subject.dock broken_bike
    expect { subject.release_bike }.to raise_error 'No Bikes Available'
  end
end
```

However our docking station unit test is now locked to the Bike class.  If we were using the Chicago style of testing this might be acceptable, but we prefer the London style of cleanly independent unit testing at Makers.  The problem is that the symbols that we've been using so far are not going to cut it for this kind of test.  The symbol :bike is a great stand in if we just want something to take a place in an array, but it won't respond to the 'broken?' method.  This is where we need to use a double.  A double is like a stunt double.  It can do a few things that the real actor can do, but not all.  We use doubles like so:


```ruby
describe DockingStation do
  # other tests omitted for brevity
  it 'does not release broken bikes' do
    broken_bike = double :bike, broken?: true
    subject.dock broken_bike
    expect { subject.release_bike }.to raise_error 'No Bikes Available'
  end
end
```

Here we use call the 'double' method to create something that will report it's name as :bike and will respond to the 'broken?' method with a true value.  It's a stand-in stunt double for a bike that ensures that we are not relying on the real Bike to work in order to test the DockingStation

A quick change to our docking station now allows us to exclude broken bikes from being considered when we are checking if the station is empty like so:

```ruby
def empty?
  bikes.reject{|b| b.broken?}.length == 0
end
```

Here we are using the Array reject method.  Look up [reject in the ruby Array documentation](http://ruby-doc.org/core-2.2.0/Array.html#method-i-reject) if you are unclear how it works.  Note that RuboCop insists we use an even more concise format:

```ruby
def empty?
  bikes.reject(&:broken?).length == 0
end
```

which means the same thing, but programmers love to be concise.  This simple change and all our tests should pass.

We've done several cycles of red/green jumping back and forth between feature and unit test levels, but are there any more refactoring opportunities?  Take a look through the code to see if you can find any.

# Stage 8

```ruby
class DockingStation
  DEFAULT_CAPACITY = 20

  attr_reader :capacity

  def initialize capacity = DEFAULT_CAPACITY
    @bikes = []
    @capacity = capacity
  end

  def release_bike
    fail 'No bikes available' if working_bikes.empty?
    bikes.delete working_bikes.pop
  end

  def dock bike
    fail 'Docking station full' if full?
    bikes << bike
  end

  private

  attr_accessor :bikes

  def full?
    bikes.count >= capacity
  end

  def working_bikes
    bikes.reject { |bike| bike.broken? }
  end

  def empty?
    bikes.empty?
  end
end
```

First, run all tests to make sure they pass. Then create `lib/bike_container.rb` file for our new module. Let's extract all methods from the docking station into the bike container. We'll discuss this code in more detail shortly.

```ruby
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
    bikes.count >= DEFAULT_CAPACITY
  end

  def empty?
    bikes.reject(&:broken?).empty?
  end
end
```

The first thing to note is that this is a module, not a class. A module is just like a class, except it cannot be instantiated, that is, you cannot do `BikeContainer.new`. The second interesting thing is that we have created an "accessor" methods for the `@bikes` instance variables.

```ruby
def bikes
  @bikes ||= []
end

def capacity
  @capacity ||= DEFAULT_CAPACITY
end

def capacity=(value)
  @capacity = value
end
```

This enables us to avoid working directly with the instance variables, [encapsulating](http://en.wikipedia.org/wiki/Encapsulation_(object-oriented_programming)) the implementation inside the module. Because of this change, all other methods now use the accessor methods instead of manipulating the instance variables directly. Consider this method:

```ruby
def full?
  bikes.count >= DEFAULT_CAPACITY
end
```

Here, `capacity` refers to the accessor method `capacity()` that we defined above.

The third interesting thing is the use of the `||=` operators to initialise values. Consider this method:

```ruby
def capacity
  @capacity ||= DEFAULT_CAPACITY
end
```

Whenever any other method calls `capacity()`, it will return the value of the instance variable `@capacity`. However, if `@capacity` is nil, it will assign `DEFAULT_CAPACITY` to it first. This operator is short for `@capacity = @capacity || DEFAULT_CAPACITY`.

This trick enables us to call the method `capacity()` before the value was set: it will be set to the default the first time it's accepted.  As with everything in Ruby please experiment with it in IRB to make sure you understand what's happening.

The DockingStation now looks something like this.

```ruby
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
```

Now our DockingStation class is very small because we extracted all methods (except the initialiser) into BikeContainer. We retain the initialiser, though, because we want to be able to set a custom capacity for the station, if we want to.

The tests should still pass because the functionality is equivalent. However, we need to refactor the tests before we check them in. The problem is that all tests that cover the functionality of BikeContainer are in docking_station_spec.rb, which is misleading. Let's create a separate suite of tests for the bike container.

Since we can't instantiate a module, we will need to create an artificial class for test purposes. The only job of that class will be to include BikeContainer. This is what the beginning of the test looks like (most tests omitted for brevity, refactor them on your own).

```ruby
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
```

This is pretty much the same test we used to have for the station, except that we're using an artificial class instead of a docking station. The DockingStation test now has only one test that checks that the initialiser is working correctly.

```ruby
require './lib/docking_station'

describe DockingStation do

  subject { described_class.new(capacity: 123) }

  it 'can set a default capacity on initialising' do
    expect(subject.capacity).to eq(123)
  end
end
```

Check that all tests still pass. If they do, push your code to Github, and switch Driver/Navigator Roles&nbsp;:twisted_rightwards_arrows:.
