# The Single Responsibility Principle

[Back to the Challenge Map](0_challenge_map.md)

Our program is working, but it's getting complex. We need to **refactor** it into a better shape. We will do so using the first of several design principles: the **Single Responsibility Principle** ('SRP').

Consider the following lines of the `dock` method:

```
fail 'Docking station full' if @bikes.count >= 20
@bikes << bike
```

This method is doing two things:

1. Defining the capacity of the docking station (20), and
2. Docking a bike.

As it stands, `dock` _does not have a Single Responsibility_.

In this challenge, you will use **private methods** to extract method responsibilities to other methods.

> You do not need to test `private` methods.

### Learning Objectives covered
- Use the Single Responsibility Principle
- Refactor code for readability

### To complete this challenge, you will need to:

- [ ] Define a `full?` **predicate** method that uses some of the `dock` code to return `true` or `false` depending on whether the station is full or not
- [ ] Rewrite the guard condition of your `dock` method to incorporate your new `full?` method
- [ ] Do the same for `release_bike`, using an `empty?` method
- [ ] Use the `private` keyword to ensure these methods cannot be called from 'outside' instances of the `DockingStation` class.

### Hints

<details><summary>CLICK ME</summary>
  <li>Before we begin our refactor, it's important to understand why we're doing it.  Take a look at the section on Single Responsibility Principle in the first linked resource below.</li>
  <li>Our dock method has multiple responsibilities - managing the docking of bikes (which seems reasonable), and defining the capacity of a DockingStation (which doesn't)</li>
  <li>We should extract this second bit of behaviour out into a private 'full?' method - see the second link below for more information on how to do this.  It's worth noting that we don't need to write additional tests for private methods, so we can do this straight away.</li>
  <li>any time we perform a refactor, we should run our tests - we want to be sure we didn't break anything!</li>
</details>

### Resources

- [Single Responsibility Principle (Thoughtbot)](https://robots.thoughtbot.com/back-to-basics-solid) <-- extracts classes rather than methods, but the principle still applies
- [`private` methods in Ruby](http://culttt.com/2015/06/03/the-difference-between-public-protected-and-private-methods-in-ruby/)

### [Walkthrough](walkthroughs/15.md)


![Tracking pixel](https://githubanalytics.herokuapp.com/course/boris_bikes/15_single_responsibility_principle.md)
