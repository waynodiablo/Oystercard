##Stage 4: Refactoring vs New Features

Our feature test is passing ensuring that we are delivering value to our client.  We've got a unit tests for the Bike and DockingStation classes.  However our DockingStation is very tightly coupled to the Bike class.  It might seem obvious that all a DockingStation ever needs to do is release Bikes, but Ruby programmers pride themselves on programming to interfaces (the way objects behave), not locking an implementation to a particular type of class.  All our feature test requires is that DockingStations provide objects that respond to the 'broken?' method.  Ultimately it doesn't care what the class of the object we are calling it on.  In the future our client might want docking stations to release objects of class MountainBike or Scooter or what have you, and we imagine our end user will continue to want objects that are not broken, or at least to be able to tell if they are broken or not.  

[CONCERN - IS KLASS STUFF BELOW TOO COMPLEX FOR THIS STAGE --> SAVE TO WEEK 2?]

One solution would be to adjust our DockingStation so that we specify what kind of entity to create and release with code like:

```ruby
class DockingStation
  def initialize klass
    @klass = klass
  end
  def release_bike
    klass.new
  end
end
```

and then we'd need to initialise DockingStations like so:

```sh
d = DockingStation.new Bike
```

we get our intended end user functionality

```sh
→ irb
2.1.5 :001 > require './lib/docking_station'
 => true
2.1.5 :002 > require './lib/bike'
 => true
2.1.5 :003 > d = DockingStation.new Bike
 => #<DockingStation:0x007fc21a153770 @klass=Bike>
2.1.5 :004 > d.release_bike
 => #<Bike:0x007fc21a150cf0>
2.1.5 :005 > _.broken?
 => nil

and we've completely de-coupled DockingStation from Bike.  It can be tested independently and we don't need to require Bike in the DockingStation class definition and we

[Contrasting UML Diagrams?]

However this sort of refactoring might be considered premature if we consider other user stories, such as these ones, which imply that DockingStations should have a limited capacity for storing bikes.

```sh
As a maintainer of the system,
So that members of the public are not disappointed,
I'd like docking stations to not release bikes when there are none available.

As a maintainer of the system,
So that members of the public can get usable bikes,
I'd like docking stations to not accept more bikes than their capacity.
```

Whenever we have a full suite of passing tests we have the choice of refactoring our code to better support future change, or to try to implement another feature.  In this case since it seems clear that our Docking Stations are not intended to be dispensers of unlimited supplies of new bikes, that it seems sensible to add another feature rather than refactor in a way that might not make sense once we have implemented some capacity for DockingStations.

In this case let's implement a new feature test to reflect the fact that docking stations can run out of bikes.


```ruby
require 'docking_station'

describe 'member of public accesses bike' do
  it 'and it is not broken' do
    docking_station = DockingStation.new
    bike = docking_station.release_bike
    expect(bike).not_to be_broken
  end
  it 'and there are none available' do
    docking_station = DockingStation.new
    expect { docking_station.release_bike }.to raise_error 'No Bikes Available'
  end
end
```

[IRB OF WHAT WE EXPECT INTERACTION TO BE LIKE???]

Now these two feature tests can't both pass.  Either docking stations will start with an initial bike that can be handed out to end users or they will start empty.  We'll need to make a decision here, perhaps in consultation with the client.  However it seems a reasonable assumption that docking stations will start empty, so let's go with that for the time being.  It implies that we'll need to adjust our first user story to ensure that there is a bike to hand out to the first user.

```ruby
require 'docking_station'

describe 'member of public accesses bike' do
  it 'and it is not broken' do
    docking_station = DockingStation.new
    docking_station.dock Bike.new
    bike = docking_station.release_bike
    expect(bike).not_to be_broken
  end
  it 'and there are none available' do
    docking_station = DockingStation.new
    expect { docking_station.release_bike }.to raise_error 'No Bikes Available'
  end
end
```

It follows that we should now drop down to the unit test level to ensure that our docking station has the necessary dock method to initially receive a bike:

```ruby
require 'docking_station'
describe DockingStation do
  it { expect(subject).to respond_to :release_bike }
  it { expect(subject).to respond_to :dock }
end
```

[SHOW ALL THE SLIPS AND STEPS? INCLUDING RUBOCOP COMPLAINING ABOUT UNUSED ARGUMENTS]

To make the test above pass we'll need code like the following:


```ruby
class DockingStation
  def release_bike
    Bike.new
  end

  def dock bike
    bike
  end
end
```

Now we just have a single failing integration/feature test and so it's tempting again to just go ahead and fix the application code, but what we should really be doing here is adjusting the unit test for our DockingStation so that we have a unit test check of the error being raised when the station is empty.

```ruby
require 'docking_station'

describe DockingStation do
  it { expect(subject).to respond_to :release_bike }
  it { expect { subject.release_bike }.to raise_error 'No Bikes Available' }
  it { expect(subject).to respond_to :dock }
end
```

We should now have a pair of failing tests that give very similar output:

```sh

Failures:

  1) DockingStation should raise Exception with "No Bikes Available"
     Failure/Error: it { expect { subject.release_bike }.to raise_error 'No Bikes Available' }
       expected Exception with "No Bikes Available" but nothing was raised
     # ./spec/docking_station_spec.rb:5:in `block (2 levels) in <top (required)>'

  2) member of public accesses bike and there are none available
     Failure/Error: expect { docking_station.release_bike }.to raise_error 'No Bikes Available'
       expected Exception with "No Bikes Available" but nothing was raised
     # ./spec/feature/public_bike_access_spec.rb:13:in `block (2 levels) in <top (required)>'

Finished in 0.00574 seconds (files took 0.18372 seconds to load)
6 examples, 2 failures
```

One is a failing unit test and the other is a failing feature test.  Now to change some application code.  We know we may want to store multiple bikes, but let's do the simplest thing - just store one bike:

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

Rubocop gets a bit antsy with methods like this that are just variations on getters and setters (MORE EXPLANATION on what getters and setters are?).  There is a simple fix that the RuboCop author suggests: https://github.com/bbatsov/rubocop/issues/251 ?

```
class DockingStation
  attr_accessor :bike
  alias_method :release_bike, :bike
  alias_method :dock, :bike=
end
```

However we find ourselves backing out of at least partly in order to throw an error when we have no bike.

```
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

It might seem trivial, but what we've done here is model a docking station that can accept a single bike.  We know that they'll need to store more bikes in future, but particularly when learning it is highly instructive to work carefully through much simpler versions of a system.  Also surprisingly even for experts it's often a great idea to play with super-simplified versions of a system, before gradually increasing the complexity level.  It tends to be easier to make progress if you build on a working simple base.


:running_shirt_with_sash: ATHLETIC WAYPOINT - try re-creating the code so far from scratch without looking at the tutorial.
