# BDD, TDD & OOP Basics: Boris Bikes

:construction: UNDER CONSTRUCTION :construction:

The goal of this project is to introduce you to [Behaviour Driven Development (BDD)](http://en.wikipedia.org/wiki/Behavior-driven_development), how it relates to [Test Driven Development (TDD)](http://en.wikipedia.org/wiki/Test-driven_development) and the process of domain modeling for [Object-Oriented Programming (OOP) ](https://en.wikipedia.org/wiki/Object-oriented_programming) (also called [DDD - Domain Driven Design](http://en.wikipedia.org/wiki/Domain-driven_design)).  BDD and TDD are commonly selected as part of the Agile development process since they can help us quickly deliver prototypes to end users, which can be rapidly checked to see if they are delivering something of value, and then revised as necessary.   OOP is a style of programming that breaks our code up into 'objects' which helps make our code flexible with regard to the changes that will be required as we discover that end users will derive more value from something different than what we have built so far. DDD emphasizes the development of the domain model which describes the relation between the objects we create.

Please do refer to the detailed [learning objectives](learning_objectives.md) for this week.

***Please work through this walkthrough with a pair partner. Please take turns on the keyboard as the driver as described in the [pairing pill](pills/pairing.md) :pill:.   Please swap driver/navigator roles following an appropriate protocol (ping-pong, change the message), ensuring that the maximum time one person is driving is 15 minutes, but as frequently as every minute.***

We will create a simple system to support [Boris Bikes in London](https://en.wikipedia.org/wiki/Barclays_Cycle_Hire). Our system will allow members of the public to get bikes from docking stations and return them.  Occasionally the bikes may break and then they will be unavailable for rental. There will also be a garage to fix the bikes and a van to move the bikes between the stations and the garage in order to ensure that there are working bikes for members of the public to use.

The way to start any project is to specify a few important "User Stories", usually in collaboration with a customer or client.  The stories below are in the common used Stakeholder, Motivation, Task format.  Let's imagine that we've just finished a discussion with a customer and identified these key stories that the client believes will deliver value to the end users of the system:

```
As a member of the public,
So that I can get across town,
I'd like to access a bike that is not broken.

As a maintainer of the system,
So that members of the public can get usable bikes,
I'd like docking stations to only release working bikes.

As a maintainer of the system,
So that members of the public can get usable bikes,
I'd like docking stations to accept returning bikes (broken or not).

As a maintainer of the system,
So that members of the public are not disappointed,
I'd like docking stations to not release bikes when there are none available.  

As a maintainer of the system,
So that members of the public can get usable bikes,
I'd like docking stations to not accept more bikes than their capacity.  

As a maintainer of the system,
So that members of the public can get usable bikes,
I'd like vans to come to take broken bikes from docking stations, take them to be fixed and then bring them back to the docking stations.

As a maintainer of the system,
So that members of the public can get usable bikes,
I'd like garages to receive broken bikes from vans, fix them, and then pass them back to vans for distribution.
```

As you can tell this is a simplified version of the user experience that members of the public and system maintainers have for the real Boris Bikes system in London.  We've left out details of payment and other things to make our first version of the system tractable.  This is often a sensible step in order to build something simple and manageable the first time round and check that things work at that level before adding in more complex interactions.  It is generally a mistake to try to model everything you need in the system on the first go.  It is much easier to manage a complex system if you have ensured that small portions of it work correctly.

Discussions with real clients may well generate many more stories than the the few we have above, but the next step in Behaviour Driven Development (BDD) will be to choose a small number of stories to focus on - the ones that deliver the key value; and then one specific story to start with.  BDD gets its name from the fact that we are starting to describe the system in terms of its 'Behaviour'.  How will end users behave when they try to interact with the system; how will the system behave as users try to interact with it.  Let's assume we've selected the above stories from a larger set and the client (or at least we) are happy to start on these ones.

Given that we've agreed what our basic system needs to do, where do we go next?  It's helpful to start thinking about a domain model for our system; something that describes the kinds of objects in the system and how they interact.  We could spend a lot of time fleshing out that domain model in advance, but often it will emerge interactively as we switch from high level acceptance (or feature) tests to lower level unit tests whereby we specify the precise individual operations that the objects in our domain can perform.  Having written a specification for an individual object with a test, we'll implement part of the object itself and then jump back up to see if the system has the high level behaviour specified in our user story.  We'll keep fleshing out our domain with unit-tests, and then jumping back up to see the stories coming to life at the acceptance test level.  Sometimes we'll want to step back and consider 'refactoring' the domain model and the code that supports it in order to better support the delivery of value to the end user through user stories. It may sound complicated but you'll soon get used to it.

To be specific about the types of tests we'll be writing; unit tests check very small aspects of functionality on individual objects, ideally in complete isolation of each other.  Feature or Acceptance tests (we'll use the two terms interchangeably) check that the correct high level behaviour is provided by the system.  For example, that an individual bike can be in a broken or fixed state is something to check with a unit test, while having an end user able to access a bike that is not broken would be a feature test.  In complex systems we can have a range of other types of tests between the extremes of umbrella-like feature tests and low level independent unit tests.  Intermediate tests are often called 'integration-tests'; tests that might check the interaction of a few objects, but might not necessarily check if a complete user story is supported.  In this tutorial things are relatively simple so anything that is complex enough to check interacting objects is likely to be a feature test, so we'll be able to refer to them as integration tests, but it's good to understand the difference between these three types of tests as indicated by the testing pyramid:

![Testing Pyramid](../images/test_pyramid.gif)

This pyramid diagram indicates the likely distribution of tests we have in anything other than a small project.  It's not prescriptive but its common to have a small number of relatively slow running acceptance tests, a slightly larger number of integration tests and then a large number of small fast unit tests.  Having a balanced testing pyramid is about getting the right amount of benefit from each type of test.  Unit tests are fast so we can have a lot of them, and then they are great at checking individual behaviour, but won't check the system does what the user wants, or that objects are interacting correctly, that's what the slower running integration and acceptance tests do, but because they run more slowly we can't afford to run so many each time we make any change to our code.

In the process of creating individual objects through a test driven process we'll gradually create an implementation in code of our domain model.  Over the course of this tutorial we'll fashion a series of classes that allow us to create bike objects, van objects, docking station objects and so on.  A system like this (in a much more complex form) is actually used by the real Boris bikes system in London. Every time you rent or return a bike some objects get created somewhere in the system that tracks the usage of all bikes.

[NEED TO MENTION RED-GREEN-REFACTOR MORE]

## Stage 0: Domain Model and Project Setup

Let's being by fleshing out our domain model and getting a base project set up.

[Stage 0](boris_bikes_stage_0.md)

## Stage 1: Creating a Feature Test

Now we have a domain model and a project setup, let's continue with our first feature test, based on a single user story.

[Stage 1](boris_bikes_stage_1.md)

## Stage 2: Creating a Docking Station via Unit Tests

Given a failing feature test that is failing for the right reason we'll drop to the unit test level and start creating our docking station by specifying its low level behaviour

[Stage 2](boris_bikes_stage_2.md)

## Stage 3: Creating a Bike via Unit Tests

Our feature test involves both docking stations and bikes, so we'll have to drive creation of a Bike class with some more unit tests.  Ultimately this will allow our feature test to pass.

[Stage 3](boris_bikes_stage_3.md)

## Stage 4: Refactoring Vs New Features

Now we'll see that there is an opportunity to refactor our code to improve it's design, but is it premature?  Does it make more sense to first implement a feature that prevents the release of bikes when none are available?

[Stage 4](boris_bikes_stage_4.md)

## Stage 5: Giving Docking Stations Limited Capacities

Moving on we work on tests to support user stories relating to docking stations having limited capacities.

[Stage 5](boris_bikes_stage_5.md)

## Stage 6: Dealing with Broken Bikes

Bikes still can't break because we haven't looked at stories involving broken bikes.  In stage 5 we address two stories that are intimately tied to bikes being broken, i.e. those about preventing docking stations accepting broken bikes but not releasing them.

[Stage 6](boris_bikes_stage_6.md)

## Stage 7: Feature Tests for Van and Garage

Finally we have two more user stories relating to the Van and the Garage.  You've seen how the BDD acceptance-unit test cycle works.  This stage is less structured - make your own feature tests, unit tests and application functionality and consider the refactoring hints we give you.

[Stage 7](boris_bikes_stage_7.md)

Now, just like a real project the client has come back to us with more requests:

## More User Stories/Feature Requests from the Client

1. Return real bikes.  Use this new story from the client to create the appropriate feature tests and unit-tests to drive the creation of the application code that will support this feature.  Ensure that you refactor where appropriate:

```
As a maintainer of the system,
So that members of the public can get usable bikes,
I'd like docking stations to ensure that returned entities are actually bikes
```

[Hint: in this context, something is a bike if it responds to the :broken? method. And the feature test for this user story will correspond to ensuring that if docking_station.dock(nil) or docking_station.dock(Elephant.new) is called then some kind of error should be given]

2. The client asks for the whole system to be repurposed for petrol engine scooters.  Everything else stays the same - create BorisScooters.  How much of your existing code can you re-use?

3. User interface request. Our users are getting tired of starting irb to access their bikes.  Help them out by providing a text interface that they can start via a command line call like 'ruby boris_bikes.rb':

```
As a member of the public,
So that I can avoid the hassle of starting IRB,
I'd like a text interface that can be run from the command line.
```

As you work on new features ensure to keep the following in mind:

* Identify any corner cases that might cause the system to behave erratically. Think of things that could go wrong. What if the capacity is not a number? What if it's negative?
* Identify any places in your code that could be refactored and refactor them. Is there any duplication anywhere? Is any method longer than 3-4 lines? Does anything look ugly to you?


## Supporting Material

### Pills

- :pill: [Inheritance](https://github.com/makersacademy/course/blob/master/pills/inheritance.md)
- :pill: [Composition vs. Inheritance](https://github.com/makersacademy/course/blob/master/pills/composition_vs_inheritance.md)
- :pill: [Understanding self, the current/default object](https://github.com/makersacademy/course/blob/master/pills/self.md)

### Resources

- [CRC - Wikipedia](https://en.wikipedia.org/wiki/Class-responsibility-collaboration_card)
- [CRC - Extreme Programming](http://www.extremeprogramming.org/rules/crccards.html)
- [CRC - Agile Modeling](http://www.agilemodeling.com/artifacts/crcModel.htm)
- [CRC - C2 Wiki](http://www.c2.com/cgi/wiki?CrcCard)
- [Ruby Style Guide](https://github.com/bbatsov/ruby-style-guide)

### Related Videos

- [First Week Intro](https://www.youtube.com/watch?v=eq4fbus_9TQ)
- [OOD CRC](https://www.youtube.com/watch?v=l-k21H2mVxQ)
- [RSpec (no sound)](https://www.youtube.com/watch?v=3GM793XcUOQ)
- [Inheritance and Composition](https://www.youtube.com/watch?v=pQHOysslTlI)
- [Doubles](https://www.youtube.com/watch?v=pQHOysslTlI)
- [The Ruby Way](https://www.youtube.com/watch?v=oh3ZOdewHu8)
- [The Ruby Way II](https://www.youtube.com/watch?v=bl2GhZMZeXg)
