#Node, APIs and Ajax

:construction: **[UNDER CONSTRUCTION]** :construction:

Welcome to Node! This week, you will be learning how to build responsive applications using JavaScript across the whole stack. At the end of the week you will have built your own version of the remotely accessible Github API (Application Programming Interface), as well as used Ajax to access it dynamically from the browser.


<a href='https://developer.github.com/'><img src='https://developer.github.com/images/gundamcat.png' align="left" height="128" width="128" alt='Gundam Cat'></a>
<br clear='all'>


**Please note, as with all Makers Academy materials, there may be subtle errors in the following materials. Please try to approach those as challenges on which to polish your debugging skills - pull requests always welcome.**

##Version 1 - Welcome to Node

Before we get into APIs, we need to be able to build a basic server. But before we build a web server, we need to understand what Node is and how to get started.
Check out the [Introduction to Node](https://github.com/makersacademy/course/blob/master/node/intro_to_node.md) walkthrough to get started, then, when you have finished, check out [Node good practices](https://github.com/makersacademy/course/blob/master/node/node_good_practices.md).

##Version 2 - A basic server

Next, let's get a server running, with tests: [A basic Node server](https://github.com/makersacademy/course/blob/master/node/basic_node_server.md).  

![Hello world](/images/hw.png)
![Tests passing!](/images/testpass.png)

Now that we have a server, we want to be able to display dynamic content, as well as be able to configure our server's routes:
[Express, `ejs` and middleware](https://github.com/makersacademy/course/blob/master/node/express_ejs.md)

##Version 3 - Let's get an API up and running

Putting together all that we've done so far we should be able to create a tested API endpoint that simulates at least part of the Github API.  Below is an example set up with auto server restart dyanmic routes and ejs views.

https://github.com/tansaku/github_api_simulation

Please ensure that you are able to get something similar running.

##Version 4 - Let's consume that API dynamically with Ajax

We can get data from the real Github API, or our own simulation, by opening a browser window and sending a request.  But what if we want to load that information dynamically into a web page without a page refresh?  One possibility is an Asynchronous JavaScript and XML (AJAX) request.  Follow the [Ajax Introduction](https://github.com/makersacademy/course/blob/master/node/ajax_introduction.md) to learn more.  Then make sure you complete [Ajax with Extra JQuery](https://github.com/makersacademy/course/blob/master/node/ajax_with_extra_jquery.md) and if you want more JQuery magic then check out [Ajax JQuery Spinners](https://github.com/makersacademy/course/blob/master/node/ajax_jquery_spinners.md).

Resources:
--------
* http://youmightnotneedjquery.com/ <-- comparison of jQuery and plain javascript

###Related walkthroughs

**Version 1:**  

 * [Introduction to Node](https://github.com/makersacademy/course/blob/master/node/intro_to_node.md)
 * [Node good practices](https://github.com/makersacademy/course/blob/master/node/node_good_practices.md)

**Version 2:**  

* [A basic Node server](https://github.com/makersacademy/course/blob/master/node/basic_node_server.md)
* [Express, `ejs` and middleware](https://github.com/makersacademy/course/blob/master/node/express_ejs.md)

**Version 3**:  

* See commit log of https://github.com/tansaku/github_api_simulation/commits/master

**Version 4**:  

* [Ajax Introduction](https://github.com/makersacademy/course/blob/master/node/ajax_introduction.md)
* [Ajax with Extra JQuery](https://github.com/makersacademy/course/blob/master/node/ajax_with_extra_jquery.md)
* [Ajax JQuery Spinners](https://github.com/makersacademy/course/blob/master/node/ajax_jquery_spinners.md)


![Tracking pixel](https://githubanalytics.herokuapp.com/course/pills/node2.md)
