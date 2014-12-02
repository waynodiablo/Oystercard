Github Profile Report - Consuming APIs with JavaScript and JavaScript MVC
=========================================================================

This week's project involves using JavaScript to consume data available from third parties over the network (e.g. Github API data accessed via Ajax) and using more advanced JavaScript Model View Controller (MVC) frameworks such as AngularJS.

![Gundam Cat](https://developer.github.com/images/gundamcat.png)

***Please note, as with all Makers Academy materials, there may be subtle errors in the following materials.  Please try to approach those as challenges on which to polish your debugging skills - pull requests always welcome.***

*Many thanks to [Alex Peattie](https://github.com/alexpeattie) for the original design of the Ajax material and [Antony Denyer](https://github.com/antonydenyer) for the Angular material*

Version 1 - Ajax
----------------

Let's create a simple Github Profile app purely in client side JavaScript that grabs data from the [Github API](https://developer.github.com/v3/) in order to display specified users avatar, number of followers and number of repos.  [jQuery](http://jquery.com/) will be useful for this, as will a templating library like [Mustache](https://github.com/janl/mustache.js/).

We'd like the interface to look something like this:

![Github Profile Interface](https://www.dropbox.com/s/a7gtmr7blpkq0lz/Screenshot%202014-12-02%2008.35.36.png?dl=1)

Try to get just the profile generated first using hard coded html, then move on to adding jQuery and templating.  Please ensure that this version can be deployed to Heroku.

Version 2 - Usability
----------------

Let's adjust the simple profile application to ensure that it gives a good user experience even under poor network connectivity, and let's the user know when searches for users have failed or the network connection has timed out.  Please ensure that this version can be deployed to Heroku.

Here's an example of a message indicating we can't find a particular user:

![user not found](https://www.dropbox.com/s/r4gamssxfj3hgog/Screenshot%202014-12-02%2008.39.45.png?dl=1)

And here's an example of an animated spinner that can be shown to indicate that the network connection is in progress:

![spinner](http://traindaze.com/assets/images/loader.gif)

Version 3 - MVC
----------------

Recreate the MVP using AngularJS MVC. Again, please ensure that this version can be deployed to Heroku.

Version 4 - Report Card
----------------

Adjust the application to display a Makers Academy progress report for the user in question, including at least #commits on each relevant Github Repo.

Version 5 - Bonus Level
----------------

Include further checks such as creating %completion based on expected number of commits, code smells, SOLID principles etc.

Related Walkthoughs
---------------

* [AJAX Introduction](https://github.com/makersacademy/Walkthroughs/blob/master/ajax_introduction.md)
* [AJAX and More jQuery](https://github.com/makersacademy/Walkthroughs/blob/master/ajax_with_extra_jquery.md)

## Resources

#### Ajax

* http://en.wikipedia.org/wiki/Ajax_%28programming%29
* http://app-01.codecademy.com/courses/javascript-beginner-en-g7vdk/0/1
* http://api.jquery.com/jquery.ajax/
* http://www.w3schools.com/ajax/

#### AngularJS

* http://campus.codeschool.com/courses/shaping-up-with-angular-js/contents 
* https://docs.angularjs.org/tutorial

