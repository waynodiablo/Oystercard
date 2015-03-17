#Week 7 - Further JavaScript

:construction: UNDER CONSTRUCTION :construction:

***Please note, as with all Makers Academy materials, there may be subtle errors in the following materials.  Please try to approach those as challenges on which to polish your debugging skills - pull requests always welcome.***

*Many thanks to [Alex Peattie](https://github.com/alexpeattie) and [Tansaku](https://github.com/tansaku) for the original design of the Ajax material and [Antony Denyer](https://github.com/antonydenyer) for the Angular material*

Congratulations on reaching Week 7 and attaining senior cohort status! From this point on, you will notice that there is far less 'scaffolding' in the walkthroughs. It is assumed that on reaching this stage in the course you are more familiar with technical language, reading documentation and utilising resources such as [Stack Overflow](http://stackoverflow.com/), your byte group and your pair. Whilst we will still structure your learning with learning objectives, resources and challenges, we encourage you to go 'off the beaten track'. Feel free to explore interesting frameworks and side projects - as long as you are working in a pair, writing tests and writing clean code, (pretty much) anything goes!

![Gundam Cat](https://developer.github.com/images/gundamcat.png)

##Github Profiles

This week's project is to create a simple Github Profile app purely in JavaScript that grabs data from the [Github API](https://developer.github.com/v3/) in order to display a specified users avatar, number of followers and number of repos.

The project will involve using JavaScript to consume data available from third parties over the network (e.g. Github API data accessed via Ajax) and using more advanced JavaScript Model View Controller (MVC) frameworks such as AngularJS. 

The project will need to be deployed to Heroku, and the choice of back-end server is up to you: Node for the brave, Ruby for the stable.

Here's a wireframe of one possible design:

![GitHub profile viewer](https://makersacademy.mybalsamiq.com/mockups/2895691.png?key=afabb09aef2901a2732515ae4349c1ec0458294b)

**Experimentation is encouraged - the guides below are a suggestion, not an absolute. How you achieve the final goal is up to you.**

###Knowledge

Make sure you have worked through these pills before starting:

* :pill: [The JavaScript ecosystem](https://github.com/makersacademy/course/blob/master/pills/javascript_ecosystem.md)
* :pill: [npm](https://github.com/makersacademy/course/blob/master/pills/npm.md)
* :pill: [bower](https://github.com/makersacademy/course/blob/master/pills/bower.md)
* :pill: [grunt](https://github.com/makersacademy/course/blob/master/pills/grunt.md)
* :pill: [angularjs](https://github.com/makersacademy/course/blob/master/pills/angularjs.md)

##Version 0 - jQuery prototype

Let's have a look at a quick prototype of what we will be trying to build, and discuss why we might want to use a framework to achieve the same goals: 

* [jQuery prototype](https://github.com/makersacademy/course/blob/master/further_javascript/jquery.md)

##Version 1 - Angular

* [Github profiles with Angular walkthrough](https://github.com/makersacademy/course/blob/master/further_javascript/angularjs.md)  

##Version 2 - Deploying to Heroku

Now we have a working, usable application, lets deploy to Heroku so that it can actually be used. In order to do this, you will need to build a simple server - you could use Node Express or Sinatra.

If you want to try Node, have a look at these resources:

* :pill: [node](https://github.com/makersacademy/course/blob/master/pills/node.md)
* [Node guide](https://github.com/makersacademy/course/blob/master/node_guide.md)

If you are deploying with Sinatra, you may want to read this:

* [Deploying your Sinatra/Angular application to Heroku](https://github.com/makersacademy/course/blob/master/pills/deploying_angular_sinatra.md)

##Version 3 - Report Card

Adjust the application to display a Makers Academy progress report for the user in question, including at least #commits on each relevant Github Repo.

##Version 4 - Bonus Level

Include further checks such as creating %completion based on expected number of commits, code smells, SOLID principles etc.

##Version 5 - You're a masochist

Redo everything in Coffeescript (or DogeScript)
