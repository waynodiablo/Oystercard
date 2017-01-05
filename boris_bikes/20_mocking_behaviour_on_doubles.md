# Mocking Behaviour on Doubles

[Back to the Challenge Map](0_challenge_map.md)

We've isolated our tests, but now they're failing. This is happening because our `double`s can't respond to all the messages `Bike` instances can, like `broken?`.

In this challenge, you will **mock** behaviour by allowing `double`s to respond to certain methods with predefined values. These predefined method-value relationships are called **method stubs**.

### Challenge Setup

Remember our isolated test from the last challenge? It looked a bit like this:

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

This test is failing, because the `double` doesn't know how to `respond_to` the `working?` method with the value `true`.

Let's implement that by **mocking** behaviour on the `double`:

```ruby
# let's extract the double to a let
# statement so we can use it repeatedly
let(:bike) { double :bike }
it 'releases working bikes' do
  # let's superpower our double
  # using allow().to receive().and_return()
  allow(bike).to receive(:working?).and_return(true)
  subject.dock(bike)
  released_bike = subject.release_bike
  # Now the double responds to working?
  # with the value true
  expect(released_bike).to be_working
end
```

There are ways of DRYing the above up, as well: check the Resources for more information.

### Learning Objectives covered
- Explain why method stubs are needed to isolate unit tests
- Use a method stub to isolate a unit test
- Discuss 'London' and 'Chicago' testing styles

### To complete this challenge, you will need to:

- [ ] Find the first failing test
- [ ] Note down the method that the test `double` must respond to for the test to pass
- [ ] Use RSpec's `allow` syntax to permit the double to respond to methods the test requires
- [ ] Repeat for each test
- [ ] Refactor the `allow` statements to use method stubs at the point of `double` creation (see [shorthand syntax](https://github.com/rspec/rspec-mocks#method-stubs))
- [ ] Ensure all your feature and unit tests are passing

### Resources
- [Mocking a simple return value](https://www.relishapp.com/rspec/rspec-mocks/v/2-14/docs/method-stubs/allow-with-a-simple-return-value)
- [RSpec Method Stubs (shorthand) (Github)](https://github.com/rspec/rspec-mocks#method-stubs)

### [Walkthrough](walkthroughs/20.md)
