# From Feature Tests to Unit Tests

[Back to the Challenge Map](0_challenge_map.md)

You should now understand that our error happened because Ruby doesn't know what a `DockingStation` is. Ruby doesn't know this because you haven't told it about `DockingStation`s: you just asked Ruby to make you a new one.

Ruby errors are quite helpful, but they don't tell you exactly how to solve them. For that, you need a testing framework.

In this challenge, you will initialize a testing framework, **RSpec**, and plan your DockingStation with a **Unit Test**.

### Learning Objectives covered
- Define RSpec as a testing framework
- Create a spec file
- Describe an Object using a specification
- Set up a Unit Test

### To complete this challenge, you will need to:

- [ ] Initialize RSpec within your project
- [ ] Create a new spec file for your DockingStation object
- [ ] Set up the spec file to `describe` a DockingStation
- [ ] Run RSpec from the Command Line
- [ ] Explain to your pair partner the difference between this error and the error you saw before.

### Hints

<details><summary>CLICK ME</summary>
  <li>Your first instinct might be to just create a DockingStation class but remember that we're learning to do TDD - we never write any code without first writing a failing unit test.</li>
  <li>First you'll need to set up RSpec - a testing framework for Ruby.  Check out the resources below for more information on how to do this.</li>
  <li>Once RSpec is up and running, you'll need to create a spec file for your DockingStation tests.  RSpec expects this file to follow certain syntactic and naming conventions.  Again, check the links below for more information</li>
  <li>You'll know that everything is working when you see an error message similar to the one in the last step.</li>
</details>

### Resources
- [RSpec wiki](https://github.com/rspec/rspec/wiki)
- [Setting up RSpec (video)](https://www.youtube.com/watch?v=rRDQKAAGw6M)
- [RSpec basics and Spec files](https://semaphoreci.com/community/tutorials/getting-started-with-rspec) (start from 'RSpec basics' partway down the page)

### [Walkthrough](walkthroughs/5.md)


![Tracking pixel](https://githubanalytics.herokuapp.com/course/boris_bikes/5_from_feature_tests_to_unit_tests.md)
