#EJS Templating Engine

Many thanks to [Spike](http://github.com/Spike01) for the original design this component

**As with all Makers Academy materials, there may be subtle errors in the following materials. Please try to approach those as challenges on which to polish your debugging skills - pull requests always welcome.**

We now have a tested server running, but we're only sending strings directly to our routes. Obviously, this is not ideal - what would be perfect is something like an `erb` file. Enter `ejs` - [embedded JavaScript](http://www.embeddedjs.com/).

##`ejs`

`ejs` works almost exactly like `erb`, even down to the use of `<% %>` tags. However, unlike `.erb` and like all things Node, it doesn't come preinstalled with Express. As always, run `npm install --save ejs` to install and add it to your dependencies. You will also need to specify that you are using `ejs` as your templating engine, otherwise Express will not be able to render. While we're here, we can also specify a public folder, otherwise Express will not be able to serve any static content.

###Don't forget to always write a test first - while it may seem trivial for small changes in your views, as the complexity of your app increases, those tests will make sure that everything is behaving correctly. 

`server.js`
```javascript
//usually, these lines will appear under all your requires

app.set('view engine', 'ejs');
app.use(express.static(__dirname + '/public'));
```

We can now create `ejs` templates in a `views` folder, and render them in our routes dynamically:

`server.js`
```javascript

app.get('/', function(request, response){
  response.render('index');
});
```

And, just like `erb`, we can also pass data to the views, and do some basic logic (emphasis on basic - keep as much logic as possible away from the views!)

`server.js`
```javascript

app.get('/greetings', function(request, response){
  response.render('greeting', { name: "Spike" });
});
```

`views/greeting.ejs`
```html
<% if(name === "Spike"){ %>
<h1>Hi <%= name %>!</h1>
<% } else{ %>
<h1>Go away!</h1>
<% } %>
```

Since everything is being passed around as JavaScript objects, this means that we can pass whole objects to our views, and specify what information within the object we want to display. 

##Tasks
* Get set up with https://github.com/ericclemmons/grunt-express-server to auto-reload your server
* Build some API endpoints using Github API data, stored in a module, to build a Node backend simulation of the [Github API](https://developer.github.com/). You can hardcode to start with, but if you're feeling adventurous look into hard parameters and query strings (you might need to set more settings).
* You now have all the tools (other than a database) to build a fully functional website (note the public folder that was set up earlier on) - so build something!  A Bowling Scorecard on node perhaps?  But where does the JavaScript go? Client side or server side? Think carefully ...
* Check out Jade as an alternative templating engine


###Resources
* [Use EJS to template your Node application](http://scotch.io/tutorials/javascript/use-ejs-to-template-your-node-application)
* [Getting started with the Github API](https://developer.github.com/guides/getting-started/)
* [Spike on Express and EJS](https://www.youtube.com/watch?v=br4k2QnM0Rw)

