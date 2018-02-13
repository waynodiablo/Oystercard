# From Feature Tests to Unit Tests

[Back to the Challenge Map](./_challenge_map.md)

___

### Read up to the end of **stage 3 and stage 4** of the [bdd pill](https://github.com/makersacademy/course/blob/master/pills/bdd_cycle.md).
___

Run the `features.rb` file again.

You should understand this error happened because your test file still doesn't know doesn't know what a `DockingStation` is. Ruby doesn't know this because you haven't told it about `DockingStation`s: you only asked Ruby to make you a new one.

Ruby errors are quite helpful. At this point we need to think about the next step: the failing feature test has shown that we first need to create a DockingStation object. Now we write the unit test for the DockingStation.

**NB:** Currently, it may feel like there's no difference between a feature test and a unit test. The critical thing to remember is that feature tests are derived from user stories, and that many unit tests can make up 1 feature test. At the moment the features we're building are so small they'll frequently only need one or two unit tests.

**Rule of thumb:** Don't write new application code until you have a failing feature test and one of its failing unit tests. And then only write the smallest easiest thing to get only that test to pass.

### Learning Objectives covered
- Create a test directory with a test file
- Describe the Object that you are going to test
- Plan a unit of code with a **Unit Test**.
- use `p` to inspect a variable _to get visibility_

### To complete this challenge, you will need to:

- [ ] Create an appropriately named folder `tests` to keep your tests all together
- [ ] Inside this, create an appropriately named test file `docking_station_test.rb` for your DockingStation object
- [ ] Set up the test file to `puts` the name of the test: `A DockingStation`
- [ ] Add a line of code that creates an instance of `DockingStation` and stores it in a local variable.
- [ ] Add another line of code to `p` the variable to output, and explain to your pair partner what the output you would want to see if it executes
- [ ] Run the file
- [ ] Explain to your pair partner the error message and discuss how to solve it.

## [back](./errors_are_good.md) | [next](./passing_your_first_unit_test.md)

### Resources

- [p vs puts vs print](http://www.garethrees.co.uk/2013/05/04/p-vs-puts-vs-print-in-ruby/)
