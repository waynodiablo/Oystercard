# Preparing Your Code For Review

>This pill is basically a summary of [this talk](https://youtu.be/uqf4vG2L95Q). The [slides for the talk](https://slides.com/leoallen/code-reviews) are available if you want a brief overview of the talk. 

This pill is designed to act as a set of guidelines for writing your challenges/tech tests.

Below are the main questions that CTOs/coaches at Maker's Academy ask themselves when looking over your code. Remember when writing your code that you **should always be thinking about your code from the perspective of someone reviewing it**.

## Summary of Guidelines

* [Has it matched the specification?](#has-it-matched-the-specification)
* [Is it clean code?](#is-it-clean-code)
* [CI - Has it passed Continuous Integration](#ci---has-it-passed-continuous-integration)
* [OOD - How well-designed is it?](#ood---how-well-designed-is-it)
* [OOP - Are your objects SOLID?](#oop---are-your-objects-solid)
* [TDD - How well tested is it?](#tdd---how-well-tested-is-it)
* [MVC - Have you understood how to build an MVC app properly?](#mvc---have-you-understood-how-to-build-an-mvc-app-properly)
* [DRY](#other-considerations)
* [KISS](#other-considerations)
* [You Aren't Gonna Need It](#other-considerations)
* [Principle of Least Astonishment](#other-considerations)

## Has it matched the specification?

This is crucial and should be the first thing you think about. Look over the specification and as you go about the process of designing your submission, constantly think about what is being asked of you and whether you are fulfilling the criteria specified. Your tests will help you here - the specs you should be writing (particularly your feature tests) should be fulfilling exactly what the brief asks us.

Once you're sure of this, make sure you've explained in your README (only briefly, it doesn't have to be an essay) how you answered the brief and explain any decisions you made when desigining/building your code.

## Is it clean code?

Being a clean coder is what every coder aspires to be - Uncle Bob [wrote a whole book about it](http://www.amazon.co.uk/Clean-Code-Handbook-Software-Craftsmanship/dp/0132350882). There are many things to consider as a clean coder, but at a minimum take a look through your code and ask yourself:

* Is this code presentable? Am I proud to show it off to others?
* Have I cleaned up things like whitespace, commented-out code, debugger statements from my code?
* Does the indentation look right?
* Have I conformed my code to styleguide rules (Hound will help you out here)?
* Is it clear to someone unfamiliar with my codebase what's going on?

This is only the very basic minimum of what it means to be a clean coder, but it's a great start and you'd be surprised how much things like this are appreciated by your fellow coders!

### Resources

* [A summary of the Clean Coder book](http://www.integralist.co.uk/posts/clean-coder.html)

## CI - Has it passed Continuous Integration?

We use [Travis](https://travis-ci.org) to make sure your tests are passing - make sure you've got a `travis.yml` set up and configured. You should also have set up Travis on your own repo and added a [status badge](http://docs.travis-ci.com/user/status-images/) to your README.

## OOD - How well-designed is it?

We want to see that your code has been well-thought through in terms of design. This generally means that you've modelled the problem well and have designed your objects well so that they all do just one thing and do that one thing well.

### Resources

* ([This article](http://www.chris-granger.com/2015/01/26/coding-is-not-the-new-literacy/) explains the importance of modelling as a way of thinking
* [POODR](http://www.poodr.com/) by Sandi Metz is the best resource out there for understanding OOD

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
* [Testing from the outside in](https://robots.thoughtbot.com/testing-from-the-outsidein)

## MVC - Have you understood how to build an MVC app properly?

To consider how to build an app properly, generally you need to be just applying to the Single Responsibility Principle to each component. This means that:

* **Views** - Only handle things to do with presenting your output to the user (basically the HTML), minimise as much as possible logic in the views.
* **Controllers** - The controller should be as skinny as possible, it should ideally take any request params, pass them to your models/libraries, and pass those to the view **and nothing else**. This is extremely important, fat controllers are one of the surest signs that someone has failed to grasp MVC.
* **Models** - The model should contain everything related to your data-layer. Remember these don't have to be just for accessing a database, you could and should write model objects for accessing APIs. And remember to encapsulate (see above) all logic that relates to your model **inside** the model and **unit test** it.

### Resources

* You can go even further than fat models/skinny controllers and aim for [Forget fat models: it’s time for skinny controllers and skinny models](https://medium.com/makers-academy/forget-fat-models-its-time-for-skinny-controllers-and-skinny-models-a9b84ec481b7#.8vs2uzw1f)
* One way we sometimes useto take our code even further is using [Service Objects](https://robots.thoughtbot.com/skinny-controllers-skinny-models)
* There's even more solutions to improving your approach to MVC [in this article on 7 ways to decompose fat models](http://blog.codeclimate.com/blog/2012/10/17/7-ways-to-decompose-fat-activerecord-models/)

## Other considerations

* [DRY](http://en.wikipedia.org/wiki/Don't_repeat_yourself) - Avoid repetition in your code, extract into functions/objects/modules and refactor whenever you see this in your code.
* [KISS](http://www.computerhope.com/jargon/k/kiss.htm) - Always aim for the simplest solution to your problem, it is almost always the best solution.
* [You Aren't Gonna Need It](http://en.wikipedia.org/wiki/You_aren%27t_gonna_need_it) - Only add things to your code that you're actually doing and solve the problem at hand, don't add anything more than you need to, we are always looking for people who can KISS and build an MVP rather than build unneccesary things that don't solve anything.
* [Principle of Least Astonishment](http://programmers.stackexchange.com/a/187462) - Does your code do what someone would expect it to? Are you finding there a lots of comments where you have to explain yourself? If so you need to refactor your code so it is self-evident what is going on wherever possible.
