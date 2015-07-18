# Making Docking Stations get Bikes

[Back to the Challenge Map](../0_challenge_map.md)

You now have a definition for a `DockingStation` and a `Bike`. Docking Stations respond to `get_bike`, and Bikes respond to `working?`.

If we run a feature test, we still get a failure:

```
$ irb
2.2.2 :001 > require './lib/docking_station'
 => false
2.2.2 :002 > station = DockingStation.new
 => #<DockingStation:0x007fd45b884208>
2.2.2 :003 > bike = station.get_bike
 => nil
2.2.2 :004 > bike.working?
NoMethodError: undefined method `working?' for nil:NilClass
  from (irb):4
  from /Users/username/.rvm/rubies/ruby-2.2.2/bin/irb:11:in `<main>'
```

This failure is happening because `station.get_bike` returns `nil` instead of an instance of the `Bike` class. You have to alter the `DockingStation` class so `get_bike` returns a new instance of the `Bike` class.

In this challenge, you will deliver the completed feature from the first two user stories.

### Learning Objectives covered
- Use Objects within other Objects
- Use RSpec 'predicate' syntax
- Pass a feature test

### Self-assessment

To complete this challenge, you will need to:

- [ ] Feature-test the feature you are building using irb
- [ ] Explain the error to your pair partner
- [ ] Add a test to your DockingStation specification that a) gets a bike, and then b) expects the bike to be working
- [ ] Make this test pass
- [ ] Feature-test the feature again.

### Resources
- :pill: [The BDD Cycle](https://github.com/makersacademy/course/blob/master/pills/bdd_cycle.md)


### [Solution](solutions/10.md)