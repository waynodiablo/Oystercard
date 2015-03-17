## Stage 6:  Dealing with Broken Bikes

***As with all Makers Academy materials, there may be subtle errors in the following materials.  Please try to approach those as challenges on which to polish your debugging skills - pull requests always welcome.***

There are two more user stories that are specific to just stations and bikes, but have to deal with broken bikes.

```
As a maintainer of the system,
So that members of the public can get usable bikes,
I'd like docking stations to only release working bikes.

As a maintainer of the system,
So that members of the public can get usable bikes,
I'd like docking stations to accept returning bikes (broken or not).
```

Let's start with one of these and create a feature test that will ultimately lead us to making the bikes broken? method work properly ...

```ruby
feature 'member of public accesses bike' do
  # other tests omitted for brevity
  scenario 'docking station will not include any broken bikes in those available' do
    docking_station = DockingStation.new
    broken_bike = Bike.new
    broken_bike.break
    docking_station.dock bike
    expect { docking_station.release_bike }.to raise_error 'No Bikes Available'
  end
end

```

We should be getting used to the format of these test failures now :-)

```sh
1) member of public accesses bike and broken bikes are not considered available
   Failure/Error: docking_station.dock Bike.new.break
   NoMethodError:
     undefined method `break' for #<Bike:0x007ffe611a1c08>
   # ./spec/feature/public_bike_access_spec.rb:19:in `block (2 levels) in <top (required)>'
```

Again this is our feature test failing.  Naturally we'll want to create a unit-test for the missing low level functionality, that will go in our bike_spec.rb file.

````ruby
it 'can break' do
  subject.break
  expect(subject).to be_broken
end
````

We now have another pair of failing tests.  A failing feature test and a failing unit test.  Let's see if we can make them pass.

As always, let's ensure we do the absolute minimum to make our code work.

````ruby
class Bike
  def broken?
  end

  def break
  end
end
````

_Will the tests pass this time? If not, will the error be different? If yes, what will it be?_

```sh
Failures:

  1) Bike can break
     Failure/Error: expect(subject).to be_broken
       expected `#<Bike:0x007fc534063410>.broken?` to return true, got nil
     # ./spec/bike_spec.rb:9:in `block (2 levels) in <top (required)>'

  2) member of public accesses bike and broken bikes are not considered available
     Failure/Error: expect { docking_station.release_bike }.to raise_error 'No Bikes Available'
       expected Exception with "No Bikes Available" but nothing was raised
     # ./spec/feature/public_bike_access_spec.rb:20:in `block (2 levels) in <top (required)>'

```

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

Now our bike's unit tests will all pass, but our feature test is still failing.  Nothing is stopping the docking station from releasing broken bikes.  Again we might be tempted to get straight in and fix code but note that it's a feature test that's failing, so we should respond by creating another unit test; this time for the docking station.  However we have a quandry, we need to write a unit test that will rely on a bike being in a particular state, i.e. broken.  We might be tempted to write a docking station unit test like so:

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

Our feature test looks like is use some attention.  Check out public_bike_access_spec.rb:

```ruby
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
  scenario 'docking station will not include any broken bikes in those available' do
    docking_station = DockingStation.new
    broken_bike = Bike.new
    broken_bike.break
    docking_station.dock broken_bike
    expect { docking_station.release_bike }.to raise_error 'No Bikes Available'
  end
end
```

We're declaring DockingStations over and over.  We could make this feature test 'describe' DockingStation, but it's a feature (and in our case an integration) test that is testing both Bike and DockingStation so let's use an alternative.  A 'let' statement:

```ruby
feature 'member of public accesses bike' do
  let(:docking_station) { DockingStation.new }
  scenario 'docking station releases a bike that is not broken' do
    docking_station.dock Bike.new
    bike = docking_station.release_bike
    expect(bike).not_to be_broken
  end
  scenario 'docking station unable to release as none available' do
    expect { docking_station.release_bike }.to raise_error 'No Bikes Available'
  end
  scenario 'docking station will not include any broken bikes in those available' do
    broken_bike = Bike.new
    broken_bike.break
    docking_station.dock broken_bike
    expect { docking_station.release_bike }.to raise_error 'No Bikes Available'
  end
end
```

Notice how we've replaced three lines of identical code with a single let statement.  Each programmer has their own rule of thumb, but something being repeated three times is good time to consider DRYing out your code.  Although remember that every time you DRY out code you are introducing a dependency that may catch you out later.  It's important to consider if the set of identical elements you are consolidating may need to vary at some point in the future ...

Every time you extract a commonality you are adding a dependency.  DRYing out your code is very important, but developing an intuition for just when to do it is also critical.

:running_shirt_with_sash: ATHLETIC WAYPOINT - try re-creating the code so far from scratch without looking at the tutorial.

**Now all our examples pass and we've refactored, a perfect time to commit our changes. Push them to Github (:pill: [Version Control with Git](https://github.com/makersacademy/course/blob/master/pills/git.md)), and this can also be a good time switch Driver/Navigator Roles again&nbsp;:twisted_rightwards_arrows: if someones been driving for too long.
**

Time to move on to [Stage 7](boris_bikes_stage_7.md)!
