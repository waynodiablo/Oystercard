## Stage 8: Feature Tests for Van & Garage

***As with all Makers Academy materials, there may be subtle errors in the following materials.  Please try to approach those as challenges on which to polish your debugging skills - pull requests always welcome.***

The relevant user stories here are:

```
As a maintainer of the system,
So that I can manage broken bikes and not disappoint users,
I'd like vans to take broken bikes from docking stations and deliver them to garages to be fixed.

As a maintainer of the system,
So that I can manage broken bikes and not disappoint users,
I'd like vans to collect working bikes from garages and distribute them to docking stations.
```

Follow the technique from the previous stages to design feature tests and then unit tests to drive the functionality of the Van and the Garage.  **The user stories above have multiple clauses in their task components**; should we break them out into separate features?

Also, before writing more code, let's think about what the other classes are and why we need them, starting with the van.

The van is moving broken bikes from the stations to the garage. Once they are fixed, the van moves them back to the stations. So the van must be able to accept the bikes at the source and release them at the destination. Obviously, the van must have some limit on the capacity, just like the station.

However, the van isn't going to be very different from the station. It may have some additional methods to interact with the station and the garage but overall it's fairly similar to the station.

The situation with the garage is very similar. What's the difference between a garage and a docking station? Only a van is supposed to take bikes out of a garage. Also, the bikes get fixed once they get to the garage. Otherwise, the garage is not much different from the station.

It seems likely that if we just implement the Garage and the Van classes in the same way we've done the DockingStation class, we'll be duplicating significant amounts of code. In this situation you need to extract common functionality into a new class or module that will be reused later.  However, in order to see how this works, we recommend that you first implement the Van class in a similar way to the DockingStation, i.e. as a holder of bikes.  Once you've done so, we recommend extracting the common functionality into a module.  If you're not feeling confident please do go on and implement the Garage in the same way, and then extract the functionality that is replicated three times over.

Assuming that you have completed the Van and/or Garage functionality, here's a walkthrough of how we extract the common functionality.

Let's start by looking at the shared behaviour of docking stations, vans and garages:

* They contain bikes
* They have a capacity
* You can put bikes in
* You can take bikes out

Each object might use a different language for these (.e.g. 'dock', 'load', 'release', 'unload' etc.) but the behaviour is essentially the same.  Let's test-drive the creation of a new `module` that encapsulates this behaviour.

