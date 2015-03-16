## Stage 5: Giving Docking Stations Limited Capacities

:construction: UNDER CONSTRUCTION :construction:

Given this next user story:

```
As a maintainer of the system,
So that members of the public can get usable bikes,
I'd like docking stations to not accept more bikes than their capacity.
```

It follows that we should prevent more than one bike being docked, rather than what we are currently doing which is that each time we dock a new bike, any existing bike is being discarded.  We might also consider moving towards allowing more than one bike to be stored.  Although that's an assumption.  Does the client want docking stations that store just 1 bike or should they store 20, 50, 100?  This would be a good time to check with the client what the storage capacity requirements are for docking station.  Perhaps they weren't discussed in the initial client meeting.  

Say that we couldn't contact the client immediately, what should we do?  We've got a user story that indicates that docking stations should not accept more than their capacity.  The way that we've set up the DockingStation instance variables assumes a capacity of 1.  In order to do the least amount of work to support the user story, let's create a feature test that raises an error when trying to dock a bike in a station that already has a bike docked.  This corresponds to an initial capacity of 1.  Let's imagine that we've sent an email to our client asking for clarification but in the mean time let's push on with our minimal interpretation of a capacity of 1.

Let's start by creating a feature test:

```ruby
describe 'member of public or other docks bike' do
  it 'and station is full' do
    docking_station = DockingStation.new
    docking_station.dock Bike.new
    expect { docking_station.dock Bike.new }.to raise_error 'Station Full'
  end
end
```

This should go in a new file spec/feature/public_bike_dock_spec.rb.  Check that this fails in the correct fashion.  Naturally you'll be inclined to immediately write a matching unit test:

```ruby
require 'docking_station'

describe DockingStation do
  # other tests omitted for brevity
  it 'raises an error when full' do
    subject.dock Bike.new
    expect { subject.dock Bike.new }.to raise_error 'Station Full'
  end
end
```

However in doing so you will have broken the independence of the docking station unit test.  It now requires knowledge of the Bike class.  If we think about things carefully we realise that we don't actually have to pass in a bike object at all in order to check this aspect of the DockingStation functionality.  We could just pass in symbols instead like so:

```ruby
require 'docking_station'

describe DockingStation do
  # other tests omitted for brevity
  it 'raises an error when full' do
    subject.dock :bike
    expect { subject.dock :bike }.to raise_error 'Station Full'
  end
end
```

This is also called the London style of unit-testing and we prefer it since it means our unit-tests are focused exclusively on testing a single class.  Our integration tests (that happen to be feature tests in this example) use the Chicago sytle of testing with multiple classes and check that our classes interact together effectively.

Let's go on and make both levels of test pass with the following:

```ruby
class DockingStation
  def dock bike
    fail 'Station Full' if @bike
    @bike = bike
  end

  def release_bike
    fail 'No Bikes Available' unless @bike
    @bike
  end
end
```

Notice how in the process of making this functionality we've completely removed the alias_method and attr_* operations that were required by the ruby style guide?  This is a perfectly normal process of code revision that will take place time and time again.

[COULD TALK ABOUT PULLING OUT ERROR MESSAGES TO CONSTANTS]

We just finish getting this working and in comes an email from our client, apparently docking stations should have a default capacity of 20, but sometimes they have a capacity of 30 or 40.  Hearing this we refrain from leaping in to the code base, or even the tests, but update our user stories and domain appropriately.

[SHOW UML DIAGRAM GOING FROM 1-1 to 1-N RELATION]

```
As a system maintainer,
So that a station can serve many members of the public,
I want a docking station to have a default capacity of 20 bikes.

As a system maintainer,
So that busy areas can be served more effectively,
I want to be able to specify a larger capacity when necessary.
```

Reflecting on our domain model so far, we see that in response to several user stories we have created a bike which responds to the 'broken?' method, and a docking station that can dock an object, release that object and will raise errors if we try to dock an object in a station that already has one, and if we try to release an object when the docking station is empty.  Interestingly at the moment there is nothing that strongly ties the two objects together, although clearly we intend for bikes to the objects that docking stations hold.  Now it seems clear that we'd like to allow a docking station to hold multiple objects, specifically bikes.  Let's start implementing the user story that specifies a default capacity of 20.

