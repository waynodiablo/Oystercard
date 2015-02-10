Choosing Technologies for Your Project
======================================

:construction: UNDER CONSTRUCTION :construction:

> It doesn't matter what technology you choose for your project ... probably -- Leo Allen

Now clearly in the end the technology can make a difference, but the reason to turn this grey area into an extreme is to fight against the common tendency to believe that it is critical to select the correct technology up front.  Note that it is very uncommon that a technology project will fail because of the selected programming language; it is much more likely to fail due to database constraints, API access and other kinds of architectural issues.  This is because programming languages fundamentally do the same thing.  They have different syntaxes which will have relative pros and cons for expressing particular logic and domain models, but these differences tend to be outweighed by programmers experience in a particular language and framework.

Our general advice would be choose the language and framework that you are most comfortable with, and then prototype in that language.  One common argument that is rolled out is the Twitter ran into problems with their initial use of Rails and had to switch to a different framework.  However there initial problem was a database related [N+1](http://use-the-index-luke.com/sql/join/nested-loops-join-n1-problem) issue, and the key takehome is that Twitter managed to prototype a great app with Rails, managed to get themselves off the ground.  At scale programming languages and frameworks become more of an issue, but it would generally be a mistake to pre-optimise for scale when you have yet to scale your app.  To start with it is much more important to speed prototype a proof of concept, tan to be trying to select the speediest language/framework from day one.



Resources
--------

* [Programmers Stack Exchange on How to Choose](http://programmers.stackexchange.com/questions/125306/how-to-choose-the-most-suitable-technologies-for-your-project)