Note:  A module cannot be instantiated in the way a class can.  You can't have an instance of a module.  In Ruby, modules are used to define common behaviour that can then be *included* into other objects.  If we are defining common behaviour for a docking station, van and garage, it follows that this behaviour will need to be included into the `DockingStation`, `Van` and `Garage` classes.  We don't want to have to write the same tests three times, so we will use the [shared example](https://www.relishapp.com/rspec/rspec-core/v/2-0/docs/example-groups/shared-example-group) feature of RSpec to write the tests once, then include those tests in the tests for docking station, van and garage.

Because we are testing a module, we don't have an actual object that we can test.  While we are test driving the module, we'll use a temporary class especially for the purposes of including the module so it can be tested.  Later, when we've test-driven the creation of this module, we'll do away with the temporary class.

`spec/bike_container_spec.rb`:
```ruby
require 'bike_container'

shared_examples_for BikeContainer do
  it 'has a default capacity when initialized' do
    expect(subject.capacity).to eq BikeContainer::DEFAULT_CAPACITY
  end
end

# The purpose of this class is to give us an instance of a
# class that includes `BikeContainer`, to initially run tests against
class BikeContainerTest; include BikeContainer; end

# it_behaves_like BikeContainer imports all the tests in the shared example
describe BikeContainerTest do
  it_behaves_like BikeContainer
end
```

We've chosen the default capacity as the first behaviour to model as it feels like a suitable place to start.  So how de we make this test pass?
`lib/bike_container.rb`:
```ruby
module BikeContainer
  DEFAULT_CAPACITY = 20

  attr_reader :capacity

  def initialize
    @capacity = DEFAULT_CAPACITY
  end
end
```
Note that we've defined `DEFAULT_CAPACITY` in the `BikeContainer` module.  That means `DockingStation`, `Van` and `Garage` will all have the same default capacity.  This is probably not ideal, but we'll stick with it for now for simplicity.

Depending on how you implemented the variable capacity, you may need to specify the capacity at the initialize stage.  Let's write a test for that:
```ruby
shared_examples_for BikeContainer do
  # other tests omitted for brevity

  describe 'capacity' do
    it 'can be overridden on initialize' do
      random_capacity = Random.rand(100)
      subject = described_class.new random_capacity
      expect(subject.capacity).to eq random_capacity
    end
  end
```
Why did we use a random capacity?  Discuss this idea with your pair partner - can you see any advantages and/or disadvantages with this approach?  We'll make it pass:
```ruby
module BikeContainer
  DEFAULT_CAPACITY = 20

  attr_reader :capacity

  def initialize capacity = DEFAULT_CAPACITY
    @capacity = capacity
  end
end

```
Let's add another test to `bike_container_spec.rb`:

```ruby
shared_examples_for BikeContainer do
  # other tests omitted for brevity
  describe '' do

  end
  describe 'add_bike' do
    it 'receives a bike' do
      subject.add_bike double :bike
      expect(subject).not_to be_empty?
    end
  end
end
```
Notice that we are not being driven by a feature test here.  Our motivation is refactoring, so we are driven by a desire for clean code.  Imagine every project has the unwritten user story:
```
As as conscientious software developer
So that my code is robust, readable and reusable
I want to refactor regularly
```
Let's speed things up a bit and add some related tests at the same time:

```ruby
shared_examples_for BikeContainer do
  # other tests omitted for brevity

  describe 'add_bike' do
    it 'receives a bike' do
      subject.add_bike double :bike
      expect(subject).not_to be_empty
    end

    it 'raises an error when full' do
      subject.capacity.times { subject.add_bike double(:bike) }
      expect { subject.add_bike double(:bike) }.to raise_error "#{described_class.name} full"
    end
  end
end
```
And let's make them pass:
```ruby
module BikeContainer
  # other code omitted for brevity

  def initialize capacity = DEFAULT_CAPACITY
    @capacity = capacity
    @bikes = []
  end

  def add_bike(bike)
    raise "#{self.class.name} full" if full?
    bikes << bike
  end

  def empty?
    bikes.empty?
  end

  def full?
    bikes.count >= capacity
  end

  private

  attr_reader :bikes
end
```

Take some time to study the code above with your pair partner.  What do you think `self.class.name` means?  What is the class in this case?  Why have we made the `bikes` attribute private?

Let's finish by enabling bikes to be taken out of a bike container:

```ruby
shared_examples_for BikeContainer do
  # other tests omitted for brevity

  describe 'remove_bike' do
    let(:bike) { Bike.new }
    before(:each) { subject.add_bike bike }

    it 'returns a bike' do
      expect(subject.remove_bike).to eq bike
    end

    it 'removes the bike from the collection' do
      subject.remove_bike
      expect(subject).to be_empty
    end

    it 'raises an error when empty' do
      subject.remove_bike
      expect { subject.remove_bike }.to raise_error "#{described_class.name} empty"
    end
  end
end
```
Take a good look through these tests.  Notice how each test includes just one expectation and tests a very specific part of the `remove_bike` behaviour.  You could imagine combining all of these into one test:
```ruby
shared_examples_for BikeContainer do
  # other tests omitted for brevity

  it 'enables bikes to be removed' do
    bike = Bike.new
    subject.add_bike bike

    expect(subject.remove_bike).to eq bike
    expect(subject).to be_empty

    expect { subject.remove_bike }.to raise_error "#{described_class.name} empty"
  end
end
```
But this is considered bad practice as the test is responsible for testing 3 different things, which violates the *Single Responsibility Principle (SRP)*.  Furthermore, the RSpec output `remove_bike enables bikes to be removed` doesn't really tell us how the method behaves - we would still have to read the code.

Can you get these tests to pass?  It should be as simple as the following:
```ruby
def remove_bike
  raise "#{self.class.name} empty" if empty?
  bikes.pop
end
```
Let's look at our shared requirements for docking station, van and garage again:

* They contain bikes
* They have a capacity
* You can put bikes in
* You can take bikes out

Have we fulfilled them?  It feels like we have, so how do we go about implementing this new behaviour.  First, we should test drive it.  Add the following to `spec/docking_station_spec.rb`:
```ruby
require 'docking_station'
require 'bike_container'

describe DockingStation do
  # other code omitted for brevity

  it_behaves_like BikeContainer
end
```
Run RSpec and make sure the new tests are failing.  Now let's fix it in `lib/docking_station.rb`
```ruby
require_relative 'bike'
require_relative 'bike_container'

class DockingStation
  include BikeContainer

  def release_bike
    fail 'No bikes available' if working_bikes.empty?
    bikes.delete working_bikes.pop
  end

  def dock bike
    add_bike bike
  end

  private

  def working_bikes
    bikes.reject { |bike| bike.broken? }
  end
end
```
Whoa!  Where has all the other code gone?  Well, everything we've defined in `BikeContainer` is now also included in `DockingStation`, so we can remove all of the duplicate code.  Notice how we have kept `dock` and `release_bike` though.  Releasing a working bike from a docking station is not the same as removing the next bike along, so we still need this specialized method.  `dock` is really now just an alias for 'add_bike' as it delegates directly to that method.  This is a common approach in Ruby and improves the readability and domain-relevance of our code.  `docking_station.dock` is more intuitive than `docking_station.add_bike`.

You may have implemented things slightly differently, but take a look at the code for `release_bike`.  What's happening in the line `bikes.delete working_bikes.pop`?  Discuss this with your pair partner and discuss other ways to approach this problem.

Now you can create refactor your `Van` and/or `Garage` classes so that they will reuse `BikeContainer`. You'll need to think how to extend the functionality of the existing methods. For example, will you create aliases for `add_bike` and `remove_bike`?  Maybe 'load' and 'unload' for `Van`.  The garage must fix the bikes as they arrive. However, the `add_bike()` method knows nothing about fixing bikes:

```ruby
def add_bike(bike)
  raise "#{self.class.name} full" if full?
  bikes << bike
end
```
There are a number of ways you might approach this.  One would be to define a separate method, which fixes the bike, then delegates to `add_bike`:

```ruby
def accept(bike)
    bike.fix
    add_bike bike
end
```

The advantage is the simplicity. The disadvantage is that this isn't quite consistent with the real domain.  A bike does not get fixed simply by being put in the garage - this is a separate stage.  We have tightly coupled the fixing of bikes with the adding of bikes.  It might be preferable to create a `fix_bikes` method which, for now, simply fixes all bikes in the garage:
```ruby
require 'garage'

describe Garage do
  it_behaves_like BikeContainer

  it 'fixes broken bikes' do
    bike = double :bike
    subject.add_bike bike
    expect(bike).to receive :fix
    subject.fix_bikes
  end
end
```

Notice how this test is structured.  This problem is similar to the `release_bike` test for docking station.  It is tempting to test that the bike is not broken after we've called `fix_bikes`.  However, by using doubles, we can see that this would be a vacuous test:
```ruby
require 'garage'

describe Garage do
  it_behaves_like BikeContainer

  it 'fixes broken bikes' do
    bike = double :bike, fix: nil, broken?: false
    subject.add_bike bike
    subject.fix_bikes
    expect(bike).not_to be_broken
  end
end
```
We have to stub `broken?` because `bike` is a double; but we are then testing that the stubbed method returns `false`.  So this is no longer a test of `Garage`, but a test of RSpec doubles!  One of the reasons the London style is so effective is it helps ensure we are testing the behaviour of the correct object.

By testing `expect(bike).to receive :fix`, we are ensuring the `fix_bikes` method has the correct behaviour.  The fact that the bike subsequently becomes fixed is the responsibility of the `fix` method in `Bike` and should be unit tested in `bike_spec.rb` accordingly.

Nevertheless, we should still have a test that creates a garage, adds bikes, fixes them and then tests that the bikes are no longer broken.  But what sort of test would this be?

Try using what we've learned in this stage to complete all the feature and unit tests for the docking station, van and garage, refactored to use `BikeContainer`.

Once you've finished up here check out the [Stage 9](boris_bikes_stage_9.md) extension!
