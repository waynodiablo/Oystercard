## Stage 5: Giving Docking Stations Limited Capacities

Given this next user story:

```
As a maintainer of the system,
So that members of the public can get usable bikes,
I'd like docking stations to not accept more bikes than their capacity.
```

It follows that we should prevent more than one bike being docked, rather than what we are currently doing which is that each time we dock a new bike, any existing bike is being discarded.  We might also consider moving towards allowing more than one bike to be stored.  Although that's an assumption.  Does the client want docking stations that store just 1 bike or should they store 20, 50, 100?  This would be a good time to check with the client what the storage capacity requirements are for docking station.  Perhaps they weren't discussed in the initial client meeting.  

Say that we couldn't contact the client immediately, what should we do?  We've got a user story that indicates that docking stations should not accept more than their capacity.  The way that we've set up the DockingStation instance variables assumes a capacity of 1.  In order to do the least amount of work to support the user story, let's create a feature test that raises an error when trying to dock a bike in a station that already has a bike docked.  This corresponds to an initial capacity of 1.  Let's imagine that we've sent an email to our client asking for clarification but in the mean time let's push on with our minimal interpretation of a capacity of 1.

[AFTER THIS CYCLE COME BACK WITH INFO FROM CLIENT ON USER STORY SAYING MOST DOCKING STATIONS HAVE A CAPACITY OF 20, BUT THAT SOMETIMES THEY ARE BIGGER --> FIRST IMPLEMENT THE 20 AND THEN MOVE ON TO ANOTHER STORY ABOUT SUPPORTING STATIONS WITH HIGHER CAPACITY]


[TODO: note that we break various of our own guides in this section, e.g. two expects in an it block, locking DockingStation test to Bike class]

[TODO: feels weird that we start the fullness component passing in the 20 with the default value - get the fullness functionality first - then worry about wanting to pass in default values and test drive that separately, i.e. don't make two changes to the interface at the same time to avoid complexity explosion]

If the bike is the only thing we've got, our system isn't going to be very functional. At the very least we'll need docking stations. Let's think about the functionality we need for the docking station.

A docking station must be able to accept a bike and to release it. It should also have some capacity limit, because we shouldn't be able to put an infinite number of bikes into it. If a bike is broken, the docking station should not release it (or, rather, it should only release it to the van but we haven't got a van yet). Finally, a station must know how many bikes it has.

Let's start with the most basic functionality: accepting the bikes. As usual, we need to start with the test describing what's going on. Put your test in `spec/docking_station_spec.rb`.

````ruby
describe DockingStation do

  it 'should accept a bike' do
    bike = Bike.new
    station = DockingStation.new
    # we expect the station to have 0 bikes
    expect(station.bike_count).to eq(0)
    # let's dock a bike into the station
    station.dock(bike)
    # now we expect the station to have 1 bike
    expect(station.bike_count).to eq(1)
  end

end
````

Why did we choose to name the method that puts a bike into the station `dock()`. Naming things is one of [two hardest problems in Computer Science](http://martinfowler.com/bliki/TwoHardThings.html). We could have chosen a different name but this one seems good enough.

Now let's run it. We'll get an error straight away.

````ruby
docking_station_spec.rb:1:in `<top (required)>': uninitialized constant DockingStation (NameError)
````

Unless the reason for this error is immediately obvious, stop and think for a second about why it happened. Why would uninitialised constant (whatever this means) be a problem? Why would Ruby expect DockingStation to be initialised? Which line in the file raises the error? Why would line one be a problem?

It looks like we are referencing the class DockingStation on line one but since we never defined it, Ruby has no idea what DockingStation is. This is obviously a problem because in our test we're instantiating the class and calling its methods. So Ruby definitely needs it. However, it doesn't exist yet. Let's create it.

Create an empty class in lib/docking_station.rb

````ruby
class DockingStation
end
````

If you run the test now, you'll get the same an error again. Again, unless it's immediately obvious, think about what's going on. We created the class but Ruby can't link the test to the class definition because we never "required" the file. Remember, we had exactly the same problem with the Bike class? Fix the problem by requiring the class file just like we've done it in the Bike test (I'm omitting the exact line of code as a tiny exercise for you).

If you've done it correctly, you should now see a test failure

````
1) DockingStation should accept a bike
     Failure/Error: expect(station.bike_count).to eq(0)
     NoMethodError:
       undefined method `bike_count' for #<DockingStation:0x007fcab45c3678>
     # ./spec/docking_station_spec.rb:9:in `block (2 levels) in <top (required)>'
````

Why do we get "undefined method 'bike_count'"? Because we haven't written it. Create an empty bike_count() method in the DockingStation class. Don't put any implementation because the test isn't asking us to do it yet. Let the test drive your code.

If your method is empty, the next error you should see is

````
1) DockingStation should accept a bike
     Failure/Error: expect(station.bike_count).to eq(0)

       expected: 0
            got: nil

       (compared using ==)
     # ./spec/docking_station_spec.rb:9:in `block (2 levels) in <top (required)>'
