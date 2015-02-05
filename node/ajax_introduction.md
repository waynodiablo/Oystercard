AJAX Introduction
========

***Please note, as with all Makers Academy materials, there may be subtle errors in the following materials.  Please try to approach those as challenges on which to polish your debugging skills - pull requests always welcome.***

*Many thanks to [Alex Peattie](https://github.com/alexpeattie) for the design of this walkthrough*

AJAX is a browser technology that allows the browser to request data from a server without involving a page refresh:

![ajax diagram](http://www.codeproject.com/KB/showcase/FarPointAJAX/AJAX_process.jpg)

Let's see an example of how we might use it to create an app that will pull a github user profile off github and display that in a page for us.  This involves some simple css and html:

```html
<html>
  <head>
    <title>Github profiles</title>
    <link href='github.css' rel='stylesheet'>
  </head>
  <body>
    <form id='add_profile'>
      <input id='username' placeholder='Enter a Github username'>
      <button type='submit'>Load profile</button>
    </form>

    <div class='profile-container'>
      <div class="profile">
        <div class="left">
          <img src="https://avatars.githubusercontent.com/u/5008648?">
        </div>

        <div class="right">
          <h3>
            <a href="https://github.com/tansaku">
              tansaku
            </a>
          </h3>
          <h4>Repos: 120</h4>
          <h4>Followers: 122</h4>
        </div>
        <br clear="all">
      </div>
    </div>

    <script src='https://code.jquery.com/jquery-2.1.1.min.js'></script>
  </body>
</html>
```

which simply has a form and a profile container that gets used to show the profiles.  At the moment this is all static HTML, nothing dynamic at the moment.

```css
input, button {
  font-size: 20px;
  padding: 5px;
}

input {
  width: 510px;
}

.profile {
  background: #606c88;
  background: linear-gradient(to bottom,  #606c88 0%,#3f4c6b 100%);
  width: 600px;
  padding: 20px 20px 10px 20px;
  font-family: Helvetica Neue;
  border-radius: 15px;
  color: #fff;
  margin-bottom: 20px;
}

.profile a {
  color: #fff;
}

.profile .left {
  width: 110px;
  float: left;
}

.profile .right {
  width: 450px;
  float: left;
  padding: 0 20px;
}

.profile .right h3 {
  margin-top: 0;
}
.profile img {
  width: 100%;
}
```

This CSS above makes it all look a bit nicer.

Now given that we want to grab some data dynamically from across the network we'll need to use some mechanism to do that.  Any ideas?

An HTTP GET request is a good way to get things over the network.  It's the universal language of the web.  The technology we are going to use to make this request from within the JavaScript environment is AJAX. As mentioned above AJAX allows the browser to grab data across the network without a complete page reload.  

Let's look at a very simple web server that we can use to make a request to.  If we were using ruby we might be tempted to quickly create a sinatra app like so:

```ruby
require 'sinatra'

get '/' do
  response['Access-Control-Allow-Origin'] = '*'
  Time.now.to_s
end
```

or equivalently if we were using javascript server side via node, we might create a little express app like so:

```javascript
var app = require('express')();
var server = require('http').createServer(app);
var port = 9999;

app.get('/', function(req, res){
  res.header("Access-Control-Allow-Origin", "*")
  res.json(new Date);
});

server.listen(port, function(){
  console.log('server running on port ' + port);
});
```

In either case we need the 'Access-Control-Allow-Origin' set so that we can receive requests from any site.  This is because yuo usually can't make AJAX requests except back to the site that originally served the page.  If we don't include this we'll get an error like the following:

```
XMLHttpRequest cannot load http://localhost:4567/. No 'Access-Control-Allow-Origin' header is present on the requested resource. Origin 'null' is therefore not allowed access.
```

From the point of view of creating a micro-web service, the two alternative chunks of code above are completely identical.  They both create a simple time server, which we can see running in the browser if we fire them up and connect via the appropriate port.  If we are using Sinatra then by default we are on port 4567 and we browse to http://localhost:4567/.  The express app above runs on port 9999 so browse to http://localhost:9999/.

In order to see how we can make an AJAX request we can run JavaScript in the browser console and see the results. Before we do that, it's a good idea to add AJAX logging so we can view every request as it happens in the console. To do this in Chrome open the developer tools, click on the cog icon on the right-hand side and tick "Log XMLHttpRequests" (XMLHttpRequest is the old-fashioned name for AJAX):

![ajax settings](https://cloud.githubusercontent.com/assets/208986/5243775/ebdd1730-793f-11e4-9a89-8150a4b6b92c.png)

Now we can test AJAX using the [jQuery $.get method](http://api.jquery.com/jquery.get/) and see the request and response logged:

```javascript
var request = $.get('http://localhost:4567')
```

If we run the above code from the console we can inspect the request object and see what we got back:

```sh
> var response = $.get('http://localhost:4567')
<- undefined
> response
<- Object {readyState: 4, getResponseHeader: function, getAllResponseHeaders: function, setRequestHeader: function, overrideMimeType: function…}
```

and we can access the time string that the server returned in request.responseText.

```sh
> response.responseText
<- "2014-12-02 06:36:29 +0000"
```

Note that we can't do the following:

```javascript
$.get('http://localhost:4567').responseText
undefined
```

Since that will give us 'undefined' and we've seen this issue before.  We're trying to get the responseText before the AJAX request has completed.  We can see in the network tab that although these network requests return very fast on our own computer, of the order of milliseconds, this is still slow from the point of view of the almost instantly running 'responseText' method call.  How can we get round this issue?

The answer is callbacks as we've seen before. We need something like the following:

```javascript
$.get('http://localhost:9393',function(responseText){
  alert(responseText);
})
```
We can also tweak our server to see the effect of a slow network connection a little more prominently:

```ruby
require 'sinatra'

get '/' do
  response['Access-Control-Allow-Origin'] = '*'
  sleep 2 # how to do this in node???
  Time.now.to_s
end
```

And now we can see the noticeable time delay before we get a response.  So AJAX is just a browser technology that allows the browser to make an HTTP request without having to do a page refresh.  Note that we can get a lot more information than just the time from the server, we can get all the details about the response such as status code, headers etc.

So now with AJAX we can have JavaScript consume remote APIs (Application Programming Interfaces).  An API can refer to both the public methods on a library that we've installed and we call directly, or those remote end points that we can reach via an HTTP request.  We can see an example of a remote API by looking at something like https://api.github.com/users/tansaku which will give us a JSON (JavaScript Object Notation) format view of data about user 'tansaku'.  Contrast this with the information that we get looking at https://github.com/tansaku.

Note that we do need to be aware of the versions of APIs in that companies will often evolve their HTTP accessible APIs and so you won't be able to rely on things continuing to work indefinitely.

To make our Github profile app dynamic, let's get our user profile information via jquery in a script tag after we've loaded our jQuery library:

[TODO - break out into separate JavaScript file AND WHAT ABOUT TEST FIRST?]

```javascript
$(document).ready(function(){
  $.get('https://api.github.com/users/tansaku',function(user){
    // blah blah
  })
});
```

So what do we need to do in the AJAX callback here?  We need to merge the data coming from the remote API with the HTML that we have.  We could grab html elements and append or prepend things to do them but it's going to get messy.

This is a great time to use a JavaScript templating system like [mustache.js](http://github.com/janl/mustachejs). So we need to take our profile and turn it into a mustache template that we can merge with the data that we get from our remote service:

```html
<html>
  <head>
    <title>Github profiles</title>
    <link href='github.css' rel='stylesheet'>
  </head>
  <body>
    <form id='add_profile'>
      <input id='username' placeholder='Enter a Github username'>
      <button type='submit'>Load profile</button>
    </form>

    <div class='profile-container'>
    </div>

    <template id='profile-template'>
      <div class="profile">
        <div class="left">
          <img src="{{ avatar_url }}">
        </div>

        <div class="right">
          <h3>
            <a href="{{ html_url }}">
              tansaku
            </a>
          </h3>
          <h4>Repos: {{ public_repos }}</h4>
          <h4>Followers: {{ public_followers }}</h4>
        </div>
        <br clear="all">
      </div>
    </template>

    <script src='https://code.jquery.com/jquery-2.1.1.min.js'></script>
    <script>
    $(document).ready(function(){
      $.get('https://api.github.com/users/tansaku',function(user){
        // blah blah
      })
    });
    </script>
  </body>
</html>
```

The template tag will be ignored by the browser, and we've inserted moustaches "{{" and "}}" in the same way that we use "<%" tags in erb so that we can take the template and merge data with it to create HTML that can be displayed in the user's browser.


So the line that we need to make this wrk is the Mustache.render command:


```javascript
$(document).ready(function(){
  $.get('https://api.github.com/users/tansaku',function(user){
    var newProfile = Mustache.render($('#profile-template').html(), user);
    $('.profile-container').append(newProfile);
  })
});

```

The above is correct code, but does not work for some reason.  Can you work out why?   Try running it and checking for console errors.

The reason is that we haven't added the mustache library;
<script src='https://cdnjs.cloudflare.com/ajax/libs/mustache.js/0.8.1/mustache.js'></script>

and then that should work :-)

Check http://publicapis.com for a list of other APIs that we can grab data from.  These are very popular for hackathons and mashups (where we mix data from a couple of apis).

Exercises
--------

* What are the drawbacks of using the AJAX approach compared to a full page refresh?  Discuss with your pair partner.
* See if you can make the form work so that the user can request a github profile via the github user name
* **Optional** See if you can do an AJAX request without jQuery

Resources
--------

* [AJAX Cross-Site Security Diagram](https://docs.google.com/drawings/d/1v5pmO8m9W7m5FvWmi4xZ4_72FWb2-JyQMKaPkk_0Y9I/edit)
* [Updated Address Bar with JavaScript](http://stackoverflow.com/questions/3338642/updating-address-bar-with-new-url-without-hash-or-reloading-the-page)
* [How to access GET params in JavaScript](http://stackoverflow.com/questions/5448545/how-to-retrieve-get-parameters-from-javascript)
*
[Video of Sam on Ajax](https://www.youtube.com/watch?v=zrnKg5TyXjY)
