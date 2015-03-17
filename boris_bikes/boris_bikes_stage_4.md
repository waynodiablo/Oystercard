##Stage 4: Refactoring vs New Features

***Please note, as with all Makers Academy materials, there may be subtle errors in the following materials.  Please try to approach those as challenges on which to polish your debugging skills - pull requests always welcome.***

Our feature test is passing ensuring that we are delivering value to our client.  We've got a unit tests for the Bike and DockingStation classes.  However our DockingStation is very tightly coupled to the Bike class.  It might seem obvious that all a DockingStation ever needs to do is release Bikes, but Ruby programmers pride themselves on programming to interfaces (the way objects behave), not locking an implementation to a particular type of class.  All our feature test requires is that DockingStations provide objects that respond to the 'broken?' method.  Ultimately it doesn't care what the class of the object we are calling it on.  In the future our client might want docking stations to release objects of class MountainBike or Scooter or what have you, and we imagine our end user will continue to want objects that are not broken, or at least to be able to tell if they are broken or not.  You can see an example of how we might de-couple our objects in the [dependency injection pill&nbsp;:pill:](../pills/dependency_injection.md).

However this sort of refactoring might be considered premature in that we may naturally evolve our code away from this unpleasant tightly coupled state of affairs.  So rather than rushing to refactor, let's consider some other user stories, which imply that DockingStations should have a limited capacity for storing bikes.

```sh
As a maintainer of the system,
So that members of the public are not disappointed,
I'd like docking stations to not release bikes when there are none available.

As a maintainer of the system,
So that members of the public can get usable bikes,
I'd like docking stations to not accept more bikes than their capacity.
```

Whenever we have a full suite of passing tests we have the choice of refactoring our code to better support future change, or to try to implement another feature.  In this case since it seems clear that our Docking Stations are not intended to be dispensers of unlimited supplies of new bikes.  As a consequence we should perhaps add another feature rather than refactoring in a way that might not make sense once we have implemented some capacity for DockingStations.

Let's imagine the IRB interaction for the story relating to no bikes being available. Something like this perhaps:

```sh
→ irb
2.1.5 :001 > require './lib/docking_station'
 => true
2.1.5 :002 > docking_station = DockingStation.new
 => #<DockingStation:0x007fe022230258 ...>
2.1.5 :003 > docking_station.release_bike
RuntimeError: No Bikes Available
	.... stacktrace omitted ....
```

Can you imagine the corresponding feature test?  Note that moving forward we'll fill in fewer and fewer of the gaps.  As you get stuck you'll need to use your problem solving skills to work out what is going wrong and to get you back on track.  Try not to get frustrated - the key is to stay calm and work with your pair partner to figure out the logic of what is going on.  Not sure how to write the corresponding feature test?  Let's get you started:

```ruby
require 'docking_station'

feature 'member of public accesses bike' do
  scenario 'docking station releases a bike that is not broken' do
    docking_station = DockingStation.new
    bike = docking_station.release_bike
    expect(bike).not_to be_broken
  end
  scenario 'docking station unable to release as none available' do
    docking_station = DockingStation.new
    expect { docking_station.release_bike }.to raise_error 'No Bikes Available'
  end
end
```

Whatever we do these two feature tests will not both pass.  Either docking stations will start with an initial bike (or bikes) that can be handed out to end users or they will start empty.  We'll need to make a decision here, perhaps in consultation with the client.  However it seems a reasonable assumption that docking stations will start empty, so let's go with that for the time being.  It implies that we'll need to adjust our first user story to ensure that there is a bike to hand out to the first user.

```ruby
require 'docking_station'

feature 'member of public accesses bike' do
  scenario 'docking station releases a bike that is not broken' do
    docking_station = DockingStation.new
    docking_station.dock Bike.new
    bike = docking_station.release_bike
    expect(bike).not_to be_broken
  end
  scenario 'docking station unable to release as none available' do
    docking_station = DockingStation.new
    expect { docking_station.release_bike }.to raise_error 'No Bikes Available'
  end
end
```

It follows that we should now drop down to the unit-test level to ensure that our docking station has the necessary dock method to initially receive a bike:

```ruby
require 'docking_station'
describe DockingStation do
  # existing test omitted for brevity
  it { is_expected.to respond_to :dock }
end
```

However this isn't going to help our acceptance test too much, since we are calling dock with an argument.  We'll need a more rigorous test, which arguably should replace the above:

```ruby
require 'docking_station'
describe DockingStation do
  # existing test omitted for brevity
  it 'can dock a bike' do
    subject.dock :bike
  end
end
```

Note that the above test does not even have an expect statement.  Not ideal, but it is checking that we can call the dock method with an argument.  Here we are using the symbol :bike as a placeholder.  We could use a double, but we currently don't need a standin that does anything at all, so a symbol is sufficient.  In this case either a double or a symbol keeps our docking station unit tests nicely isolated from the Bike class.

We might think that the following code would pass this test:


```ruby
class DockingStation
  def release_bike
    Bike.new
  end

  def dock bike
  end
end
```

