# Initialization defaults

[Back to the Challenge Map](0_challenge_map.md)

Now we have a constant, `DEFAULT_CAPACITY`, that forces all `DockingStation` instances to accept a maximum of 20 `Bike` instances, in an array stored as an instance variable `@bikes`. Nice!

Unfortunately for us, here comes another email from the client: they want system maintainers to be able to set variable capacities on new `DockingStation` instances. This should default to `20` if no capacity is supplied.

Here's a User Story for that:

```
As a system maintainer,
So that busy areas can be served more effectively,
I want to be able to specify a larger capacity when necessary.
```

In this challenge, you will modify your `intialize` function to accept a `capacity` argument with a **default value** set to the `DEFAULT_CAPACITY`.

### Learning Objectives covered
- Set an initial attribute value using `initialize`
- Set a default initialization value

### To complete this challenge, you will need to:

- [ ] Write a feature test that allows a user to set a `@capacity` instance variable when `DockingStation.new` is called.
- [ ] Create Unit tests for this
- [ ] Implement the functionality in your code.
- [ ] Write a feature test that ensures a default capacity of `20` is set when no parameters are passed to `DockingStation.new`
- [ ] Create a unit test for this default capacity
- [ ] Use a default argument value within the `initialize` method to make this test pass.

### Hints

<details><summary>CLICK ME</summary>
  <li>We want to be able to set the capacity for a DockingStation by passing a number as an argument at initialisation.  You should be able to TDD this behaviour without too much trouble.</li>
  <li>Once this works, we want to ensure that if the user doesn't provide an argument then the capacity defaults to 20.  Ruby provides us with a handy bit of syntax to deal with situations just like this - check out the linked document below.  Run a feature test, write a failing unit test and get it to pass.</li>
</details>

### Resources

- [Method arguments in Ruby](http://www.skorks.com/2009/08/method-arguments-in-ruby/)

### [Walkthrough](walkthroughs/17.md)


![Tracking pixel](https://githubanalytics.herokuapp.com/course/boris_bikes/17_initialization_defaults.md)
