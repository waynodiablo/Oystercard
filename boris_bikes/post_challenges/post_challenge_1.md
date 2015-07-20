## Post Challenge 1: Implementing the next user story

[Back to the Challenge Map](../0_challenge_map.md)

> From this point onwards, you will not use Challenges. Instead, you will use a more traditional 'tutorial'. Try to bring the same 'try it first' approach you've used during the Challenges to these Post Challenges.

***As with all Makers Academy materials, there may be subtle errors in the following materials.  Please try to approach those as challenges on which to polish your debugging skills - pull requests always welcome.***

Our first feature is passing, ensuring that we are delivering value to our client.  We've got unit tests for the `Bike` and `DockingStation` classes.  Now let's consider another user story in the same part of the problem space:

```
As a member of the public,
So that I am not confused and charged unnecessarily,
I'd like docking stations not to release bikes when there are none available.
```

Let's imagine the `irb` interaction that will be our manual feature test for this story.  For simplicity, we'll expect an exception to be raised when there are no bikes available.  Something like this perhaps:

```
$ irb
2.1.5 :001 > require './lib/docking_station'
 => true
2.1.5 :002 > docking_station = DockingStation.new
 => #<DockingStation:0x007fe022230258 ...>
2.1.5 :003 > docking_station.get_bike
RuntimeError: No bikes available
  .... stack trace omitted ....
```

Can you imagine what unit tests we might write to support this behaviour?

At the moment we don't get the above behaviour in irb.  The two features we have created contradict each other.  Either docking stations will start with an initial bike (or bikes), or they will start empty.  We'll need to make a decision here, perhaps in consultation with the client.  However, it seems a reasonable assumption that docking stations will start empty, so let's go with that for the time being.  It implies that we'll need to change our first user story to ensure that there is a bike to hand out to the first user.  We're making some assumptions about the docking station here, but we are also **defining the code we wish we had**.  Here's our original manual test, adjusted to dock a new bike initially, to account for docking stations being empty by default:

```sh
$ irb
2.0.0-p195 :001 > station = DockingStation.new
 => #<DockingStation:0x007fae7b3b8950>
2.0.0-p195 :002 > station.dock Bike.new
 => #<Bike:0x007fae7b3c0dd0>
2.0.0-p195 :003 > bike = station.get_bike
 => #<Bike:0x007fae7b3c0dd0>
2.0.0-p195 :004 > bike.working?
 => true
```

Before you try this in IRB, can you anticipate what will happen?  Neither of these manual tests will work with our current code in IRB.  We could choose to work on either one.  Either way, we want to drop down to the unit-test level.  Let's focus on our original feature and ensure that our docking station has the necessary `dock` method to initially receive a bike:

```ruby
require 'docking_station'

describe DockingStation do
  # existing tests omitted for brevity

  it { is_expected.to respond_to :dock }
end
```

However this doesn't cover it, because we are calling dock *with an argument*.  We'll need a more rigorous test.  Fortunately, RSpec allows us to specify arguments:

```ruby
require 'docking_station'
describe DockingStation do
  # existing tests omitted for brevity

  it { is_expected.to respond_to(:dock).with(1).argument }
end
```

Run `rspec` to see our new unit test fail:
```
DockingStation should respond to #dock with 1 argument
     Failure/Error: it { is_expected.to respond_to(:dock).with(1).argument }
       expected #<DockingStation:0x007fc5195d5300> to respond to :dock with 1 argument
     # ./spec/docking_station_spec.rb:11:in `block (2 levels) in <top (required)>'
```

Then fix the failure:

```ruby
class DockingStation
  def get_bike
    Bike.new
  end

  def dock bike

  end
end
```

Our original feature test should now work - try it in IRB - although clearly the dock method is not doing any useful work yet.  It's tempting to do more, but let's make sure we always to the minimum asked of us by our tests, and then drive any other application code we want to add by writing more tests.

Anyhow, we are no closer to having our second feature pass.  Let's add a unit test to our DockingStation spec to check that an explicit error is raised when the station is empty.

```ruby
require 'docking_station'

describe DockingStation do
  # other tests omitted for brevity

  describe '#get_bike' do
    it 'raises an error when there are no bikes available' do
      expect { subject.get_bike }.to raise_error 'No bikes available'
    end
  end
end
```

Note the braces `{}`, rather than parentheses `()`, in our expectation. We'll come back to this shortly.

Notice also the nested `describe` block.  Why have we introduced this?  Until now, we have been describing behaviour in a general sense.  However, we are now describing behaviour *specific to a particular method*.  By nesting this in another `describe` block, we are able to DRY out our descriptions.

Again we now have a match between our manual feature test and our unit test.  Our manual irb test for our second feature is failing to raise an error and our unit test is failing for the same reason; the absence of an error.  Now, finally, we can change some production code.  We could do the following:

```ruby
class DockingStation

  def get_bike
    fail 'No bikes available'
  end

  def dock bike

  end
end
```

But what would happen?  Try it and rerun your tests.  This is part of the beauty of TDD - you can experiment with different approaches and use your tests to analyze the outcome.  We haven't really improved the situation - we've fixed one test, but broken another.

Before you go any further, study the syntax of our bike availability test with your pair partner.  **There is a critical learning to be had here.**  What do the curly braces in the line `expect { docking_station.get_bike }.to raise_error` mean?  Why couldn't we have used ordinary parentheses instead: `expect(docking_station.get_bike).to raise_error`?  Do not proceed until you have understood this distinction.  Ask an Alumni Helper or coach to explain if you are stuck.  **These are the subtle nuances in computer programming that differentiate a hacky hobbyist from a serious junior developer.**

That's the last time you need to be told to run `rspec`.  Every time you make a change to your tests or your production code, run `rspec`.  Did you try the above example and run `rspec` as suggested, or did you read through?  **Take every available opportunity to explore the code and different outcomes.  Follow every path suggested.  Experimentation is the most powerful learning tool available to you.**

We cannot proceed any further without introducing some *state* into `DockingStation`.  State is the ability of an object to retain information about itself.  Critically, we need to know whether it has any bikes to release.  When a bike is docked, we need to retain that information and use it again when `get_bike` is called.

At a future point, `DockingStation` is going to need to manage multiple bikes.  However, at the moment we are only interested in passing our tests.  Let's do the simplest thing possible that will allow the docked bike to be released:

```ruby
class DockingStation

  def get_bike
    @bike
  end

  def dock bike
    @bike = bike
  end
end
```

```sh
$ rspec
```

Great, now we've got *two* failing tests!  Let's take a moment to reflect on what we have done so far.  What is `@bike`?  Why is our original unit test now failing?

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
    bike = subject.get_bike
    expect(bike).to be_working
  end
end
```

Now we can finally create the functionality we expect:
```ruby
class DockingStation

  def get_bike
    fail 'No bikes available' unless @bike
    @bike
  end

  def dock bike
    @bike = bike
  end
end
```

> Notice how we put the error-catching line - which uses `fail` - first in the method. This is a pattern known as a 'guard condition'. By catching errors as the first priority, errors cannot progress further into the program. It's a great pattern.

And we should have the joy of seeing all our unit tests go green and the ability of all our manual feature tests to pass.  Assuming your unit tests are green, make sure you run all your feature tests through IRB to double check!

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

[Back to the Challenge Map](../0_challenge_map.md)
