# Wrapping Collections

[Back to the Challenge Map](0_challenge_map.md)

Our system now allows us to `dock` bikes up to a capacity of 1, and to `release_bike` if there is a bike available.

So far we have been assuming the capacity of a `DockingStation` instance to be 1. Your product owner receives an email from the client: they want each docking station to accept 20 bikes. A User Story for this:

```
As a system maintainer,
So that I can plan the distribution of bikes,
I want a docking station to have a default capacity of 20 bikes.
```

In this challenge, you will convert your instance variable `@bike` to reference a **collection**, allowing the docking and releasing of more than one bike. You should keep raising errors when `dock`ing a bike if the docking station is full, and when `release_bike`ing if the docking station is empty.

### Learning Objectives covered
- Wrap a collection in a class
- Set an initial attribute value using `initialize`

### To complete this challenge, you will need to:

- [ ] Write a manual feature test for the above feature. Consider using `20.times { docking_station.dock Bike.new }`.
- [ ] Rename your attribute `@bike` to a name better reflecting that it will store more than one `Bike` instance.
- [ ] Use `rspec` to identify areas of your code that need to be updated to use this new attribute name.
- [ ] Update your existing tests to recognise this new name for the attribute.
- [ ] Use an `initialize` function to set the initial value of this attribute to a simple collection object: an empty array.
- [ ] Update your `release_bike` and `dock` methods to work with this new array (i.e. make your tests pass).
- [ ] Update your `release_bike` and `dock` guard conditions to account for the new capacity of 20 bikes.

### Resources

- [Ruby `initialize` method](http://www.rubyist.net/~slagell/ruby/objinitialization.html)

### [Walkthrough](walkthroughs/14.md)
