# Using Instance Variables

[Back to the Challenge Map](0_challenge_map.md)

We now have Docking Stations that can release Bikes, but we have no way to `dock` them. Our next two User Stories will help us take care of this problem:

```
As a member of the public
So I can return bikes I've hired
I want to dock my bike at the docking station
```

```
As a member of the public
So I can decide whether to use the docking station
I want to see a bike that has been docked
```

In this challenge, you will pass instances of the `Bike` class into a `DockingStation` instance. You will store those `Bike` instances as an **attribute** of the `DockingStation` instance, using an **instance variable**. Then, use an **attribute reader** to allow access to the instance variable from the `DockingStation` public interface.

### Learning Objectives covered
- Write RSpec tests that require arguments
- Pass an instance as an argument
- Set an attribute on an instantiated Object using an `@` instance variable
- Use `attr_reader` to read an attribute on an instantiated Object

### To complete this challenge, you will need to:

- [ ] Write a feature test for docking a bike at a docking station
- [ ] Write a unit test for the method you need to add to `DockingStation` to make docking possible
- [ ] Pass both tests
- [ ] Use an instance variable with `attr_reader` to do a full test-implementation cycle for the second User Story above

### Hints

<details><summary>CLICK ME</summary>
  <li>As usual, we're starting this step of the challenge with a failing feature test.  You've seen this kind of failure before - write a matching unit test and pass it in the simplest way possible.</li>
  <li>We now have a method for docking bikes, but it doesn't do anything.  In order to implement the desired behaviour, a DockingStation object needs to have somewhere to stokre the Bike objects which get docked. Ruby provides us with something called instance variables which are perfectly suited for this job. Take a look at the materials linked below for more information.</li>
  <li>Once you start to understand how instance variable operate, you can write your test.  You want to be able to pass a bike as an argument to your dock method, and for that same bike to then be stored in your instance variable.  Implement this behaviour and you're done!</li>
</details>

### Resources

- [Instance variables: the basics (video)](https://www.youtube.com/watch?v=MfNpf-Bcnm8)
- [RubyMonk: instance variables](https://rubymonk.com/learning/books/4-ruby-primer-ascent/chapters/45-more-classes/lessons/110-instance-variables)
- [RSpec `respond_to` expectations documentation](http://www.relishapp.com/rspec/rspec-expectations/v/3-3/docs/built-in-matchers/respond-to-matcher)

### [Walkthrough](walkthroughs/11.md)
