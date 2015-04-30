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

Let's start with one of these and create a feature test.

```ruby
feature 'member of public returns bike' do
  # other tests omitted for brevity

  scenario 'bike can be reported broken when returned' do
    docking_station = DockingStation.new
    bike = Bike.new
    bike.report_broken
    expect { docking_station.release_bike }.not_to raise_error
  end
end
```
We should be getting used to the format of these test failures now :-)

```
Failures:

  1) member of public returns bike bike can be reported broken when returned
     Failure/Error: bike.report_broken
     NoMethodError:
       undefined method `report_broken' for #<Bike:0x007fe543c0afc8>
     # ./spec/features/public_returns_bike_spec.rb:12:in `block (2 levels) in <top (required)>'

```

:twisted_rightwards_arrows:

Again this is our feature test failing.  Naturally we'll want to create a unit-test for the missing low-level functionality.  As you might expect, that will go in our `bike_spec.rb` file.

```ruby
it 'can be reported broken' do
  subject.report_broken
  expect(subject).to be_broken
end
```

We now have another pair of failing tests.  It's down to you now to make them pass.

```
Failures:

  1) Bike can be reported broken
     Failure/Error: subject.report_broken
     NoMethodError:
       undefined method `report_broken' for #<Bike:0x007fe0b9315a50>
     # ./spec/bike_spec.rb:7:in `block (2 levels) in <top (required)>'

  2) member of public returns bike bike can be reported broken when returned
     Failure/Error: bike.report_broken
     NoMethodError:
       undefined method `report_broken' for #<Bike:0x007fe0b9fe5208>
     # ./spec/features/public_returns_bike_spec.rb:12:in `block (2 levels) in <top (required)>'
```

How many unit tests did you create?  **Did you think about the relationship between `broken?` and `working?`?**  Do we need to write additional tests?  Discuss this with your pair partner and write the required tests.

Now let's add another feature test:

```ruby
feature 'member of public accesses bike' do
  # other tests omitted for brevity

  scenario 'docking station does not release broken bikes' do
    docking_station = DockingStation.new
    bike = Bike.new
    bike.report_broken
    docking_station.dock bike
    expect { docking_station.release_bike }.to raise_error 'No bikes available'
  end
end
```

```
Failures:

1) member of public accesses bike docking station does not release broken bikes
   Failure/Error: expect { docking_station.release_bike }.to raise_error 'No bikes available'
     expected Exception with "No bikes available" but nothing was raised
   # ./spec/features/public_accesses_bike_spec.rb:19:in `block (2 levels) in <top (required)>'
```
:twisted_rightwards_arrows:

What unit tests will you need to create in order to support this feature test?  Is the behaviour affected by the number of bikes in the docking station?  What if some are bikes broken and others not?  Make sure your unit tests sufficiently cover all the possible eventualities.


Now take some time to review the user stories with your pair partner.  Write a new feature test for the third user story.  What will happen when you run RSpec?

Make sure all of your feature and unit tests are passing.

Let's consider some refactoring.  Our feature test looks like it could use some attention.  Check out `public_accesses_bike_spec.rb`:

```ruby
feature 'member of public accesses bike' do
  scenario 'docking station releases a working bike' do
    docking_station = DockingStation.new
    docking_station.dock Bike.new
    bike = docking_station.release_bike
    expect(bike).to be_working
  end

  scenario 'docking station does not release a bike when there are none available' do
    docking_station = DockingStation.new
    expect { docking_station.release_bike }.to raise_error 'No bikes available'
  end

  scenario 'docking station does not release broken bikes' do
    docking_station = DockingStation.new
    bike = Bike.new
    bike.report_broken
    docking_station.dock bike
    expect { docking_station.release_bike }.to raise_error 'No bikes available'
  end
end
```

We're declaring `DockingStation.new` three times.  We could make this feature test `describe DockingStation` and use RSpec's implicitly defined subject, but it's a feature test that is testing both Bike and DockingStation so let's use an alternative.  A `let` statement:

```ruby
feature 'member of public accesses bike' do

  let(:docking_station) { DockingStation.new }

  scenario 'docking station releases a working bike' do
    docking_station.dock Bike.new
    bike = docking_station.release_bike
    expect(bike).to be_working
  end

  scenario 'docking station does not release a bike when there are none available' do
    expect { docking_station.release_bike }.to raise_error 'No bikes available'
  end

  scenario 'docking station does not release broken bikes' do
    bike = Bike.new
    bike.report_broken
    docking_station.dock bike
    expect { docking_station.release_bike }.to raise_error 'No bikes available'
  end
end
```

Notice how we've replaced three lines of identical code with a single `let` statement.  Each programmer has their own rule of thumb, but something being repeated three times is good time to consider DRYing out your code.  Although remember that every time you DRY out code you are introducing a dependency that may catch you out later.  It's important to consider if the set of identical elements you are consolidating may need to vary at some point in the future ...

Every time you extract a commonality you are adding a dependency.  DRYing out your code is very important, but developing an intuition for just when to do it is also critical.

:running_shirt_with_sash: ATHLETIC WAYPOINT - try re-creating the code so far from scratch without looking at the tutorial.

**Now all our examples pass and we've refactored, a perfect time to commit our changes. Push them to Github (:pill: [Version Control with Git](https://github.com/makersacademy/course/blob/master/pills/git.md)), and this can also be a good time switch Driver/Navigator Roles again&nbsp;:twisted_rightwards_arrows: if someone's been driving for too long.
**

Time to move on to [Stage 7](boris_bikes_stage_7.md)!
