# From User Stories to a Domain Model

A **User Story** describes one thing a program is expected to do, from the perspective of somebody using that program. When planning a program, the client's requirements will be decomposed into many User Stories. Much of a developer's life is spent translating User Stories into a functional system. In Object-Oriented Programming, these systems are made up of Objects and Messages. Objects describe the objects within the system, and Messages describe how those objects interact. We call these systems **Domain Models**.

In this challenge, you will transform a User Story into a Domain Model.

### Learning Objectives covered
- Give the structure of a User Story

### Challenge setup

Here is a user story:

```
As a user,
So I can find customers,
I want to search for my customers by their surnames.
```

And here is a functional representation of that story:

Objects  | Messages
------------- | -------------
User  |
Customer  | find_by_surname

You must translate these two user stories into a functional representation:

```
As a person,
So that I can use a bike,
I'd like to get a bike from a docking station.

As a person,
So that I can use a good bike,
I'd like to see if a bike works
```

### Self-assessment

To complete this challenge, you will need to:

- [ ] Write down all the nouns in the User Story
- [ ] Write down all the verbs in the User Story
- [ ] Draw a table like the one above
- [ ] Organise the nouns and verbs into Objects and Messages within the table
- [ ] Draw a diagram that shows how your Objects will use Messages to communicate with one another

### Resources

- :pill: [user stories](https://github.com/makersacademy/course/blob/master/pills/user_stories.md)
