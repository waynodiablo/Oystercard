Dependency Injection
====================

:construction: UNDER CONSTRUCTION :construction:

In the Boris Bikes walkthrough there is a point we get to in the code where the DockingStation becomes very tightly coupled to the Bike class:

```ruby
require_relative 'bike'

class DockingStation
  def release_bike
    Bike.new
  end
end
```

Dependency injection provides a solution to this problem.  At the moment DockingStation depends on Bike.  Instead let's 'inject' that dependency like so:

```ruby
class DockingStation
  def initialize(klass)
    @klass = klass
  end
  def release_bike
    klass.new
  end
end
```

and then we'd need to initialise DockingStations like so:

```sh
d = DockingStation.new Bike
```

we get our intended end user functionality

```sh
→ irb
2.1.5 :001 > require './lib/docking_station'
 => true
2.1.5 :002 > require './lib/bike'
 => true
2.1.5 :003 > d = DockingStation.new Bike
 => #<DockingStation:0x007fc21a153770 @klass=Bike>
2.1.5 :004 > d.release_bike
 => #<Bike:0x007fc21a150cf0>
2.1.5 :005 > _.broken?
 => nil

and we've completely de-coupled DockingStation from Bike.  It can be tested independently and we don't need to require Bike in the DockingStation class definition.


![Tracking pixel](https://githubanalytics.herokuapp.com/course/pills/dependency_injection.md)