````

Can you explain why this is happening? An empty method always return nil, whereas we expect the bike_count to be 0 in our tests. Let's update the method to return 0.

This may sound unnecessary. Why would you make the method return 0 if it's an obviously incorrect implementation that will be changed before the next commit? The reason we do this is that this approach forces us to write the absolute minimum necessary to make the test pass. It also ensures that we don't write the code that's not covered by the tests. Let the tests drive your code.

In fact, please forgive me for digressing, I have yet to meet a developer who would use TDD really well, writing good tests and letting them to drive the code, who would be a bad coder. Quite the opposite, I've seen many programmers who ignored tests because they were "slowing them down" only to produce a piece of unmaintainable code that would be a pain to work with.

You can argue that it's possible to take the tests too far, testing absolutely every possible scenario and not writing a single line without a test telling you to do it. Use your best judgement. If it were possible to tell exactly when and how to write tests, we'd have computers writing them for us. TDD isn't a silver bullet but it's a very powerful weapon in your arsenal. Let the tests drive your code. Trust the tests.

So, our DockingStation isn't terribly useful right now.

````ruby
class DockingStation

  def bike_count
    0
  end

end
````

However, it gets us to the next error.

````
  1) DockingStation should accept a bike
     Failure/Error: station.dock(bike)
     NoMethodError:
       undefined method `dock' for #<DockingStation:0x007fd369c95bc8>
     # ./spec/docking_station_spec.rb:11:in `block (2 levels) in <top (required)>'
````

By now you know that you need to create the method `dock()` and rerun the test. Don't forget that the method `dock()` takes an argument, a bike. After you do it, you'll get to the error that finally forces you to write some real code:

````
  1) DockingStation should accept a bike
     Failure/Error: expect(station.bike_count).to eq(1)

       expected: 1
            got: 0

       (compared using ==)
     # ./spec/docking_station_spec.rb:13:in `block (2 levels) in <top (required)>'
````

Now we can't just make the method return 1 to get rid of this error because that would make the test break on a line above. So we need to write some real code.

Our docking station needs to know how many bikes it's got. In principle, we could get away with creating a counter that just increments every time a bike is docked without actually storing a reference to the bike. The test would still pass. However, there's a difference between making a test return a constant instead of a real implementation and writing an obviously incorrect implementation that we'll need to change later. In this particular case, I choose to actually store the bike inside a station instead of just pretending to do it.

We need to retain a reference to the bike inside the station. The best place for this would be an instance variable. Let's create an array of bikes and return its size and the number of bikes in the station.

````ruby
class DockingStation

  def initialize
    @bikes = []
  end

  def bike_count
    @bikes.count
  end

  def dock(bike)
  end

end
````

Let's now rerun the test to makes sure the error is still the same. Since the array is empty, the `bike_count()` method should return 0. The reason we're running the test now to see the same error is to make sure that we didn't introduce any other problems along the way.

However, to make this error go away, we need to write a real implementation of the `dock()` method.

````ruby
def dock(bike)
  @bikes << bike
end
````

