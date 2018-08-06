# Removing 'magic numbers'

[Back to the Challenge Map](0_challenge_map.md)

Our code is starting to look pretty. It's legible - we could pass it to another developer with little or no explanation needed - and it's following the Single Responsibility Principle pretty well. However, we're making references to the number `20` repeatedly, without explaining what it is.

Since the number `20` is fixed in stone for now, we can use a **constant** to refactor this 'magic number' out of our code.

In this challenge, you will further refactor your code, using a **constant**.

### Learning Objectives covered
- Use a constant

### To complete this challenge, you will need to:

- [ ] Define a constant, `DEFAULT_CAPACITY`, that stores the number `20`. Do this within the `DockingStation` class.
- [ ] Remove references to the magic number `20` in your implementation, using `DEFAULT_CAPACITY` instead.
- [ ] Refactor your tests to use this new constant instead of the magic number `20`.

### Hints

<details><summary>CLICK ME</summary>
  <li>The first part of this challenge is fairly straightforward - define a constant and replace all references to the number 20.  For more on defining constants see the first linked article below</li>
  <li>We'd also like to replace the magic numbers in our tests, but how can we get access to our constant within our spec files?  You'll need to do some research to find out!</li>
</details>

### Resources

- [Ruby Constants (RubyDoc)](http://ruby-doc.org/docs/ruby-doc-bundle/UsersGuide/rg/constants.html)
- [Magic Numbers](https://www.eliotsykes.com/magic-numbers)

### [Walkthrough](walkthroughs/16.md)
