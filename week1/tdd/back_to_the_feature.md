# Back to the feature

[Back to the Challenge Map](./_challenge_map.md)

Now we have passed a unit test, we go back to our feature tests. You have now implemented a `DockingStation` class, so you should be able to get further than last time.

In this challenge, you will get further in your feature test, and dissect an error.

### Challenge setup

Here are the User Stories you converted into a Domain Model:

```
As a person,
So that I can use a bike,
I'd like to get a bike from a docking station.

As a person,
So that I can use a good bike,
I'd like to see if a bike is working
```

Here is a functional representation of those stories:

Objects  | Messages
------------- | -------------
Person  |
Bike  | working?
DockingStation | release_bike

Here is the `DockingStation` class you should have written:

```ruby
# in lib/docking_station.rb
class DockingStation

end
```

Now that the unit test for implementing the `DockingStation` has passed, we can run the feature test again to check whether the feature is done.

### Learning Objectives covered

- Move between Feature and Unit Tests

### To complete this challenge, you will need to:

- [ ] Run your feature test and discuss the error with your partner and suggest ways to solve it
- [ ] Solve the error and then run the feature test again
- [ ] Note the new error from the failing feature test
- [ ] Add a line of code that asks in your test file the `docking_station` instance to `release_bike`
- [ ] Explain to your pair partner what the resulting error means and what your next step should be

### Resources
- [Including files in Ruby](http://rubylearning.com/satishtalim/including_other_files_in_ruby.html)
- [Ruby Docs - Exception](http://ruby-doc.org/core-2.2.0/Exception.html)

## [back](./passing_your_first_unit_test.md) | [next](./back_to_the_unit.md)