We have some options now.  We could start creating a series of instance variables in our docking station class, e.g. @bike0, @bike1, @bike2; we could have an array instance variable, e.g. @bikes = []; or even a hash such as @bikes = {}.  Ideally we should choose the least complex data structure that supports what we need to achieve working user stories.  It is often temping to think, ooh, yes, bikes could have ids and so we could use a hash and then we could grab bike by id, e.g. {'BIKEID007': <#Bike>} etc., but we are not yet working on any users stories that require bikes to have ids.  I can't stress enough, but you will make faster progress if you keep your object models and data structures as simple as possible.  In this case the array seems like a good choice for keeping track of the maximum 20 bikes we need to be able to store in our docking station.  And we might be tempted to leap in and start hacking up our application code, adding an array and so on, but it is a much better practice to hold off deciding on the actual data structure or object model until the last minute.  Far better to allow the user stories to drive us to create tests that specify how our system operates.  Get that nailed down and then it should become clear which is the best choice of data structure of object model.

So let's adjust our existing feature test 'public_bike_doc_spec.rb' to support this new user story:

```ruby
describe 'member of public or other docks bike' do
  it 'and station is full' do
    docking_station = DockingStation.new
    20.times { docking_station.dock Bike.new }
    expect { docking_station.dock Bike.new }.to raise_error 'Station Full'
  end
end
```

Naturally this fails.  Note that we haven't updated our unit tests yet.  One step at a time.  It's a good idea to check that you get the errors and failures you expect to get after each change.  Let's now update our docking_stations_spec.rb unit test:

```ruby
require 'docking_station'

describe DockingStation do
  # other tests omitted for brevity
  it 'raises an error when full' do
    20.times { subject.dock Bike.new }
    expect { subject.dock Bike.new }.to raise_error 'Station Full'
  end
end
```

We should now have a pair of matching failures at the feature and unit test level.  Now it's time to start changing our application code.  An array seems like a good data structure for holding the bikes - let's try that out:

```ruby
class DockingStation
  def initialize
    @bikes = []
  end

  def dock bike
    fail 'Station Full' if @bikes.length >= 20
    @bikes << bike
  end

  def release_bike
    fail 'No Bikes Available' if @bikes.length == 0
    @bikes.pop
  end
end
```

Both feature and unit tests should now pass and our docking station is starting to have some meat on it. There's also a A LOT of room for refactoring now.  Can you think of some?

One thing we could do is create some private helper methods 'empty?' and 'full?' to make our code a little more readable.  In general we don't write tests for private methods.  Private methods help keep the public interface of our class to a minimum.  We may choose to expose them later if necessary.

```ruby
class DockingStation
  def initialize
    @bikes = []
  end

  def dock bike
    fail 'Station Full' if full?
    @bikes << bike
  end

  def release_bike
    fail 'No Bikes Available' if empty?
    @bikes.pop
  end

  private

  def full?
    @bikes.length >= 20
  end

  def empty?
    @bikes.length == 0
  end
end
```

We might also extract the default capacity to a constant, and use a private attr_reader to have all our references to the @bikes instance variable go through a single interface:

interface of our class to a minimum.  We may choose to expose them later if necessary.

```ruby
class DockingStation
  DEFAULT_CAPACITY = 20
  def initialize
    @bikes = []
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

  attr_reader :bikes

  def full?
    bikes.length >= DEFAULT_CAPACITY
  end

  def empty?
    bikes.length == 0
  end
end
```

:running_shirt_with_sash: ATHLETIC WAYPOINT - try re-creating the code so far from scratch without looking at the tutorial.


We have a remaining user story here:

```
As a system maintainer,
So that busy areas can be served more effectively,
I want to be able to specify a larger capacity when necessary.
```

Try to implement the necessary functionality through appropriate use of feature and unit tests.

[TODO: LINK TO STAGE 6]