And it would if not for RuboCop.  RuboCop won't less us have unused arguments in a method so we'll have to use bike in the dock method to satisfy RuboCop.  In doing so let's first update our test to use an expect statement and check the return value:

```ruby
require 'docking_station'
describe DockingStation do
  # existing test omitted for brevity
  it 'can dock a bike' do
    expect(subject.dock :bike).to eq :bike
  end
end
```

Ironically we'd have to run 'rspec' raw to see this fail in the way we want:

```sh
→ rspec

Bike
  should respond to #broken?
  when created
    should not be broken

DockingStation
  releases bikes that are not broken
  can dock a bike (FAILED - 1)

member of public accesses bike
  docking station releases a bike that is not broken
  docking station unable to release as none available (FAILED - 2)

Failures:

  1) DockingStation can dock a bike
     Failure/Error: expect(subject.dock :bike).to eq :bike

       expected: :bike
            got: nil

       (compared using ==)
     # ./spec/docking_station_spec.rb:9:in `block (2 levels) in <top (required)>'
```

but please stick with rake and RuboCop!  

Having double checked we got the correct fail, we can update the dock method to return the bike argument and thus satisfy both RuboCop and RSpec.  Now we have just a single failing integration/feature test:

```sh
1) member of public accesses bike docking station unable to release as none available
   Failure/Error: expect { docking_station.release_bike }.to raise_error 'No Bikes Available'
     expected Exception with "No Bikes Available" but nothing was raised
   # ./spec/feature/public_bike_access_spec.rb:13:in `block (2 levels) in <top (required)>'
```

And again it's tempting to just go ahead and fix the application code, but what we should really be doing here is adjusting the unit test for our DockingStation so that we have a unit test check of the error being raised when the station is empty.

```ruby
require 'docking_station'

describe DockingStation do
  # other tests omitted for brevity
  it 'raises error when no bikes available' do
    expect { subject.release_bike }.to raise_error 'No Bikes Available'
  end
end
```

Again we should now have a pair of failing tests that give very similar output:

```sh

Failures:

  1) DockingStation raises error when no bikes available
      Failure/Error: expect { subject.release_bike }.to raise_error 'No Bikes Available'
        expected Exception with "No Bikes Available" but nothing was raised
      # ./spec/docking_station_spec.rb:7:in `block (2 levels) in <top (required)>'

  2) member of public accesses bike and there are none available
     Failure/Error: expect { docking_station.release_bike }.to raise_error 'No Bikes Available'
       expected Exception with "No Bikes Available" but nothing was raised
     # ./spec/feature/public_bike_access_spec.rb:13:in `block (2 levels) in <top (required)>'

Finished in 0.00574 seconds (files took 0.18372 seconds to load)
6 examples, 2 failures
```

One is a failing unit test and the other is a failing feature test.  Now finally we can change some application code.  We know we may want to store multiple bikes, but let's do the simplest thing first - just store one bike:

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

RuboCop gets a bit antsy with methods like this that are just variations on getters and setters (see the [getters and setters pill&nbsp;](../pills/getters_and_setters.md)).  There is a simple fix that the RuboCop author suggests: https://github.com/bbatsov/rubocop/issues/251

```ruby
class DockingStation
  attr_accessor :bike
  alias_method :release_bike, :bike
  alias_method :dock, :bike=
end
```

However this causes an additional error in the docking station spec:

```sh
1) DockingStation releases bikes that are not broken
   Failure/Error: expect(bike).not_to be_broken
     expected  to respond to `broken?`
   # ./spec/docking_station_spec.rb:6:in `block (2 levels) in <top (required)>'
```

By default our bike instance variable in DockingStation is nil.  All Ruby instance variables are initially nil by default.  In order to have this DockingStation test pass we are going to have to break out a proper double.  

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
    fail 'No Bikes Available' unless @bike
    @bike
  end
end
```

And now we should have the joy of seeing both our unit test and feature test both go green at the same time.

It might seem trivial, but what we've done here is model a docking station that can accept a single bike.  We know that we'll probably need to store more bikes in future, but particularly when learning it is highly instructive to work carefully through much simpler versions of a system.  Also surprisingly even for experts it's often a great idea to play with super-simplified versions of a system, before gradually increasing the complexity level.  It tends to be easier to make progress if you build on a working simple base.

Furthermore, you never know when your customer is going to come back to you and say - actually we don't need that extra functionality.  Always build the simplest possible thing and get that working as a baseline. Allow your progress through a set of user stories and your ongoing interaction with the customer drive the addition of functionality to your system at the slowest possible rate.

:running_shirt_with_sash: ATHLETIC WAYPOINT - try re-creating the code so far from scratch without looking at the tutorial. Here is a reminder of the the User Stories you have completed now, for your reference:

```sh
As a member of the public
So that I can get across town
I"d like a docking station to release a bike that is not broken

As a maintainer of the system,
So that members of the public are not disappointed,
I"d like docking stations to not release bikes when there are none available.
```

Then time to move on to [Stage 5](boris_bikes_stage_5.md)!
