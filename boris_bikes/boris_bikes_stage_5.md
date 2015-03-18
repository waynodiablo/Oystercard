## Stage 5: Giving Docking Stations Limited Capacities

***As with all Makers Academy materials, there may be subtle errors in the following materials.  Please try to approach those as challenges on which to polish your debugging skills - pull requests always welcome.***

At any point in the development process there is a judgement call to make about whether to refactor or to start working on new features.  There is no hard and fast rule.  You may be particularly offended by the design smells coming from your code.  You may feel that they will be naturally resolved as part of the process of implementing the next user story.  Spend a little time reflecting on the code you have so far.  It should be pretty lean :-) Time for another user story:

```
As a maintainer of the system,
So that members of the public can get usable bikes,
I'd like docking stations to not accept more bikes than their capacity.
```

It follows that we should prevent more than one bike being docked, rather than what we are currently doing which is that each time we dock a new bike, any existing bike is being discarded.  We might also consider moving towards allowing more than one bike to be stored.  Although that's an assumption.  Does the client want docking stations that store just 1 bike or should they store 20, 50, 100?  This would be a good time to check with the client what the storage capacity requirements are for docking station.  Perhaps they weren't discussed in the initial client meeting.  

Say that we couldn't contact the client immediately, what should we do?  We've got a user story that indicates that docking stations should not accept more than their capacity.  The way that we've set up the DockingStation instance variables assumes a capacity of 1.  In order to do the least amount of work to support the user story, let's create a feature test that raises an error when trying to dock a bike in a station that already has a bike docked.  This corresponds to an initial capacity of 1.  Let's imagine that we've sent an email to our client asking for clarification but in the mean time let's push on with our minimal interpretation of a capacity of 1.

Let's start by creating a feature test:

```ruby
feature 'member of public docks bike' do
  scenario 'docking station unable to receive as full' do
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

Notice anything wrong here? We've just broken the independence of the docking station unit test.  It now requires knowledge of the Bike class.  If we think about things carefully we realise that we don't actually have to pass in a bike object at all in order to check this aspect of the DockingStation functionality.  We could just pass in symbols but we should probably switch to making consistent use of doubles since they will report any unexpected usage in a more consistent fashion:

```ruby
require 'docking_station'

describe DockingStation do
  # other tests omitted for brevity
  it 'raises an error when full' do
    subject.dock double :bike
    expect { subject.dock double :bike }.to raise_error 'Station Full'
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

Notice how in the process of making this functionality we've completely removed the alias_method and attr_* operations that were required by the ruby style guide?  This is a perfectly normal process of code revision that will take place time and time again.  We're not expecting our code to be perfect first time round.  We'll do the minimum to support an individual feature test, and then refactor and add more features as appropriate.

We just finish getting this working and in comes an email from our client, apparently docking stations should have a default capacity of 20, but sometimes they have a capacity of 30 or 40.  Hearing this we refrain from leaping in to the code base, or even the tests, but update our user stories and domain appropriately.

```
As a system maintainer,
So that a station can serve many members of the public,
I want a docking station to have a default capacity of 20 bikes.

As a system maintainer,
So that busy areas can be served more effectively,
I want to be able to specify a larger capacity when necessary.
```

Reflecting on our domain model so far, we see that in response to several user stories we have created a bike which responds to the 'broken?' method, and a docking station that can dock an object, release that object and will raise errors if we try to dock an object in a station that already has one, and if we try to release an object when the docking station is empty.  Interestingly at the moment there is nothing that strongly ties the two objects together, although clearly we intend for bikes to the objects that docking stations hold.  Now it seems clear that we'd like to allow a docking station to hold multiple objects, specifically bikes.  Let's start implementing the user story that specifies a default capacity of 20.

