# BDD and OOD Basics: Boris Bikes

The goal of this project is to introduce you to:

- The process of domain modeling for Object-Oriented Design (OOD)

For an overview of the baseline skills and concepts you will be learning during this project, see this week's [Learning Objectives](learning_objectives.md).

***Please work through this walkthrough with a pair partner. Please take turns on the keyboard as the driver as described in the [pairing pill](../pills/pairing.md) :pill:.   Please swap driver/navigator roles following an appropriate protocol (change the message is probably best), ensuring that the maximum time one person is driving is 15 minutes, but it can be as frequently as every minute.***

***Also watch out for the :running_shirt_with_sash: ATHLETIC WAYPOINTS.  We recommend you stop at these points to try re-creating the code so far from scratch without looking at the tutorial.  This is a great exercise at the start of a new day with a new pair partner***

***Finally, please note, as with all Makers Academy materials, there may be subtle errors in the following materials.  Please try to approach those as challenges on which to polish your debugging skills - pull requests always welcome.***

## Project Overview

We are going to create a simple system to support [Boris Bikes in London](https://en.wikipedia.org/wiki/Barclays_Cycle_Hire). Our system will allow members of the public to remove and return bikes from docking stations.  Occasionally the bikes may break, and then they will be unavailable for rental. There will be a garage to fix broken bikes. Finally, there will be a van to move the bikes between the stations and the garage so there are working bikes for members of the public to use.

### Identifying User Stories

The way to start our project is to specify a few important *user stories*.  Begin by reading the [User stories pill :pill:](../pills/user_stories.md).

Let's imagine that we've just finished a discussion with the customer. We have identified these key stories that the client believes will deliver value to the end users of the system:

```
As a member of the public,
So that I can get across town,
I'd like to get a working bike from a docking station.

As a member of the public,
So that I am not confused and charged unnecessarily,
I'd like docking stations not to release bikes when there are none available.

As a member of the public,
So that I am not charged for longer than necessary,
I'd like to return a bike to a docking station.

As a member of the public,
So that I reduce the chance of getting a broken bike in future,
I'd like to report a bike as broken when I return it.

As a maintainer of the system,
So that I can manage broken bikes and not disappoint users,
I'd like docking stations not to release broken bikes.

As a maintainer of the system,
So that I can manage broken bikes and not disappoint users,
I'd like docking stations to accept returning bikes (broken or not).

As a maintainer of the system,
So that I can control the distribution of bikes,
I'd like docking stations not to accept more bikes than their capacity.

As a maintainer of the system,
So that I can manage broken bikes and not disappoint users,
I'd like vans to take broken bikes from docking stations and deliver them to garages to be fixed.

As a maintainer of the system,
So that I can manage broken bikes and not disappoint users,
I'd like vans to collect working bikes from garages and distribute them to docking stations.
```

This is clearly a simplified version of the user requirements that stakeholders - members of the public and system maintainers - have for the real Boris Bikes system in London (in a real discussion with a client, we should identify many more).  We've deliberately left out extra considerations, like payment, to make our first version of the system tractable.  This is often a sensible first step, as we can focus on building a **simple**, **manageable** program before adding greater complexity. We can check that everything works each time we come round to add greater complexity.

*It is generally a mistake to try to model everything you need in the system on the first go.  Hard experience has shown time and time again that is easier to create a successful design for a complex systems via* **emergence**.


## Stage 0: Domain Model and Project Setup

*Domain* is a general term for the problem space.  In our case, the domain is Boris Bikes.  A model is an abstract and often simplified representation of a real-world concept that we are attempting to understand or test.  In software development then, a *domain model* is some sort of abstract representation of the domain that helps us to design and build the code.

In Object Oriented Design (OOD), the domain model is a representation of the domain as a collection of objects that can interact with one another and that each have discreet attributes and behaviours.

Let's begin by fleshing out our domain model and getting a base project set up.

[Stage 0](boris_bikes_stage_0.md)

## Stage 1: Implementing our first user story

Now we have a domain model and a project setup, let's continue by thinking about what it would look like if we had a single user story working.

[Stage 1](boris_bikes_stage_1.md)

## Stage 2: Creating a Docking Station via Unit Tests

Given that we've worked out what we would need to have our first user story working, let's drive creation of our docking station via the unit test level.

[Stage 2](boris_bikes_stage_2.md)

## Stage 3: Creating a Bike via Unit Tests

Our story involves both docking stations and bikes, so we'll have to drive creation of a Bike class with some more unit tests.  Ultimately this will allow us to completely implement our first user story.

[Stage 3](boris_bikes_stage_3.md)

## Stage 4: Implementing the next User Story

We'll implement the next user story, which prevents the release of bikes when none are available.

[Stage 4](boris_bikes_stage_4.md)

## Stage 5: Giving Docking Stations Limited Capacities

Moving on we work on user stories relating to docking stations having limited capacities.

[Stage 5](boris_bikes_stage_5.md)

## Stage 6: Dealing with Broken Bikes

Bikes still can't break because we haven't looked at stories involving broken bikes.  In stage 5 we address two stories that are intimately tied to bikes being broken, i.e. those about preventing docking stations accepting broken bikes but not releasing them.

[Stage 6](boris_bikes_stage_6.md)

## Stage 7: Introducing Doubles

Our unit tests need to run fast and be completely independent of each other.  To support that we introduce the critical concept of 'doubles'.

[Stage 7](boris_bikes_stage_7.md)

## Stage 8: Stories for Van and Garage

Finally we have two more user stories relating to the Van and the Garage.  This stage is less structured - develop your own ideas of how these user stories should work, then create unit tests and application functionality and consider the refactoring hints we give you.

[Stage 8](boris_bikes_stage_8.md)

Now, just like a real project the client has come back to us with more requests:

## More User Stories/Feature Requests from the Client (OPTIONAL)

[Stage 9](boris_bikes_stage_9.md)


## Supporting Material

- [Ruby Style Guide](https://github.com/bbatsov/ruby-style-guide)
