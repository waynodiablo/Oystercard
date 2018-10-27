# Making Docking Stations Release Bikes

[Back to the Challenge Map](0_challenge_map.md)

You now have a definition for a `DockingStation` and a `Bike`. Docking Stations respond to `release_bike`, and Bikes respond to `working?`.

If we run a feature test, we still get a failure:

```
$ irb
2.2.2 :001 > require './lib/docking_station'
 => false
2.2.2 :002 > station = DockingStation.new
 => #<DockingStation:0x007fd45b884208>
2.2.2 :003 > bike = station.release_bike
 => nil
2.2.2 :004 > bike.working?
NoMethodError: undefined method `working?' for nil:NilClass
  from (irb):4
  from /Users/username/.rvm/rubies/ruby-2.2.2/bin/irb:11:in `<main>'
```

This failure is happening because `station.release_bike` returns `nil` instead of an instance of the `Bike` class. You have to alter the `DockingStation` class so `release_bike` returns a new instance of the `Bike` class.

In this challenge, you will deliver the completed feature from the first two user stories.

### Learning Objectives covered
- Use Objects within other Objects
- Use RSpec 'predicate' syntax
- Pass a feature test

### To complete this challenge, you will need to:

- [ ] Feature-test the feature you are building using irb
- [ ] Explain the error to your pair partner
- [ ] Add a test to your DockingStation specification that a) gets a bike, and then b) expects the bike to be working
- [ ] Make this test pass
- [ ] Feature-test the feature again.

### Hints

<details><summary>CLICK ME</summary>
  <li>Your feature test should help you ascertain whether DockingStation's release_bike does, on fact, give you a Bike.  Right now the answer is no.  Why is this?  Take a look at the release_bike method.</li>
  <li>We'll want to fix this, but, as usual we'll need to write a test first.  Your test should check that you can call working? on the result of DockingStation.release_bike, and that the result of doing so is true.</li>
  <li>you're likely to have to go through several iterations of this test before it finally passes.  Remember to let your error messages guide you, doing the bare minimum to make progress.</li>
  <li>First, you'll need to make it so that your release_bike method returns a Bike.  Having done this your test will still fail - your working? method return nil.</li>
  <li>It's super important to keep running your feature test periodically throughout this process - your unit tests are not bullet proof and you need to be sure that the different objects in your programme play well together.  It's likely that at some point you'll have an unexpected error in your feature tests complaining that Bike is not defined.  But it is!  We've seen a problem similar to this before - how did we solve it?</li>
</details>

### Resources
- :pill: [The BDD Cycle](https://github.com/makersacademy/course/blob/master/pills/bdd_cycle.md)


### [Walkthrough](walkthroughs/10.md)


![Tracking pixel](https://githubanalytics.herokuapp.com/course/boris_bikes/10_making_stations_release_bikes.md)