The << is called a shovel operator. [It puts an element in the array](http://ruby-doc.org/core-2.0.0/Array.html#method-i-3C-3C). Now our bike_count method will return the correct value after we dock a bike. All tests should pass.

Now that our tests pass it's a good time to check the code in.

If our docking station can accept bikes, it will need to release them at some point. Let's write a test to release a bike.

````ruby
it 'should release a bike' do
  station.dock(bike)
  station.release(bike)
  expect(station.bike_count).to eq(0)
end
````

To get rid of code repetition, I also put a couple `let()` statements at the very beginning of the "describe" block, just like we've done earlier in the Bike spec.

````ruby
let(:bike) { Bike.new }
let(:station) { DockingStation.new }
````

Run rspec, create an empty `release()` method, run rspec again. Now the reason for the failure is that the method doesn't work. Let's implement it.

````ruby
def release(bike)
  @bikes.delete(bike)
end
````

Now all tests should pass. Great news: we can now dock bikes and release them! Let's check in the code

Let's now make our docking stations more realistic. Right now you can dock any number of bikes in there and it'll be ok as long as you have available memory on your machine (that'll be many, many millions of bikes). Let's introduce some limit on the capacity, set when the station is being initialised. As always, first comes the example.

````ruby
it 'should know when it\'s full' do
  expect(station).not_to be_full
  20.times { station.dock(Bike.new) }
  expect(station).to be_full
end
````

Why 20? Let's pass the capacity as a a parameter to the initialiser.

````ruby
let(:station) { DockingStation.new(capacity: 20) }
````

So we're initialising the station as the station that has the capacity of 20 and we're filling it with 20 bikes. We expect it to be full after that. Run the test (it will complain about the wrong number of arguments for the initialiser). Let's fix the problem the test has uncovered.

````ruby
def initialize(options = {})
  @capacity = options.fetch(:capacity, DEFAULT_CAPACITY)
  @bikes = []
end
````

Let's stop and discuss this code. The first question is why pass the capacity as a key-value pair of an options hash. We could have passed it as the first argument:

````ruby
def initialize(capacity=DEFAULT_CAPACITY)
````

However, then we'd have to use it like this:

````ruby
DockingStation.new(20)
````

The problem with this code is that it doesn't communicate what 20 is. Is it the capacity? Do we want to create 20 docking stations in one go? Is it the number of bikes a station should be initialised with? Our code must communicate the intent well.

The second question is what this line does:

````ruby
@capacity = options.fetch(:capacity, DEFAULT_CAPACITY)
````

This is a common pattern for passing optional arguments into Ruby. The [Hash.fetch method](http://www.ruby-doc.org/core-1.9.3/Hash.html#method-i-fetch) retrieves the value for the given key (`options[:capacity]` in this case) and if the key is not found, it returns the second argument (`DEFAULT_CAPACITY`). So if the capacity is passed, it's used, otherwise the default one will be assigned.

Finally, you'll need to define the default capacity at the top of the `DockingStation` class.

````ruby
class DockingStation
  DEFAULT_CAPACITY = 10
````

There's a different way of achieving the same effect: [named arguments in Ruby 2.0](http://brainspec.com/blog/2012/10/08/keyword-arguments-ruby-2-0/). However, since this is a relatively new feature, you're likely to see the pattern we're using in the real world.

Let's run rspec again...

Undefined method `full?()`. That's because we don't have it. Create it but leave it empty. Next error:

````ruby
 1) DockingStation should know when it's full
     Failure/Error: expect(station).to be_full
       expected full? to return true, got nil
````

Now let's implement it. What does it mean for a station to be full? To have the number of bikes to be equal to the capacity.

````ruby
def full?
  bike_count == @capacity
end
````

Why are we using `bike_count` as opposed to `@bikes.count`? Doing so would lead to repetition. If we have a method for giving us the bike count, we must use it.

Do you think the tests would pass now? Make a prediction, then run them. If they do, it's a good time to commit the code, and to switch Driver/Navigator Roles&nbsp;:twisted_rightwards_arrows:.

However, what happens if we try to dock the bike into a station that's full?

````ruby
it 'should not accept a bike if it\'s full' do
  20.times { station.dock(Bike.new) }
  expect(lambda { station.dock(bike) }).to raise_error(RuntimeError, 'Station is full')
end
````

From now on I'll start skipping the test failures because you've seen quite of few of them now.

This test expects that docking a bike into a station should not [raise an error](https://www.relishapp.com/rspec/rspec-expectations/v/3-1/docs/built-in-matchers/raise-error-matcher). It will fail because this functionality isn't implemented yet. Let's update the `dock()` method.

````ruby
def dock(bike)
  # if the capacity is reached, raise an exception
  raise "Station is full" if full?
  @bikes << bike
end
````

Now our tests should pass but we have a long line of code in our tests that is repeated twice.

````ruby
20.times { station.dock(Bike.new) }
````

Let's refactor the code by extracting the method to a helper method (put it inside the `describe DockingStation` block), and referring to the constant in the DockingStation.

````ruby
def fill_station(station)
  20.times { station.dock(Bike.new) }
end
````

This helps make our test a little more readable.  Note that we can also drop the [lambda](pills/lambdas.md) :pill: keyword from the test syntax so that our test now looks like this.

````ruby
it 'should not accept a bike if it\'s full' do
  fill_station station
  expect{ station.dock(bike) }.to raise_error(RuntimeError, 'Station is full')
end
````

If everything passes, it's a good time to check everything in, and to switch Driver/Navigator Roles&nbsp;:twisted_rightwards_arrows:.

When you need to get a bike from a station, you need to know what bikes are available. Some bikes can be broken and they shouldn't be available for rental. Let's create a method that will return the list of bikes that are available.

````ruby
it 'should provide the list of available bikes' do
  working_bike, broken_bike = Bike.new, Bike.new
  broken_bike.break!
  station.dock(working_bike)
  station.dock(broken_bike)
  expect(station.available_bikes).to eq([working_bike])
end
````

The implementation is fairly simple.

````ruby
def available_bikes
  @bikes.reject {|bike| bike.broken? }
end
````

Now that the tests pass, it's time to check the code in and of course to switch Driver/Navigator Roles&nbsp;:twisted_rightwards_arrows:.

Our station is mostly done but there are a few more things, listed in the Exercises section below for you to finish.
