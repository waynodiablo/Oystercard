# From a Domain Model to a Feature Test

[Back to the Challenge Map](./_challenge_map.md)

___

### Read up to the end of **stage 2** of the [bdd pill](https://github.com/makersacademy/course/blob/master/pills/bdd_cycle.md).
___

A **Domain Model** is an abstract representation of the Objects within a system, and the Messages they use to communicate with one another. Once you have a Domain Model for a feature, you need to think about how your Objects and Messages will work together in code. This is called a **Feature Test**, also called an **Acceptance Test**.

In this challenge, you will Feature Test a feature, using the Domain Model you just made.

### Learning Objectives covered
- Define 'Feature Test'
- Define a 'stack trace'
- Use a ruby file to run a 'feature test'

### Challenge setup

Here are the two stories you converted into a Domain Model:

```
As a person,
So that I can use a bike,
I'd like a docking station to release a bike.

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

In order to know the first feature is working, according to our **Domain Model** above, we need to have a `DockingStation` object that implements a `release_bike` method. (We'll get to the actual implementation just in a bit)

In order to call methods, we know ruby has the following 'dot' syntax: `object.method`

So if the following works, we're getting somewhere!
```ruby
docking_station = DockingStation.new
docking_station.release_bike
```
Notice already the BDD approach is guiding us towards the implementation in small steps. We haven't written any application code yet, but that comes after thinking about what exactly is the feature we're building.

### To complete this challenge, you will need to:

- [ ] Create a file called  `features.rb`
- [ ] Inside the file set a local variable `docking_station` equal to a new instance of the `DockingStation` class
- [ ] On the next line, call the `release_bike` method on the instance stored in the local variable `docking_station`
- [ ] Run the 'feature test' by running the ruby file from the command line
- [ ] Explain to your pair partner what the resulting error means.

## [back](./working_with_user_stories.md) | [next](./errors_are_good.md)


### Resources

- [Ruby Variables](https://github.com/makersacademy/course/blob/master/pills/variables.md):pill:
- [What's a Domain Model?](http://sjmog.github.io/posts/502_domain-modelling/)
- [IRB](http://ruby-doc.org/stdlib-2.0.0/libdoc/irb/rdoc/IRB.html)
- [Feature Testing in IRB (video)](https://www.youtube.com/watch?v=rShBRLyEccY)
