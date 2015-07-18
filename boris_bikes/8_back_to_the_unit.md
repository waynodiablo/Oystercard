# Back to the unit

[Back to the Challenge Map](../0_challenge_map.md)

The error happened because you asked a Docking Station to `get_bike`, but you haven't told Ruby that a Docking Station can do that.

All Ruby knows is that Docking Stations are allowed to exist, because the class `DockingStation` has been written.

In this challenge, you will write a unit test for the missing method, and make it pass.

### Learning Objectives covered
- Write an RSpec test using `it`
- Test than an Object responds to a message
- Move between unit and feature tests

### Self-assessment

To complete this challenge, you will need to:

- [ ] Add a test to your spec file that expects `DockingStation` instances to `respond_to` the method `get_bike`
- [ ] Rewrite this test using RSpec's one-liner syntax
- [ ] Run RSpec from the Command Line
- [ ] Explain the error to your pair partner
- [ ] Add a method `get_bike` to the `DockingStation` class
- [ ] Run RSpec from the Command Line
- [ ] Explain to your pair partner the difference between what you see, and the error you saw before.

### Resources

- [Introduction to RSpec](http://blog.teamtreehouse.com/an-introduction-to-rspec) (note that this resource uses the old RSpec syntax – you should use the new syntax [detailed here](http://rspec.info/blog/2012/06/rspecs-new-expectation-syntax/))
- :pill: [RSpec Pill](https://github.com/makersacademy/course/blob/master/pills/rspec.md)
- [RSpec Basic Structure](https://www.relishapp.com/rspec/rspec-core/docs/example-groups/basic-structure-describe-it)
- [RSpec's one-liner syntax](https://www.relishapp.com/rspec/rspec-core/v/3-2/docs/subject/one-liner-syntax)

### [Solution](solutions/8.md)