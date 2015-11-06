# Limiting Capacity

[Back to the Challenge Map](0_challenge_map.md)

Our program now raises an exception when we try to `#release_bike` from a `DockingStation` instance with no bikes docked.

Our next User Story requires us to do a similar thing when the Docking Station is full:

```
As a maintainer of the system,
So that I can control the distribution of bikes,
I'd like docking stations not to accept more bikes than their capacity.
```

In this challenge, you will raise an exception when a user attempts to dock a bike at a `DockingStation` that already contains a bike (i.e. with a capacity of 1). Scaffolding has been removed, but the steps are similar to [Challenge 12](12_raising_exceptions.md).

### Learning Objectives covered
- Write RSpec tests that `expect` errors
- Use `fail` or `raise` to raise an error
- Use a 'guard condition'

### To complete this challenge, you will need to:

- [ ] Deliver the feature above in a Test-Driven manner

### Resources

- [RSpec errors documentation (Github)](https://github.com/rspec/rspec-expectations#expecting-errors)
- [Relish errors documentation](http://www.relishapp.com/rspec/rspec-expectations/v/3-3/docs/built-in-matchers/raise-error-matcher)

### [Solution](solutions/13.md)