## Stage 6:  Dealing with Broken Bikes

***As with all Makers Academy materials, there may be subtle errors in the following materials.  Please try to approach those as challenges on which to polish your debugging skills - pull requests always welcome.***

There are two more user stories that are specific to just stations and bikes, but have to deal with broken bikes.

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

Let's start with one of these and imagine how our manual feature test would look:

```
$ irb
2.0.0-p195 :001 > station = DockingStation.new
 => #<DockingStation:0x007fae7b3b8950>
2.0.0-p195 :002 > bike = Bike.new
 => #<Bike:0x007fae7b3c0dd0>
2.0.0-p195 :003 > bike.report_broken
 => nil
2.0.0-p195 :004 > bike.broken?
 => true
2.0.0-p195 :005 > docking_station.dock bike
 => nil
```

Typing this into IRB we should be getting used to the format of these error messages by now :-)

```
2.0.0-p195 :003 > bike.report_broken
NoMethodError: undefined method `report_broken' for #<Bike:0x007fad7c030ee0>
	from (irb):8
	from /Users/tansaku/.rvm/rubies/ruby-2.2.2/bin/irb:11:in `<main>'
```

:twisted_rightwards_arrows:

So our manual feature test doesn't work.  Naturally we'll want to create a unit-test for the missing low-level functionality.  As you might expect, that will go in our `bike_spec.rb` file.

```ruby
it 'can be reported broken' do
  subject.report_broken
  expect(subject).to be_broken
end
```

We now have a failing unit test to match our manual feature test error:  

```
Failures:

  1) Bike can be reported broken
     Failure/Error: subject.report_broken
     NoMethodError:
       undefined method `report_broken' for #<Bike:0x007fe0b9315a50>
     # ./spec/bike_spec.rb:7:in `block (2 levels) in <top (required)>'
```

It's down to you to make the unit test pass which should in turn allow the manual feature test to get another step further.  The training wheels are coming off now - see if you can get the complete feature working.

How many unit tests did you create?  **Did you think about the relationship between `broken?` and `working?`?  In particular, do our current set of features demand a relationship between broken and working? Or not yet?**    Do we need to write additional tests?  Discuss this with your pair partner and write the required tests.

When you think you're done let's move on to create another manual feature test to correspond to the second of the three user stories above.  The output we want is:

```
$ irb
2.0.0-p195 :001 > station = DockingStation.new
 => #<DockingStation:0x007fae7b3b8950>
2.0.0-p195 :002 > bike = Bike.new
 => #<Bike:0x007fae7b3c0dd0>
2.0.0-p195 :003 > bike.report_broken
 => nil
2.0.0-p195 :004 > docking_station.dock bike
 => nil
2.0.0-p195 :005 > docking_station.release_bike
 RuntimeError: No bikes available
 	.... stack trace omitted ....
```

But at the moment our docking station will happily release a broken bike.  We have to put a stop to that ...

:twisted_rightwards_arrows:

What unit tests will you need to create in order to support this feature test?  Is the behaviour affected by the number of bikes in the docking station?  What if some bikes are broken and others not?  Make sure your unit tests sufficiently cover all the possibilities.


Now take some time to review the user stories with your pair partner.  Start typing out a new manual feature test for the third user story.  How might it fail?

Make sure all of your manual feature tests work and that your unit tests are green.

:running_shirt_with_sash: ATHLETIC WAYPOINT - try re-creating the code so far from scratch without looking at the tutorial.

**Now all our examples pass and we've checked for any possible refactoring, it's a perfect time to commit our changes. Push them to Github, and this can also be a good time switch Driver/Navigator Roles again&nbsp;:twisted_rightwards_arrows: if someone's been driving for too long.
**

Time to move on to [Stage 7](boris_bikes_stage_7.md)!
