##Stage 4: Add the next Feature Test

***As with all Makers Academy materials, there may be subtle errors in the following materials.  Please try to approach those as challenges on which to polish your debugging skills - pull requests always welcome.***

Our feature test is passing, ensuring that we are delivering value to our client.  We've got unit tests for the `Bike` and `DockingStation` classes.  Now let's consider another user story in the same part of the problem space:

```
As a member of the public,
So that I am not confused and charged unnecessarily,
I'd like docking stations not to release bikes when there are none available.
```

Let's imagine the `irb` interaction for this story.  For simplicity, we'll expect an exception to be raised when there are no bikes available.  Something like this perhaps:

```
2.1.5 :001 > require './lib/docking_station'
 => true
2.1.5 :002 > docking_station = DockingStation.new
 => #<DockingStation:0x007fe022230258 ...>
2.1.5 :003 > docking_station.release_bike
RuntimeError: No bikes available
	.... stack trace omitted ....
```

Can you imagine the corresponding feature test?  Note that moving forward, the walkthroughs will fill in fewer and fewer gaps.  As you get stuck you'll need to use your problem-solving skills to work out what is going wrong and to get you back on track.  Try not to get frustrated - the key is to stay calm and work with your pair partner to figure out the logic of what is going on.  Let's get you started:

```ruby
require 'docking_station'

feature 'member of public accesses bike' do
  scenario 'docking station releases a working bike' do
    docking_station = DockingStation.new
    bike = docking_station.release_bike
    expect(bike).to be_working
  end

  scenario 'docking station does not release a bike when there are none available' do
    docking_station = DockingStation.new
    expect { docking_station.release_bike }.to raise_error 'No bikes available'
  end
end
```

Whatever we do, these two feature tests cannot both pass.  Either docking stations will start with an initial bike (or bikes), or they will start empty.  We'll need to make a decision here, perhaps in consultation with the client.  However it seems a reasonable assumption that docking stations will start empty, so let's go with that for the time being.  It implies that we'll need to change our first user story to ensure that there is a bike to hand out to the first user.  We're making some assumptions about the docking station here, but we are also **writing the code we wish we had**.

```ruby
require 'docking_station'

feature 'member of public accesses bike' do
  scenario 'docking station releases a working bike' do
    docking_station = DockingStation.new
    docking_station.dock Bike.new
    bike = docking_station.release_bike
    expect(bike).to be_working
  end

  scenario 'docking station does not release a bike when there are none available' do
    docking_station = DockingStation.new
    expect { docking_station.release_bike }.to raise_error 'No bikes available'
  end
end
```

It follows that we should now drop down to the unit-test level to ensure that our docking station has the necessary `dock` method to initially receive a bike:

```ruby
require 'docking_station'

describe DockingStation do
  # existing tests omitted for brevity

  it { is_expected.to respond_to :dock }
end
```

However this isn't going to help our acceptance test much, because we are calling dock *with an argument*.  We'll need a more rigorous test.  Fortunately, RSpec allows us to specify arguments:

```ruby
require 'docking_station'
describe DockingStation do
  # existing tests omitted for brevity

  it { is_expected.to respond_to(:dock).with(1).argument }
end
```

Run `rpsec` to see our new unit test fail:
```
DockingStation should respond to #dock with 1 argument
     Failure/Error: it { is_expected.to respond_to(:dock).with(1).argument }
       expected #<DockingStation:0x007fc5195d5300> to respond to :dock with 1 argument
     # ./spec/docking_station_spec.rb:11:in `block (2 levels) in <top (required)>'
```

Then fix the failure:

```ruby
class DockingStation
  def release_bike
    Bike.new
  end

  def dock bike

  end
end
```
we should now be back to our failing feature test:

```
1) member of public accesses bike docking station does not release a bike when there are none available
   Failure/Error: expect { docking_station.release_bike }.to raise_error 'No bikes available'
     expected Exception with "No bikes available" but nothing was raised
   # ./spec/feature/public_accesses_bike_spec.rb:13:in `block (2 levels) in <top (required)>'
```

And again it's tempting to just go ahead and fix the application code, but what we should really be doing here is adjusting the unit test for our DockingStation so that we have a unit test check of the error being raised when the station is empty.

```ruby
require 'docking_station'

describe DockingStation do
  # other tests omitted for brevity

  describe 'release_bike' do
    it 'raises an error when there are no bikes available' do
      expect { subject.release_bike }.to raise_error 'No bikes available'
    end
  end
