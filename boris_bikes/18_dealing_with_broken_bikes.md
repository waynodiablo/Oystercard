# Dealing with broken bikes

[Back to the Challenge Map](0_challenge_map.md)

Our system is looking good. We can vary the capacity of docking stations, but only at the point of creation. `DockingStation` instances will default to a capacity of 20 if none is provided. We're all tested, and our code is readable. Let's get harder!

We're now given three User Stories to implement:

```
As a member of the public,
So that I reduce the chance of getting a broken bike in future,
I'd like to report a bike as broken when I return it.

As a maintainer of the system,
So that I can manage broken bikes and not disappoint users,
I'd like docking stations not to release broken bikes.

As a maintainer of the system,
So that I can manage broken bikes and not disappoint users,
I'd like docking stations to accept returning bikes (broken or not).

```

In this challenge, you will implement the above features using the skills you have gained so far.

### Learning Objectives covered
- Implement a feature from scratch

### To complete this challenge, you will need to:

- [ ] Complete the Red-Green-Refactor TDD cycle for each of the features above.

### Resources
- :pill: [The BDD Cycle](https://github.com/makersacademy/course/blob/master/pills/bdd_cycle.md)

### [Solution](solutions/18.md)