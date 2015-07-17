# Building a bike

[Back to the Challenge Map](../0_challenge_map.md)

You now have a definition for a `DockingStation`:

```ruby
class DockingStation
  def get_bike

  end
end
```

When you **instantiate** this class:

```ruby
docking_station = DockingStation.new
``` 

you have an object (`docking_station`) that responds to `get_bike`. You would like `get_bike` to give you a Bike object. You would also like to check that this object responds to a method `working?`.

In this challenge, you will run a Feature Test to test the above. It will fail, so you will have to write a Unit Test based on the error you get. You will then write code to fix that error. This challenge combines the content from stages [3](3_from_domain_models_to_feature_tests.md) to [8](8_back_to_the_unit.md): look back at them if you get stuck.

### Learning Objectives covered
- Debug an error using a stack trace
- Create a spec file
- Describe an Object using a spec
- Set up a unit test
- Move between unit and feature tests
- Pass a unit test
- Use `require`
- Test that an Object responds to a message

### Self-assessment

To complete this challenge, you will need to:

- [ ] Start `irb`
- [ ] Instantiate a `DockingStation` as `docking_station`
- [ ] Ask `docking_station` to get you a bike, and save the response to a variable `bike`
- [ ] Ask the `bike` if it is `working?`
- [ ] Explain the error to your pair partner
- [ ] Create a new spec file for a `Bike` class
- [ ] Set up the spec file to `describe` the `Bike` class
- [ ] Run RSpec from the Command Line
- [ ] Fix the error you see, similarly to how you fixed the same error for DockingStation
- [ ] Add a test to your `bike_spec.rb` file that expects `Bike` instances to `respond_to` the method `working?`
- [ ] Make this test pass.

### Resources


### [Solution](solutions/9.md)