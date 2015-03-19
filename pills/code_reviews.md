# How To Code Review

>This pill is basically a summary of [this talk]((https://youtu.be/uqf4vG2L95Q). The [slides for the talk](https://slides.com/leoallen/code-reviews) are available if you want a brief overview of the talk. 

This pill is designed to give you an insight into how to review other people's code. At the same time it is intended to act as a valuable tool for writing your challenges/tech tests, as when doing them you **should always be thinking about your code from the perspective of someone reviewing it**. Below are the main questions that CTOs/coaches at Maker's Academy ask themselves when looking over your code:

## Has it matched the specification?

This is crucial and should be the first thing you think about. Look over the specification and as you go about the process of designing your submission, constantly think about what is being asked of you and whether you are fulfilling the criteria specified. Your tests will help you here - the specs you should be writing (particularly your feature tests) should be fulfilling exactly what the brief asks us.

Once you're sure of this, make sure you've explained in your README (only briefly, it doesn't have to be an essay) how you answered the brief and explain any decisions you made when desigining/building your code.

## CI - Has it passed Continuous Integration)?

We use [Travis](https://travis-ci.org) to make sure your tests are passing - make sure you've got a `travis.yml` set up and configured. You should also have set up Travis on your own repo and added a [status badge](http://docs.travis-ci.com/user/status-images/) to your README.

## OOD - How well-designed is it?

We want to see that your code has been well-thought through in terms of design. This generally means that you've modelled the problem well and have designed your objects well so that they all do just one thing and do that one thing well.

### Resources

* ([This article] explains the importance of modelling as a way of thinking
* [POODR](poodr.info) by Sandi Metz is the best resource out there for understanding OOD

## OOP - Are your objects SOLID?

Whether coding in JavaScript or Ruby one of the primary things we're looking for you to show us is that you understand OOP when writing these tests. So always be thinking about whether your objects are SOLID - in particular that they satisfy the Single Responsibilty Principle where each object **does no more than what is responsible for**. 

When thinking about this you just need to ask when adding a method to an object - "should this object be responsible for this action?" . If it doesn't make sense in real life - let's say you're telling a `Car` object they should be responsible for fixing themselves, which doesn't make sense - then it doesn't make sense in your code.

Another important consideration is **encapsulation** - in short this means you hide what your object is doing inside of the object and don't expose it to the outside world. In practice this means don't doing something like this:

```ruby
user.friends.map(&:name)
```

Instead properly encapsulate the logic inside a method in your user object:

```ruby
user.friend_names
```

### Resources

* [SOLID in Ruby](https://www.groupbuddies.com/posts/19-solid-principles-in-ruby)
* [More on the Single Responsibility Principle](http://jjbohn.info/blog/2014/07/28/single-responsibility-principle-a-solid-week/)
* [Why care about encapsulation?](http://gmoeck.github.io/2011/09/20/why-you-should-care-about-encapsulation.html)

## TDD - How well tested is it?

All your code should be written test-first, with feature tests testing your higher-level logic, and then unit tests used to drive the development of your individual objects.

Ensure that the tests are well-written and read well when printed out in documentation format (in rspec you run `rspec -fd`) to see this and should follow the [better specs guidelines](http://betterspecs.org/).

Also ensure that you are correctly using [doubles/mocks](https://github.com/makersacademy/course/blob/master/pills/doubles.md):pill: when required, particularly to stop your feature tests hitting external APIs.

### Resources

* [Better specs guidelines](http://betterspecs.org/)

## MVC - Have you understood how to build an MVC app properly?

To consider how to build an app properly, generally you need to be just applying to the Single Responsibility Principle
* OOD
* OOP
* TDD
* MVC
* DRY
* KISS
* YAGNI
* POLA