end
```

Notice the nested `describe` block.  Why have we introduced this?  Until now, we have been describing behaviour in a general sense.  However, we are now describing behaviour *specific to a particular method*.  By nesting this in another `describe` block, we are able to DRY out our descriptions.

Again we should now have a pair of failing tests that give very similar output:

```
Failures:

  1) DockingStation release_bike raises an error when there are no bikes available
     Failure/Error: expect { subject.release_bike }.to raise_error 'No bikes available'
       expected Exception with "No bikes available" but nothing was raised
     # ./spec/docking_station_spec.rb:15:in `block (3 levels) in <top (required)>

  2) member of public accesses bike docking does not release a bike when there are none available
     Failure/Error: expect { docking_station.release_bike }.to raise_error 'No bikes available'
       expected Exception with "No bikes available" but nothing was raised
     # ./spec/features/public_accesses_bike_spec.rb:10:in `block (2 levels) in <top (required)>'

Finished in 0.00678 seconds (files took 1.17 seconds to load)
7 examples, 2 failures

Failed examples:

rspec ./spec/docking_station_spec.rb:14 # DockingStation release_bike raises an error when there are no bikes available
rspec ./spec/features/public_accesses_bike_spec.rb:8 # member of public accesses bike docking station does not release a bike when there are none available
```

One is a failing feature test, but the other is a failing *unit test*.  Now, finally, we can change some production code.  We could do the following:

```ruby
class DockingStation

  def release_bike
    raise 'No bikes available'
  end

  def dock bike

  end
end
```
But what would happen?  Try it and rerun your tests.  This is part of the beauty of TDD - you can experiment with different approaches and use your tests to analyze the outcome.  We haven't really improved the situation - we've fixed two tests, but broken two others.

We cannot proceed any further without introducing some *state* into `DockingStation`.  State is the ability of an object to retain information about itself.  Critically, we need to know whether it has any bikes to release.  When a bike is docked, we need to retain that information and use it again when `release_bike` is called.

At a future point, `DockingStation` is going to need to manage multiple bikes.  However, at the moment we are only interested in passing our tests.  Let's do the simplest thing possible:

```ruby
class DockingStation

  def release_bike
    @bike
  end

  def dock bike
    @bike = bike
  end
end
```
Great, now we've got *three* failing tests!  Let's take a moment to reflect on what we have done so far.  What is `@bike`?  Why is our previously-passing unit test now failing?

```
1) DockingStation releases working bikes
   Failure/Error: expect(bike).to be_working
     expected  to respond to `working?`
   # ./spec/docking_station_spec.rb:8:in `block (2 levels) in <top (required)>'
```

By default, our `@bike` instance variable in `DockingStation` is `nil`.  All Ruby instance variables are initially `nil` by default.  In order to have this DockingStation test pass we need to fix it as we did our feature test:
```ruby
describe DockingStation do
  # other tests omitted for brevity

  it 'releases working bikes' do
    subject.dock Bike.new
    bike = subject.release_bike
    expect(bike).to be_working
  end
end
```

Now we can finally create the functionality we expect:
```ruby
class DockingStation

  def release_bike
    fail 'No bikes available' unless @bike
    @bike
  end

  def dock bike
    @bike = bike
  end
end
```
And we should have the joy of seeing both our unit test and feature test both go green at the same time.

It might seem trivial, but what we've done here is model a docking station that can accept a single bike.  We know that we'll probably need to store more bikes in future but, particularly when learning, it is highly instructive to work carefully through much simpler versions of a system.  Also, surprisingly even for experts, it's often a great idea to play with super-simplified versions of a system, before gradually increasing the complexity level.  It tends to be easier to make progress if you build on a simple base.

Notice also how the design of `DockingStation` and `Bike` has *emerged*.  We haven't directly considered the design of these classes at all - they have simply emerged from our tests.  This is a powerful feature of TDD and while there might seem like a lot of to-ing and fro-ing initially, we are constantly learning about the domain and finding the simplest way to model it.

:running_shirt_with_sash: ATHLETIC WAYPOINT - try re-creating the code so far from scratch without looking at the tutorial. Here is a reminder of the the User Stories we have completed so far:

```
As a member of the public
So that I can get across town
I'd like to get a working bike from a docking station.

As a member of the public,
So that I am not confused and charged unnecessarily,
I'd like docking stations not to release bikes when there are none available.
```

Then time to move on to [Stage 5](boris_bikes_stage_5.md)!
