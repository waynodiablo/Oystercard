# Isolating Tests with Doubles

[Back to the Challenge Map](0_challenge_map.md)

Our system can now do pretty much everything our client wants. However, our Unit Tests are not **isolated**. If we mess something up in the `Bike` class, all our tests for `DockingStation` will fail. We might spend hours looking for a problem we think resides within `docking_station.rb`, when in fact it's located in `bike.rb`.

We can use a dummy object, a **double**, Unit Tests that interact with other classes. We can define them to act predictably. They will not be affected by bugs that might arise in the classes they're 'standing in' for. You could think of them as 'stunt doubles' for the actual classes they represent.

In this challenge, you will **isolate** your Unit Tests by using **doubles**.

**Your tests will be failing on completion of this challenge. Proceed to the next challenge regardless.**

### Challenge Setup

Here is a _non-isolated_ test for `DockingStation` that relies on `Bike`:

```ruby
# in docking_station_spec.rb
it 'releases working bikes' do
  # what if this line fails because of
  # a syntax error in our Bike class?
  # We need a way to remove this test's
  # dependency on Bike.
  subject.dock Bike.new
  bike = subject.release_bike
  expect(bike).to be_working
end
```

Realistically, it doesn't matter _what_ object we pass to `dock`, as our `DockingStation` instance will happily store anything:

```ruby
it 'releases working bikes' do
  # let's substitute our Bike.new
  # for a String.new
  subject.dock String.new("I'm not a bike!")
  # no error yet: and no problem when
  # we release the 'bike': we just
  # get the string we made
  bike = subject.release_bike
  # a problem here: strings don't
  # know how to respond_to working?
  # (we'll deal with that in the next
  # challenge: mocking behaviour).
  expect(bike).to be_working
end
```

RSpec has a `double` object which works just like the string above:

```ruby
it 'releases working bikes' do
  # let's substitute our Bike.new
  # for a double
  subject.dock double(:bike)
  # no error yet: and no problem when
  # we release the 'bike': we just
  # get the double we made
  bike = subject.release_bike
  # a problem here: this double doesn't
  # know how to respond_to working?
  # (we'll deal with that in the next
  # challenge: mocking behaviour).
  expect(bike).to be_working
end
```

In the next challenge, we'll figure out how to get this test passing (i.e. how to tell a `double` to `respond_to` the `working?` method with the value `true`).

### Learning Objectives covered
- Explain why doubles are needed to isolate unit tests
- Use a double to isolate a unit test

### To complete this challenge, you will need to:

- [ ] Note down everywhere in a Unit Test where you refer to a class other than the class being tested.
- [ ] Use the RSpec `double` keyword to substitute all references to these classes with `double`s.
- [ ] Run `rspec` and see that the tests fail.
- [ ] Explain to your pair partner why the tests are failing.

### Hints

<details><summary>CLICK ME</summary>
  <li>Again, before we make these changes, it's important to know why we're doing them. To help understand, change the Bike class' 'working?' method to always return false.  We've introduced a bug into our application, but that's ok - our tests will help guard against breaking changes like this.  Try running RSpec now - as expected, you'll see some tests for you Bike class fail. Less helpfully, however, you'll also see some DockingStation tests failing - this really shouldn't be happening - the bug is in the Bike, not the DockingStation.</li>
  <li>We get around this problem by isolating our unit tests - ensuring that they do not rely on the actual implementation of any Object other than the one we are currently testing.</li>
  <li>RSpec provides us with some handy syntax to help implement this pattern - check out the example above or the linked resources below. Create a double for your Bike class, then swap it in for any references to real Bikes in your DockingStation tests.</li>
</details>

### Resources
- :pill: [Doubles](https://github.com/makersacademy/course/blob/master/pills/doubles.md)
- [RSpec Mocks (docs)](https://relishapp.com/rspec/rspec-mocks/docs)

### [Walkthrough](walkthroughs/19.md)
