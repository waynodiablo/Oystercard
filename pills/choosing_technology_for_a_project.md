Choosing Technologies for Your Project
======================================

:construction: UNDER CONSTRUCTION :construction:

> It doesn't matter what technology you choose for your project ... probably -- Leo Allen

Now clearly in the end the technology can make a difference, but the reason to turn this grey area into an extreme as Leo does in the quote above is to fight against the common tendency to believe that it is critical to select the correct technology up front.  Note that it is very uncommon that a technology project will fail because of the selected programming language; it is much more likely to fail due to database constraints, API access and other kinds of architectural issues.  This is because programming languages fundamentally do the same thing.  They have different syntaxes which will have relative pros and cons for expressing particular logic and domain models, but these differences tend to be outweighed by programmers experience in a particular language and framework.

Our general advice would be choose the language and framework that you are most comfortable with, and then prototype in that language.  One common argument that is rolled out is that Twitter ran into problems with their initial use of Rails and had to switch to a different framework.  However their initial problem was a database related [N+1](http://use-the-index-luke.com/sql/join/nested-loops-join-n1-problem) issue, and the key take home message should be that Twitter managed to prototype a great app with Rails, and critically managed to get their enterprise off the ground; which is more important than anything else.  At scale, programming languages and frameworks do become more of an issue, but it would generally be a mistake to pre-optimise for scale when you only have a few users.  To start with it is much more important to speedily prototype a proof of concept, than to be trying to select the speediest language/framework from day one.

If you want speed you can argue that you should be programming a lower level language like C, or possibly in assembler, or even machine code.  However, premature optimization of this kind is usually a way to prevent yourself from creating a successful prototype that validates the utility of what you are trying to build.  That said you should always be reflecting on the value of the tools you are using, which includes the programming languages, the frameworks, the testing methodologies, the pair programming methods, the team management, everything.  While you don't want to be chopping and changing every day, the critical thing is to be examining how the different choices you are making are impacting your progress towards your goals.  

One question that often comes up when doing a new project at Makers is whether one should choose a technology that challenges you in order to "learn more" versus choosing something one is more familiar with.  In response to this perceived conflict it may be useful to ask what stakeholder we are serving by building anything?  Let's say we are building some application that collects pictures of cats eating fruit (or whatever); the real question is who wants that?  Who needs it?  If there is someone who wants that (whatever thing it happens to be) and we can show a prototype of it to them and get their feedback, and then make a change based on that and repeat; then arguably that is the most exciting process in the world, far more exciting than any particular technology; and this is at the heart of the Agile development method.

Even so one might be saying 'Ooh Node is really cool, I really want to learn it, but I might go a bit slower in it than in Ruby' which is fair enough, but still the Agile loop is critical.  Experience indicates that trying to build something for some stakeholder (even if it's yourself) and iterating through the feedback loop in order to make changes and improve the product will drive your learning process much faster than simply playing around with things.  Not that you shouldn't play with things sometimes, but the process of trying to work out how to make a change to support something that someone wants is far more engaging, and forces you to understand a technology or framework in a particular way.  If you're just playing, then anything that seems hard, well you just maybe go another route.  If you are trying to deliver value to a stakeholder you get to play a different game that allows you to question whether a particular language, framework or technique is actually useful in a particular context.  Working out how to deliver value is the key thing that distinguishes just playing from professional development activity.

In summary, the best learning takes palce when there is a need to learn something to achieve some higher purpose - this will push you to learn quickly.  Think about why someone is going to use your product - and use that to help guide your whole process, including the tools you use.

Technology Notes
--------

* Rails - large, magic, great for rapid prototyping - traditional MVC - great for lots of web forms storing data in database. Good for internationalization.  Can give you sturdy website up to a few million users.  It is a sledgehammer.  Lots of gems to do things for you.  Good for testing.  Examples of things to build: KickStarter, Twitter

* Sinatra - lightweight, simple to get working straight out of the box.  Good for testing.  Examples of things to build: Netflix API, Invisible Hand

* NodeJS - fast and non-blocking IO, but don't prematurely optimize for speed - not yet such a mature technology - unclear what the best practices are. Node not so good a match with OOP - more it's functional programming patterns.  It is lightweight, like unix commands.  Not so good for testing. Good for streams, e.g. websockets, lots of files, Example Apps: Chat Server

* Sails - Rails for Node

* Angular/Backbone/Ember - particularly Angular: great documentation by Google, once you understand the concepts you can build a single-page app very quickly. You need to use another technology for an API = complex (could use Rails/Sinatra/Node for that). Can also just use it as a javascript framework - they're quite new and adds complexity to your app.

* Meteor - front end and backend framework all javascript

* PHP - WTF

* Clojure - Big data

* Python - Big data, science, web, anything if you like Python

* Mixing technologies == Mixing Drinks

* Choose your stack ideally one that has been used before and is more mature

* When starting - think of the product first, do user journeys, what does the user need, wireframe/sketch first.

Also remember MVP is Minimum and Viable (people often forget one), you could even split the team in two, one is "Minimum" and the other is "Viable" and you can bounce the concepts back and forward until you have an awesome product.

Resources
--------

* [Programmers Stack Exchange on How to Choose](http://programmers.stackexchange.com/questions/125306/how-to-choose-the-most-suitable-technologies-for-your-project)
* [Programming Languages as Weapons](http://bjorn.tipling.com/if-programming-languages-were-weapons)
* [Original Wiki Page](https://github.com/makersacademy/course/wiki/Choosing-Technology-For-a-Project)
