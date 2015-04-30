## Stage 6.5 - Doubles

Take a look at the unit tests for docking station:

```ruby
require 'docking_station'

describe DockingStation do
  it { is_expected.to respond_to :release_bike }

  it 'releases working bikes' do
    subject.dock Bike.new
    bike = subject.release_bike
    expect(bike.working?).to be true
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
      capacity = DockingStation::DEFAULT_CAPACITY
      capacity.times { subject.dock Bike.new }
      expect { subject.dock Bike.new }.to raise_error 'Docking station full'
    end
  end
end
```

The purpose of a unit test is to exhaustively test a single component.  In this case `DockingStation`.  But can you spot a potential problem?

Our test is not *isolated*.  It is dependent on another component on the system - `Bike` and therefore could be affected by changes is `Bike`.  We cannot say our unit test is truly a unit test if it's outcome is influenced by changes in other components.

So how do we overcome this?  This is where we introduce *doubles*.  A *double* is a temporary, disposable object that we can use as a stand-in for some other real object - like a `Bike` for example.  The difference is we can precisely define the behaviour of a double on a test-by-test basis to remove any uncertainty.

Have a read of the [doubles pill&nbsp;:pill:](../pills/doubles.md) for an introduction to the different types of doubles and a link to RSpec's implementation of them ([Rspec mocks](https://relishapp.com/rspec/rspec-mocks/docs)).

Let's take a look at our `dock` test:
```ruby
describe 'dock' do
  it 'raises an error when full' do
    capacity = DockingStation::DEFAULT_CAPACITY
    capacity.times { subject.dock Bike.new }
    expect { subject.dock Bike.new }.to raise_error 'Docking station full'
  end
end
```
We are actually creating 21 instances of `Bike` in this test.  However, the test is not interested in the bikes, just that the docking station is full.  It could be full of pogo-sticks for all we care.  So rather than introduce the dependency on `Bike`, we'll use a double instead:

```ruby
describe 'dock' do
  it 'raises an error when full' do
    capacity = DockingStation::DEFAULT_CAPACITY
    capacity.times { subject.dock double :bike }
    expect { subject.dock double :bike }.to raise_error 'Docking station full'
  end
end
```

See how we are using `double :bike` here.  `double` is a method provided by Rspec mocks that simply creates a dummy object called ':bike'.  Nothing more.  In fact we could have passed any object; a symbol: `subject.dock :bike`, or a string: `subject.dock 'bike'` for example.  Try both of these approaches.  Discuss the results with your pair partner.  Do you expect the test to pass?  Why?

Reading the tests though, it isn't immediately obvious that `:bike` or `'bike'` is a stand-in and not the intended input to the `dock` method.  By using doubles, we make it clear that the object is a mock.

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

What we actually want to test is that `DockingStation` does not release a bike when the bike's `broken?` method is 'truthy' (or it's `working?` method is 'falsy' depending on how you've implemented the feature in your DockingStation).  So what we need is an object that returns `true` when `broken?` is called or `false` when `working?` is called.  We can do this using *method stubs*.  Take a look at the following code:
```ruby
it 'does not release broken bikes' do
  bike = double :bike, broken?: true
  subject.dock bike
  expect {subject.release_bike}.to raise_error 'No bikes available'
end
```
The additional argument to `double`, i.e. `broken?: true`, (note, you might also see this written `:broken? => true`) simply tells our double to respond to the `broken?` method and return `true`.

Finally, let's take a look at the last remaining reference to `Bike` in our docking station unit tests:

```ruby
it 'releases working bikes' do
  subject.dock Bike.new
  bike = subject.release_bike
  expect(bike.working?).to be true
end
```
Bizarrely, although this is a `DockingStation` unit test, our expectation is on `bike`!  Because we wrote the test against the actual `Bike` class, it wasn't immediately obvious that this is a poor test.  However, when we replace it with a double, it becomes more obvious:

```ruby
it 'releases working bikes' do
  subject.dock double :bike, broken?: false
  bike = subject.release_bike
  expect(bike.working?).to be true
end
```
We've explicitly defined a double to return `false` when `broken?` is called because we use the `broken?` method in our `DockingStation` to test whether a bike can be released.  You may have it the other way around.  However, this way around exposes a subtle problem.
```
Failures:

  1) DockingStation releases working bikes
     Failure/Error: expect(bike.working?).to be true
       Double :bike received unexpected message :working? with (no args)
     # ./spec/docking_station_spec.rb:9:in `block (2 levels) in <top (required)>'
```
Our test is failing because we are calling a method on our double that is not defined.  But surely this is a ridiculous test?  To pass it, we would have to do this:
```
subject.dock double :bike, broken?: false, working?: true
```
So now we are testing that our double returns `true` for `working?`.  But of course it does - we've just told it to!

What we really want to test is that if there's a working bike in the docking station, then it gets returned.  The *feature test* takes care of testing that the bike that comes out is working.
```ruby
it 'releases working bikes' do
  bike = double :bike, broken?: false
  subject.dock bike
  expect(subject.release_bike).to be bike
end
```


Of course, we are introducing doubles retrospectively and normally we would use doubles from the very start, so issues like this would be less likely to arise.

This particular style of testing - where every dependency is mocked out using doubles is called the 'London' style.  There is another style called the 'Chicago' style.  Research these two styles with your pair partner and discuss each approach.  Which do you prefer?  Why?
