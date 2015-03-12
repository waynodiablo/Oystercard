# BDD, TDD & OOP Basics: Boris Bikes

:construction: UNDER CONSTRUCTION :construction:

The goal of this project is to introduce you to [Behaviour Driven Development (BDD)](http://en.wikipedia.org/wiki/Behavior-driven_development), how it relates to [Test Driven Development (TDD)](http://en.wikipedia.org/wiki/Test-driven_development) and the process of domain modeling for [Object-Oriented Programming (OOP) ](https://en.wikipedia.org/wiki/Object-oriented_programming) (also called [DDD - Domain Driven Design](http://en.wikipedia.org/wiki/Domain-driven_design)).  BDD and TDD are commonly selected as part of the Agile development process since they can help us quickly deliver prototypes to end users, which can be rapidly checked to see if they are delivering something of value, and then revised as necessary.   OOP is a style of programming that breaks our code up into 'objects' which helps make our code flexible with regard to the changes that will be required as we discover that end users will derive more value from something different than what we have built so far. DDD emphasizes the development of the domain model which describes the relation between the objects we create.

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

## Version 0: Domain Model and Project Setup

Given that we have established the high level system behaviours, the next step of the process (even before we think about a single line of code) is to create the [domain model](https://en.wikipedia.org/wiki/Domain_model). As we started to describe above, the [domain model](https://en.wikipedia.org/wiki/Domain_model) describes key concepts in the domain and the relationships between them.  In other words, it helps us understand what classes we may have and what methods they may implement.

Remember that a class is a collection of data and related methods that operate on this data. In order to build a [domain model](https://en.wikipedia.org/wiki/Domain_model) we need to understand what data we'll have in the system and what operations will be performed on that data.

A useful step in creating the domain model is to describe the problem in plain English.

> We are building a system that manages bikes that can be rented by users from docking stations and returned there at the end of the rental. The bikes can break while being used, in which case they will not be available for rental after they are returned. There is a garage that can fix broken bikes. A van is used to move broken bikes from the stations to the garage. It can also be used to take fixed bikes back to the station(s). The van, all stations and the garage have fixed capacity, so they cannot take more bikes that they can hold.

An easy way to start thinking about what classes you may have is to take a look at all nouns in the text. They are prime candidates for classes.

> We are building a system that manages **bikes** that can be rented by **users** from **docking stations** and returned there at the end of the **rental**. The **bikes** can break while being used, in which case they will not be available for **rental** after they are returned. There is a **garage** that can fix broken **bikes**. A **van** is used to move broken **bikes** from the **stations** to the **garage**. It can also be used to take fixed **bikes** back to the **station(s)**. The **van**, all **stations** and the **garage** have fixed capacity, so they cannot take more **bikes** that they can hold.

Not every noun will become a class and not every class we'll create will correspond to a noun in a plain English description. However, it's a good starting point. All data we'll have in the system will somehow be related to some class. For example, a number of bikes in a certain station is related to the station itself, not to a van or garage.

Our classes will implement a number of methods. To get an idea of what they may be, we can take a look at the verbs in our description.

> We are building a system that manages bikes that can be **rented** by users from docking stations and **returned** there at the end of the rental. The bikes can **break** while being **used**, in which case they will not be available for rental after they are **returned**. There is a garage that can **fix** broken bikes. A van is used to **move** broken bikes from the stations to the garage. It can also be used to **take** fixed bikes back to the station(s). The van, all stations and the garage have fixed capacity, so they cannot **take** more bikes that they can **hold**.

Again, not all verbs will become methods and we'll have methods that don't correspond to any verbs in this description but that's ok. Right now we just need a idea of what they could be.

## Setting up the project

***Please note, as with all Makers Academy materials, there may be subtle errors in the following materials.  Please try to approach those as challenges on which to polish your debugging skills - pull requests always welcome.***

Once we have an idea of what we are building our first step will be describing some part of what we will build using 'specs' (short for specifications).  We'll also refer to these as 'tests'.  Our preferred Ruby testing tool is [RSpec](https://github.com/makersacademy/course/blob/master/pills/rspec.md), and each individual test of our code is a 'spec'.  We can use RSpec to specify all kinds of tests; feature, integration and unit.  Let's get our project setup and we'll start with a feature test.

[NOT SURE ABOUT FORKING VS CREATING OWN REPO - NIKESH SAYS ALL PRECOURSERS ARE DOING PULL REQUESTS WITH RUBY KICKSTARTER]

Create a new repository in your projects directory adding a `README.md` file like so.

````
mkdir boris-bikes
cd boris-bikes
git init
touch README.md
…
````

Add some basic explanation of the project to the README and then create a Github repo called 'boris-bikes' (note: please please ensure that the repo on Github is called exactly this, please ensure you use a hypen '-' and not an underscore '_'), and then connect your local repo to the Github repo and push the changes to the README up to Github and confirm that they are visible on Github.  This is a critical backup of your local changes to a remote machine that you MUST repeat as regularly as possible, ideally each time you get your tests to go green.

Anyhow, this is all just throat clearing activity before we start specifying the behaviour of our system with rspec tests, but we want to ensure we are set up to carefully backup the detailed history of the work we are doing.

## Stage 1: First Feature Test

Let's start with our first feature test

[Version 1](boris_bikes_version_1.md)

## Stage 2: First Unit Test (and Refactoring?)

Red-Green-Refactor

[Version 2](boris_bikes_version_2.md)

## Version 3: Bike

[Version 3](boris_bikes_version_3.md)

## Version 4: Van & Garage

[Version 4](boris_bikes_version_4.md)

## Version 5: Extracting Common Functionality

# Supporting Material?
