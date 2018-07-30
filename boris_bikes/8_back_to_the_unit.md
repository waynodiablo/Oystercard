# Back to the unit

[Back to the Challenge Map](0_challenge_map.md)

The error happened because you asked a Docking Station to `release_bike`, but you haven't told Ruby that a Docking Station can do that.

All Ruby knows is that Docking Stations are allowed to exist, because the class `DockingStation` has been written.

In this challenge, you will write a unit test for the missing method, and make it pass.

### Learning Objectives covered
- Write an RSpec test using `it`
- Test that an Object responds to a Message

### To complete this challenge, you will need to:

- [ ] Add a test to your spec file that expects `DockingStation` instances to `respond_to` the method `release_bike`
- [ ] Rewrite this test using RSpec's one-liner syntax
- [ ] Run RSpec from the Command Line
- [ ] Explain the error to your pair partner
- [ ] Add a method `release_bike` to the `DockingStation` class
- [ ] Run RSpec from the Command Line
- [ ] Explain to your pair partner the difference between what you see, and the error you saw before.

### Hints

<details><summary>CLICK ME</summary>
  <li>Our job, once again, is to write a unit test which fails in the same way as the feature test we have just run.  Again, this will require some RSpec specific syntax to achieve - check the resources below for more information on this.</li>
  <li>Once you have a failing test, the next step is to pass it in the simplest way possible?  How do we do this?  First of all you need to be clear on why the test is currently failing - what is the error message telling you to do?</li>
  <li>Resist the temptation to make guesses about how you think a unit of behaviour will work in the long run - do the bare minimum required to get past this error message</li>
</details>

### Resources

- [Introduction to RSpec](http://blog.teamtreehouse.com/an-introduction-to-rspec) (note that this resource uses the old RSpec syntax – you should use the new syntax [detailed here](http://rspec.info/blog/2012/06/rspecs-new-expectation-syntax/))
- :pill: [RSpec](https://github.com/makersacademy/course/blob/master/pills/rspec.md)
- [RSpec Basic Structure](https://www.relishapp.com/rspec/rspec-core/docs/example-groups/basic-structure-describe-it)
- [RSpec's one-liner syntax](https://www.relishapp.com/rspec/rspec-core/v/3-2/docs/subject/one-liner-syntax)

### [Walkthrough](walkthroughs/8.md)
