## Post-challenge: More User Stories/Feature Requests from the Client

[Back to the Challenge Map](0_challenge_map.md)

A series of extensions you might care to try.

1. Return real bikes.  Use this new story from the client to create the appropriate feature tests and unit-tests to drive the creation of the application code that will support this feature.  Ensure that you refactor where appropriate:

  ```
  As a maintainer of the system,
  So that members of the public can get usable bikes,
  I'd like docking stations to ensure that returned entities are actually bikes
  ```

  [Hint: in this context, something is a bike if it responds to the :broken? method. And the feature test for this user story will correspond to ensuring that if docking_station.dock(nil) or docking_station.dock(Elephant.new) is called then some kind of error should be given]

2. The client asks for the whole system to be repurposed for petrol engine scooters.  Everything else stays the same - create BorisScooters.  How much of your existing code can you re-use?

3. Customers choose Bikes. The client says users want to select the bike of preference, not just be given any bike. Use this new story from the client to create the appropriate feature tests and unit-tests to drive the creation of the application code that will support this feature.  Ensure that you refactor where appropriate:

  ```
  As a member of the public,
  So that I can choose a particular bike of my preference,
  I'd like to be able to specify which bike I receive.
  ```

4. User interface request. Our users are getting tired of starting irb to access their bikes. Help them out by providing a text interface that they can start via a command line call like 'ruby boris_bikes.rb':

  ```
  As a member of the public,
  So that I can avoid the hassle of starting IRB,
  I'd like a text interface that can be run from the command line.
  ```

As you work on new features ensure to keep the following in mind:

* Identify any corner cases that might cause the system to behave erratically. Think of things that could go wrong. What if the capacity is not a number? What if it's negative?
* Identify any places in your code that could be refactored and refactor them. Is there any duplication anywhere? Is any method longer than 3-4 lines? Does anything look ugly to you?

Other possible feature requests and system changes
* Bikes now break with some random frequency, ensure you stub out that randomness to ensure your tests always pass
* DockingStations can now fix bikes themselves
* Garages can now release individual bikes to users
* Vans can run out of petrol and have to be refill at petrol stations
* Users must pay to release bikes, docking stations must check user credit levels

[Back to the Challenge Map](0_challenge_map.md)


![Tracking pixel](https://githubanalytics.herokuapp.com/course/boris_bikes/post_challenge.md)
