#Intro to Websockets

[Video of session](https://www.youtube.com/watch?v=0UEBUYKu2Dg)

##What are Websockets?

Before we answer that, let's ask a slightly different question:

##What is event-driven programming?

You probably already the answer to this, you just don't know it yet. Does this piece of pseudo-code look familiar/do you understand how it works?

```javascript

$(document).ready(function(){

  $('#element').on('click', function(){
    alert("I've been clicked!");
  });

});
```

If the answer is yes, then you know what event-driven programming is. The key word here is "on". Instead of giving a list of instructions to be executed, we tell the element to do something when it is clicked. This is usually referred to as attaching an event handler - 'on' an event, do something. As you can see, a lot of what jQuery does is based on events. Let's look at another example:

```javascript

$(document).ready(function(){

  $('#element').on('click', function(){
    console.log('First element clicked!');
    $('#element2').click();
  });

  $('element2').on('click', function()[
    console.log('Second element clicked!');
    $('#element').click();
  });

});
```

While utterly pointless (and causing an infinite loop), this example illustrates what happens when you attach event handlers to two objects. In effect, these two elements are communicating by clicking on each other. See where we're going with this? So let's ask the original question again.

##What are Websockets? (take 2)

Websockets is a technology that enables this kind of two-way, event driven communication, but between a client and a server. The connection this uses (the Websocket) opens a direct, full-duplex connection that remains open and connected until otherwise disconnected. This is in contrast to HTTP, where communication between client and server relies on separate, single request and response connections.

One great explanation of Websockets is that if HTTP is like two people throwing paper planes with messages scribbled on them two each other, Websockets are like a phone made of cups attached by string, except that each person has two cups - one for their mouth and one for their ear!

So what can Websockets used for? Here are a few use cases:

* Chat servers  
* Games  
* File uploads/downloads  
* Instant push updates of news, sports, etc.  
* Online collaboration tools  
* ...pretty much anything where having something instantly updated would be awesome.  

Instead of trying to write our own version of the Websockets protocol (don't reinvent the wheel!), we can use a great npm package to manage our connection: `socket.io`.

##`socket.io`

`socket.io` is a convenient wrapper around the Websockets protocol, which exposes a fairly simple API that lets us get up and started very quickly. Set up a new project with Express and `ejs` (or adapt an existing one) and install `socket.io`:

```shell
npm install --save socket.io
```

There are a few steps we need to set `socket.io` up so that we can experiment:

* In the server, require `socket.io` and pass it the server as an argument
* Set up a route that will serve a page that we can play with
* Create a view that we can add the `socket.io` client to
* Set up a public folder that we can serve client-side JavaScript files from

`server.js`
```javascript
var express = require('express');
var app = express();
var server = require('http').createServer(app);
var io = require('socket.io')(server);

app.set('view engine', 'ejs');

app.use(express.static(__dirname + '/public'));

app.get('/sockets', function(request, response){
  response.render('sockets');
});

server.listen(3000, function(){
  console.log("Listening on 3000")
});
```

`views/sockets.ejs`
```html
<h1>Welcome to socketTest!</h1>
<script src='/socket.io/socket.io.js'></script>
<script src='/js/sockets.js'></script>
```

`public/js/sockets.js`
```javascript
  var socket = io.connect('http://localhost:3000/');
```

At this point, we could have all our socket logic in the server - but, this isn't very Node, and while we could refactor later, we might as well get it out of the way now. Make a `src` directory and create a module with a sensible name to handle your socket logic. We can then require this in the server, and pass it `io` as an argument (see a pattern here?)

`src/socketController.js`
```javascript
var socket = function(io){

  io.on('connection', function(socket){

    console.log('Client connected!');

  });
});

module.exports = socket;
```

`server.js`
```javascript
var express = require('express');
var app = express();
var server = require('http').createServer(app);
var io = require('socket.io')(server);
var socket = require('./src/socketController.js')(io);

...

```

Now we can start experimenting with Websockets - if we open a browser and navigate to [http://localhost:3000](http://localhost:3000) then we should receive a message in our server's console with 'Client connected!'. Let's set up a listener on the server so that we can start sending messages from the client, as well as a disconnect message when a client disconnects:

`src/socketController.js`
```javascript
var socket = function(io){

  io.on('connection', function(socket){

    console.log('Client connected!');

    socket.on('message', function(data){
      console.log(data);
    });

    socket.on('disconnect', function(){
      console.log('Client disconnected!');
    });
  });
};
```

Run the server, and then open the browser console. We can now send messages to the server by typing `socket.emit('message', "message");`

###Resources

[MDN Websockets reference](https://developer.mozilla.org/en/docs/WebSockets)  
[Pusher: what are Websockets?](http://pusher.com/websockets)  
[socket.io](http://socket.io/)


![Tracking pixel](https://githubanalytics.herokuapp.com/course/walkthroughs/intro_to_websockets.md)
