# `Module`s as mixins

[Back to the Challenge Map](0_challenge_map.md)

You have now built classes for `Van` and `Garage` that are very similar to the `DockingStation` class. We can tell they are similar as their is quite a lot of duplicated code between them.

When you have similar behaviours across classes, you should extract those similar behaviours to a **mixin**. Then, you can `include` the mixin within a class to gain all of the behaviour that mixin implements. Such a process is called **Object Composition**.

In Ruby, you use `Module`s as mixins.

In this challenge, you will refactor your code to **compose** objects using mixins. You will test-drive this using RSpec's **shared example** feature.

### Learning Objectives covered
- Extract shared behaviour to a Module
- Test Modules
- Mix a Module into a Class using `include`

### To complete this challenge, you will need to:

- [ ] Write down behaviour shared by the `DockingStation`, `Van`, and `Garage` classes (e.g. 'they all contain bikes')
- [ ] Create a spec file for a `Module` (called `BikeContainer`) that uses RSpec's shared example feature
- [ ] Extract relevant tests from your existing Unit Tests for `DockingStation`, `Garage`, and `Van` into the shared example tests for `BikeContainer`
- [ ] Implement `BikeContainer`'s behaviour via TDD
- [ ] Use `include` to mix `BikeContainer` into `DockingStation`, `Garage`, and `Van`
- [ ] Remove methods from `DockingStation`, `Garage`, and `Van` if they duplicate functionality from `BikeContainer`.

### Resources
- [RSpec Shared Examples (Relish)](https://www.relishapp.com/rspec/rspec-core/v/2-0/docs/example-groups/shared-example-group)
- :pill: [Modules](https://github.com/makersacademy/course/blob/master/pills/modules.md)


### [Walkthrough](walkthroughs/22.md)