# BDD, TDD & OOP Basics: Boris Bikes

The goal of this project is to introduce you to:

- [Behaviour Driven Development (BDD)](http://en.wikipedia.org/wiki/Behavior-driven_development);
- How BDD relates to [Test Driven Development (TDD)](http://en.wikipedia.org/wiki/Test-driven_development), and
- The process of domain modeling for [Object-Oriented Programming (OOP) ](https://en.wikipedia.org/wiki/Object-oriented_programming) (which is strongly related to [DDD - Domain Driven Design](http://en.wikipedia.org/wiki/Domain-driven_design)).  

**BDD** and **TDD** are often used as part of an *Agile* development process. Agile and BDD work well together as they help us quickly deliver prototypes to end users, which can be rapidly checked to see if they are delivering something of value, and then revised as necessary.

**OOP** is a style of programming that encourages us to break code up into 'objects'. This 'modularization' leaves our code flexible, anticipating future changes.  Changes are guaranteed as a project progresses: inevitably, we will discover that end users derive more value from something different than what we have built so far. While we cannot plan for the specific changes they will require (because we don't know them yet!), OOP encourages us to write code that is easy to change in any circumstance. DDD emphasizes the development of a 'domain model', which describes the relations between objects in the language of the end user.

For an overview of the baseline skills and concepts you will be learning during this project, see this week's [Learning Objectives](learning_objectives.md).

***Please work through this walkthrough with a pair partner. Please take turns on the keyboard as the driver as described in the [pairing pill](../pills/pairing.md) :pill:.   Please swap driver/navigator roles following an appropriate protocol (change the message is probably best), ensuring that the maximum time one person is driving is 15 minutes, but as frequently as every minute.***

***Also watch out for the :running_shirt_with_sash: ATHLETIC WAYPOINTS.  We recommend you stop at these points to try re-creating the code so far from scratch without looking at the tutorial.  This is a great exercise at the start of a new day with a new pair partner***

***Finally, please note, as with all Makers Academy materials, there may be subtle errors in the following materials.  Please try to approach those as challenges on which to polish your debugging skills - pull requests always welcome.***

###Project Overview

######High-level Overview

We are going to create a simple system to support [Boris Bikes in London](https://en.wikipedia.org/wiki/Barclays_Cycle_Hire). Our system will allow members of the public to remove and return bikes from docking stations.  Occasionally the bikes may break, and then they will be unavailable for rental. There will be a garage to fix broken bikes. Finally, there will be a van to move the bikes between the stations and the garage so there are working bikes for members of the public to use.

######Identifying User Stories

The way to start our project (and any good software project) is to specify a few important *User Stories*, usually in collaboration with a customer or client. User Stories get us thinking about the high-level problem **from the user's perspective**.  

The stories below are arranged in a *Stakeholder, Motivation, Task* format, which is commonly used:

```
As a <Stakeholder>,
So that <Motivation>,
I'd like <Task>.
```

We identify User Stories by discussing with a customer and listening to or prompting for user requirements. Let's imagine that we've just finished a discussion with a customer. We have identified these key stories that the client believes will deliver value to the end users of the system:

```
As a member of the public,
So that I can get across town,
I'd like a docking station to release a bike that is not broken.

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

This is clearly a simplified version of the user requirements that Stakeholders - members of the public and system maintainers - have for the real Boris Bikes system in London (in a real discussion with a client, we should identify many more).  We've deliberately left out extra considerations, like payment, to make our first version of the system tractable.  This is often a sensible first step, as we can focus on building a **simple**, **manageable** program before adding greater complexity. We can check that everything works each time we come round to add greater complexity.

*It is generally a mistake to try to model everything you need in the system on the first go.  It is much easier to manage a complex system if you have ensured that small portions of it work correctly.*

######Using User Stories in BDD

We are starting to describe our planned system in terms of its planned *Behaviour*: how users will behave when interacting with the system, and how the system will behave when users interact with it. The next step in a BDD process is to choose a small number of stories to focus on: the ones that deliver the **key value** (greatest value to users). Then, we decide on one specific story to start with.

Once we've agreed on what our basic system should do, we can start to think about constructing a **Domain Model**. A Domain Model:

- describes the objects in a system, and
- describes how those objects interact.

We *could* spend a lot of time fleshing out that domain model in advance. But remember: we're only dealing with a subset of all the user stories, and we're anticipating lots of change in future. As we construct *Tests* for our system, we'll see a clearer picture of the Domain Model start to **emerge**. This design philosophy is generally known as *Emergent Design*.

For now, let's agree that we're definitely going to need *some* objects in our Domain Model. Once we start translating *Feature Tests* - tests that describe a feature extracted from a user story - into *Unit Tests* - tests that specif the precise individual operations that entities can perform - we'll quickly see that the nature of those objects, as well as interactions between them, will **emerge**.

######The BDD Cycle

```
User Stories -> Feature Tests -> Unit Tests -> Features
               <--- Emergent Domain Model --->
```

The process of moving from User Stories to Feature (more correctly *Acceptance*) Tests, then from Feature Tests to Unit Tests, and then from Unit Tests to Features, is what BDD is all about. Critically, though, BDD works as a **cycle**. The whole BDD process is designed to work *iteratively*, where the analysis of a previous round *feeds back* into the current one.

Here is an example of the *BDD Cycle* in use:

>We switch from high-level acceptance tests to lower-level unit tests, whereby we specify the precise individual operations that the objects in our domain can perform.  Having written a specification for an individual object with a test, we'll implement *part* of the object itself and then jump back up to see if the system has the high level behaviour specified in our user story.  

>We'll keep fleshing out our domain with unit tests, and then jumping back up to see the stories coming to life at the acceptance test level.  Sometimes we'll want to step back and consider 'refactoring' the domain model and the code that supports it in order to better support the delivery of value to the end user through user stories.

![acceptance-test unit-test cycle](../images/bdd-cycle.png)

The diagram above shows the BDD testing cycle, broken down into the red-green-refactor steps associated with testing both acceptance tests and unit tests.  Red refers to tests failing, green refers to them passing, and then refactor refers to cleaning up the code afterwards, adjust the domain model and so forth, that we can do with confidence because any time we make a change we can run our tests to check we haven't broken something.  This is critical as even tiny changes can break things in unexpected places when programming.  The BDD cycle shown above indicates how we start with a failing acceptance test, we create a related failing unit test, fix and refactor at the unit level and then fix and refactor at the acceptance level.  We'll walk through this entire cycle in this project.

To be specific about the types of tests we'll be writing; unit tests check very small aspects of functionality on individual objects, ideally in complete isolation of each other.  Feature or Acceptance tests (we'll use the two terms interchangeably) check that the correct high level behaviour is provided by the system.  For example, that an individual bike can be in a broken or fixed state is something to check with a unit test, while having an end user able to access a bike that is not broken would be a feature test.  In complex systems we can have a range of other types of tests between the extremes of umbrella-like feature tests and low level independent unit tests.  Intermediate tests are often called 'integration-tests'; tests that might check the interaction of a few objects, but might not necessarily check if a complete user story is supported.  In this tutorial things are relatively simple so anything that is complex enough to check interacting objects is likely to be a feature test, so we'll be able to use the terms integration and feature test somewhat interchangeably, but it's good to understand the difference between these three types of tests as indicated by the testing pyramid:

![Testing Pyramid](../images/test_pyramid.gif)

This pyramid diagram indicates the likely distribution of tests we have in anything other than a small project.  It's not prescriptive but its common to have a small number of relatively slow running acceptance tests, a slightly larger number of integration tests and then a large number of small fast unit tests.  Having a balanced testing pyramid is about getting the right amount of benefit from each type of test.  Unit tests are fast so we can have a lot of them, and then they are great at checking individual behaviour, but won't check the system does what the user wants, or that objects are interacting correctly. That's what the slower running integration and acceptance tests do, but because they run more slowly we can't afford to run so many each time we make any change to our code.

In the process of creating individual objects through a test driven process we'll gradually create an implementation in code of our domain model.  Over the course of this tutorial we'll fashion a series of classes that allow us to create bike objects, van objects, docking station objects and so on.  A system like this (in a much more complex form) is actually used by the real Boris bikes system in London. Every time you rent or return a bike some objects get created somewhere in the system that tracks the usage of all bikes.

## Stage 0: Domain Model and Project Setup

Let's begin by fleshing out our domain model and getting a base project set up.

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

Moving on we work on feature tests to support user stories relating to docking stations having limited capacities.

[Stage 5](boris_bikes_stage_5.md)

## Stage 6: Dealing with Broken Bikes

Bikes still can't break because we haven't looked at stories involving broken bikes.  In stage 5 we address two stories that are intimately tied to bikes being broken, i.e. those about preventing docking stations accepting broken bikes but not releasing them.

[Stage 6](boris_bikes_stage_6.md)

## Stage 7: Feature Tests for Van and Garage

Finally we have two more user stories relating to the Van and the Garage.  You've seen how the BDD acceptance-unit test cycle works.  This stage is less structured - make your own feature tests, unit tests and application functionality and consider the refactoring hints we give you.

[Stage 7](boris_bikes_stage_7.md)

Now, just like a real project the client has come back to us with more requests:

## More User Stories/Feature Requests from the Client (OPTIONAL)

[Stage 8](boris_bikes_stage_8.md)


## Supporting Material

- [CRC - Wikipedia](https://en.wikipedia.org/wiki/Class-responsibility-collaboration_card)
- [CRC - Extreme Programming](http://www.extremeprogramming.org/rules/crccards.html)
- [CRC - Agile Modeling](http://www.agilemodeling.com/artifacts/crcModel.htm)
- [CRC - C2 Wiki](http://www.c2.com/cgi/wiki?CrcCard)
- [Ruby Style Guide](https://github.com/bbatsov/ruby-style-guide)
