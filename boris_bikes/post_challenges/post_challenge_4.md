## Post Challenge 4 - Introducing Doubles

[Back to the Challenge Map](../0_challenge_map.md)

Take a look at the unit tests for docking station:

```ruby
require 'docking_station'

describe DockingStation do
  it { is_expected.to respond_to :release_bike }

  it 'releases working bikes' do
    subject.dock Bike.new
    bike = subject.release_bike
    expect(bike).to be_working
  end

  it 'does not release broken bikes' do
    bike = Bike.new
    bike.report_broken
    subject.dock bike
    expect {subject.release_bike}.to raise_error 'No bikes available'
  end

  it { is_expected.to respond_to(:dock).with(1).argument }

  describe 'release_bike' do
    it 'raises an error when there are no bikes available' do
      expect { subject.release_bike }.to raise_error 'No bikes available'
    end
  end

  describe 'dock' do
    it 'raises an error when full' do
      subject.capacity.times { subject.dock Bike.new }
      expect { subject.dock Bike.new }.to raise_error 'Docking station full'
    end
  end
end
```

The purpose of a unit test is to exhaustively test a single component.  In this case `DockingStation`.  But can you spot a potential problem?

Our test is not *isolated*.  It is dependent on another component of the system - `Bike` and therefore could be unexpectedly affected by changes to `Bike`.  We cannot say our unit test is truly a unit test if its outcome is influenced by changes in other components.

So how do we overcome this?  This is where we introduce *doubles*.  A *double* is a temporary, disposable object that we can use as a stand-in for some other real object - like a `Bike` for example.  The difference is, we can precisely define the behaviour of a double on a test-by-test basis to remove any uncertainty that the real object might introduce.

Have a read of the [doubles pill&nbsp;:pill:](../pills/doubles.md) for an introduction to the different types of doubles and a link to RSpec's implementation of them ([Rspec mocks](https://relishapp.com/rspec/rspec-mocks/docs)).

Let's take a look at our `dock` test:

```ruby
describe 'dock' do
  it 'raises an error when full' do
    subject.capacity.times { subject.dock Bike.new }
    expect { subject.dock Bike.new }.to raise_error 'Docking station full'
  end
end
```

We are actually creating 21 instances of `Bike` in this test.  However, the test is not interested in the bikes, just that the docking station is full.  It could be full of pogo-sticks for all we care.  So rather than introduce the dependency on `Bike`, we'll use a double instead:

```ruby
describe 'dock' do
  it 'raises an error when full' do
    subject.capacity.times { subject.dock :bike }
    expect { subject.dock :bike }.to raise_error 'Docking station full'
  end
end
```
Instead of docking an instance of `Bike`, we are simply docking the symbol `:bike` instead.  We are not particularly interested in the symbol `:bike`, it's just something to dock instead of creating a dependency on `Bike`.  We could have docked the string `'bike'` too.  Try both of these approaches.  Discuss the results with your pair partner.  Do you expect the test to pass?  Why?

This mechanism might suffice in the short term, but it's not a very robust solution.  If the docking station needs to interact with methods of a `Bike` object, then clearly a `bike` symbol or string is not going to cut it.  Fortunately, RSpec provides a sophisticated framework for creating test doubles using the method `double`:

```ruby
describe 'dock' do
  it 'raises an error when full' do
    subject.capacity.times { subject.dock double :bike }
    expect { subject.dock double :bike }.to raise_error 'Docking station full'
  end
end
```

### Mocking behaviour
Take a look at the following test.  In order to test that a broken bike is not released, we have to create a bike and then report it as broken:

```ruby
it 'does not release broken bikes' do
  bike = Bike.new
  bike.report_broken
  subject.dock bike
  expect {subject.release_bike}.to raise_error 'No bikes available'
end
```

This is annoying as we're not interested in testing the bike itself, only that the docking station contains a broken bike and doesn't release it.

What we actually want to test is that `DockingStation` does not release a bike when the bike's `broken?` method is 'truthy' (or it's `working?` method is 'falsy' depending on how you've implemented the feature in your DockingStation).  So what we need is a double that returns `true` when `broken?` is called or `false` when `working?` is called.  We can do this using *method stubs*.  Take a look at the following code:

```ruby
it 'does not release broken bikes' do
  bike = double :bike, broken?: true
  subject.dock bike
  expect {subject.release_bike}.to raise_error 'No bikes available'
end
```

The additional argument to `double`, i.e. `broken?: true`, (note, you might also see this written `:broken? => true`) simply tells our double to respond to a `broken?` method and return `true`.

Finally, let's take a look at the last remaining reference to `Bike` in our docking station unit tests:

```ruby
it 'releases working bikes' do
  subject.dock Bike.new
  bike = subject.release_bike
  expect(bike).to be_working
end
```

Bizarrely, although this is a `DockingStation` unit test, our expectation is on `bike`!  Because we wrote the test against the actual `Bike` class, it wasn't immediately obvious that this is a poor test.  However, when we replace it with a double, it becomes more obvious:

```ruby
it 'releases working bikes' do
  subject.dock double :bike, broken?: false
  bike = subject.release_bike
  expect(bike).to be_working
end
```

We've explicitly defined a bike double that returns `false` when `broken?` is called because we used the `broken?` method in our `DockingStation` to test whether a bike can be released.  You may have it the other way around (you might test `working?` instead).  Either way, we will eventually expose a subtle problem.

```
Failures:

  1) DockingStation releases working bikes
     Failure/Error: expect(bike.working?).to be true
       Double :bike received unexpected message :working? with (no args)
     # ./spec/docking_station_spec.rb:9:in `block (2 levels) in <top (required)>'
```

Our test is failing because in our expectation, we are calling a method on our double that is not defined (`working?`).  To pass it, we would have to do define the `working?`` method too, like this:

```
subject.dock double :bike, broken?: false, working?: true
```

But surely this is a ridiculous test?  Now we are testing that our double returns `true` for `working?`.  But of course it does - we've just told it to!

What we really want to test is that if there's a working bike in the docking station, then the same bike gets returned by `release_bike`.  The *feature test* takes care of also testing that the bike that comes out is working.

```ruby
it 'releases working bikes' do
  bike = double :bike, broken?: false
  subject.dock bike
  expect(subject.release_bike).to be bike
end
```

Of course, we are introducing doubles retrospectively and normally we would use doubles from the very start, so issues like this would be less likely to arise.

This particular style of testing - where every dependency is mocked out using doubles is called the 'London' style.  There is another style called the 'Chicago' style.  Research these two styles with your pair partner and discuss each approach.  Which do you prefer?  Why?

[Back to the Challenge Map](../0_challenge_map.md)
