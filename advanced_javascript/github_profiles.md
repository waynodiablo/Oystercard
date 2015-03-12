#Week 7 - Advanced JavaScript

:construction: UNDER CONSTRUCTION :construction:

Congratulations on reaching Week 7 and attaining senior cohort status! From this point on, you will notice that there is far less 'scaffolding' in the walkthroughs. It is assumed that on reaching this stage in the course you are more familiar with technical language, reading documentation and utilising resources such as [Stack Overflow](http://stackoverflow.com/), your byte group and your pair. Whilst we will still structure your learning with learning objectives, resources and challenges, we encourage you to go 'off the beaten track'. Feel free to explore interesting frameworks and side projects - as long as you are working in a pair, anything goes!

![Gundam Cat](https://developer.github.com/images/gundamcat.png)

##Github Profiles

This week's project is to create a simple Github Profile app purely in JavaScript that grabs data from the [Github API](https://developer.github.com/v3/) in order to display a specified users avatar, number of followers and number of repos.

The project will involve using JavaScript to consume data available from third parties over the network (e.g. Github API data accessed via Ajax) and using more advanced JavaScript Model View Controller (MVC) frameworks such as AngularJS. 

***Please note, as with all Makers Academy materials, there may be subtle errors in the following materials.  Please try to approach those as challenges on which to polish your debugging skills - pull requests always welcome.***

*Many thanks to [Alex Peattie](https://github.com/alexpeattie) for the original design of the Ajax material and [Antony Denyer](https://github.com/antonydenyer) for the Angular material*

[Note also that the initial code for step one of this walkthrough is available in https://github.com/makersacademy/angularjs-intro]

###Knowledge

Make sure you have worked through these pills before commencing the walkthrough:

* :pill: [npm](https://github.com/makersacademy/course/blob/master/pills/npm.md)
* :pill: [bower](https://github.com/makersacademy/course/blob/master/pills/bower.md)
* :pill: [grunt](https://github.com/makersacademy/course/blob/master/pills/grunt.md)
* :pill: [angularjs](https://github.com/makersacademy/course/blob/master/pills/angularjs.md)

###Step 1

To get started using Angular, we are going to build a simple Github user search.  
To do this we're going to be using [Github's API](https://developer.github.com/v3/search/#search-users).
Be careful when using this endpoint, [it's heavily rate limited](https://developer.github.com/v3/search/#rate-limit). It is recommended that you [register](https://github.com/settings/applications) a new github application to avoid the rate limit.

Also in this walkthrough we're going to build a simple Angular application that demonstrates a few simple concepts:
* Two-way data-binding
* Dependency injection

In addition we're going to be introducing [bower](http://bower.io/), a package manager for the web.