We have some options now.  You might find yourself thinking about what data structure we use to allow docking stations to 'contain' bikes. We might imagine a series of instance variables in our docking station class, e.g. @bike0, @bike1, @bike2; or an array instance variable, e.g. @bikes = []; or even a hash such as @bikes = {}.  Ideally we should choose the least complex data structure that supports what we need to pass feature tests that represent our user stories.  It is often tempting to think, ooh, yes, bikes could have ids and so we could use a hash and then we could grab bike by id, e.g. {'BIKEID007': <#Bike>} etc., but we are not yet working on any user stories that require bikes to have ids.  I can't stress enough, but you will make faster progress if you keep your object models and data structures as simple as possible.  In this case the array seems like a good choice for keeping track of the maximum 20 bikes we need to be able to store in our docking station.  And we might be tempted to leap in and start hacking up our application code, adding an array and so on, but it is a much better practice to hold off deciding on the actual data structure or object model until the last minute.  Far better to allow the user stories to drive us to create tests that specify how our system operates.  Get that nailed down and then it should become clear which is the best choice of data structure or object model.

So let's adjust our existing feature test 'public_bike_doc_spec.rb' to support this new user story:

```ruby
feature 'member of public docks bike' do
  scenario 'docking station unable to receive as full' do
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
    20.times { subject.dock double :bike }
    expect { subject.dock double :bike }.to raise_error 'Station Full'
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
    fail 'No Bikes Available' if @bikes.empty?
    @bikes.pop
  end
end
```

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

One thing we could do is create some private helper methods 'empty?' and 'full?' to make our code a little more readable.  In general we don't write tests for private methods.  Private methods help keep the public interface of our class to a minimum.  We may choose to expose them later if necessary.

```ruby
class DockingStation
  def initialize
    @bikes = []
  end

  def dock bike
    fail 'Station Full' if full?
    @bikes << bike
    nil
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
    @bikes.empty?
  end
end
```

We might also extract the default capacity to a constant, and use a private attr_reader to have all our references to the @bikes instance variable go through a single interface:

```ruby
class DockingStation
  DEFAULT_CAPACITY = 20
  def initialize
    @bikes = []
  end

  def dock bike
    fail 'Station Full' if full?
    bikes << bike
    nil
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
    bikes.empty?
  end
end
```

We prefer to reference our instance variable within our class via getter methods in order to DRY out the '@' symbols, and so also that if we need to make some consistent initialization or change to our instance variable, then we can do it in one place, rather than having to update a series of scattered references to instance variables throughout the class.  In general any time we see a free floating number in our class we refer to it as a 'magic number'.  What does it mean?  What is it doing.  It's considered good practice extract any magic numbers to constants, so that we can label what they mean, and refer to them outside the class as necessary.  Given the above code, from outside the class we can refer to DockingStation::DEFAULT_CAPACITY in order to avoid repetition of the same magic numbers in our tests - give it a try :-)

:running_shirt_with_sash: ATHLETIC WAYPOINT - try re-creating the code so far from scratch without looking at the tutorial.

We have a remaining user story relating to capacity:

```
As a system maintainer,
So that busy areas can be served more effectively,
I want to be able to specify a larger capacity when necessary.
```

Have a go in your pair at implementing the necessary functionality through appropriate use of feature and unit tests.

Think about the sequence of steps you might use, e.g.

1) think about the irb interaction
2) create a feature test that fails
3) create a minimal unit test
4) see the paired failing feature and unit tests
5) create the functionality in the application
6) see the unit test pass and the feature test move to next fail
7) loop back to step 3 until feature test passes

The key question is how will a new capacity be passed to the docking station. And can docking stations change their capacity over time?  Hmm, another question for the client, we can send another email, but in the mean time what should we assume?  That docking station capacities can change over time, or that they are fixed once?  Depending on what we assume we might choose a different route to pass the new capacity to a docking station.  If fixed once then we might well pass through an initialize method like so:

```sh
→ irb
2.1.5 :001 > require './lib/docking_station'
 => true
2.1.5 :002 > docking_station = DockingStation.new 50
  => #<DockingStation:0x007fa37eba3be0 @bikes=[], @capacity=50>
```

which would rely on an initialize method in our class

```ruby
class DockingStation
  def initialize capacity
    @capacity = capacity
  end
end
```

however if docking station capacities can vary over their lifetime them perhaps we could create a setter method like so:

```ruby
class DockingStation
  attr_writer :capacity
end
```

so that we can update the docking station capacity at will:

```sh
→ irb
2.1.5 :001 > require './lib/docking_station'
 => true
2.1.5 :002 > docking_station = DockingStation.new
=> #<DockingStation:0x007fa37eb90338 @bikes=[], @capacity=20>
2.1.5 :003 > docking_station.capacity = 25
=> #<DockingStation:0x007fa37eb90338 @bikes=[], @capacity=25>
2.1.5 :004 > docking_station.capacity = 55
=> #<DockingStation:0x007fa37eb90338 @bikes=[], @capacity=55>
```

In the absence of input from the client which is the best place to start?  You decide.  If you go for the former consider how you'll handle the case when no capacity is initially set [Hint: the POODR book has come great tips on these kinds of things - check out chapter 3 on defaults for initializers as well as researching Ruby's ability to set default values for arguments on any method].

Then time to move on to [Stage 6](boris_bikes_stage_6.md)!
