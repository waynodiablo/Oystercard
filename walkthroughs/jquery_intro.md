Introduction to JQuery
=====================

[Video of session](https://www.youtube.com/watch?v=wQqzJo97cIU)

***Please note, as with all Makers Academy materials, there may be subtle errors in the following materials.  Please try to approach those as challenges on which to polish your debugging skills - pull requests always welcome.***

*Many thanks to [Alex Peattie](https://github.com/alexpeattie) for the design of these walkthroughs*

Let's look at one possible solution to the RPSLS problem - note that this is just one possible solution.  We've split the player and game into their own files. [Note the starting code shell for the below is available in [this repo](https://github.com/makersacademy/rpsls-javascript-jquery)]

```javascript
function Player(name) {
  this.name = name;
}

Player.prototype.picks = function(pick) {
  this.pick = pick;
}
```	

```javascript
function Game(player1, player2) {
  this.player1 = player1;
  this.player2 = player2;
}

Game.prototype.PAIRS = {
  rock:     { scissors: 'crushes', lizard: 'squashes' },
  paper:    { rock: 'covers', spock: 'disproves' },
  scissors: { paper: 'cuts', lizard: 'decapitates' },
  lizard:   { spock: 'poisons', paper: 'eats' },
  spock:    { rock: 'vaporises', scissors: 'smashes' }
}

Game.prototype.winner = function() {
  if(this._isSamePick()) return null;

  if(this._victoryVerbFor(this.player1.pick, this.player2.pick)) {
    return this.player1;
  }
  else {
    return this.player2;
  }
}

Game.prototype.loser = function() {
  return (this.winner() === this.player1 ? this.player2 : this.player1);
}

Game.prototype.winningMessage = function() {
  var message;

  if(this.winner()) {
    message = [this.winner().name,
    this._victoryVerbFor(this.winner().pick, this.loser().pick),
    this.loser().name].join(' ');
  } else {
    message = 'Draw';
  }

  return message;
}

Game.prototype._victoryVerbFor = function(pick, opponentPick) {
  return this.PAIRS[pick][opponentPick];
}

Game.prototype._isSamePick = function() {
  return this.player1.pick === this.player2.pick;
}
```

The best advice you will ever get is KISS - Keep It Simple Stupid :-) There are certainly other solutions to this problem that we might regard as more sophisticated, but simplicity is often your best friend.  In the approach above we have used a lookup table and we can find the verb associated with any winning hand.  This mechanism helps us work out both who wins and the message to use to display that result. Note also that the new methods including the private _victoryVerbFor for working out the message and 'loser' which gives us the inverse of he 'winner' method.

There are certainly more complex mathematical methods for solving this problem, but if we can make something simple and relatively readable with hashes that works, then that's likely to be the best way to go :-)

The extensive specs that we now have look a little unDRY, but don't worry too much about that in this case as these tests are providing a level of documentation for the whole game.

Now let's have a look at a web interface for playing this game:

```html
<!doctype>
<html>
  <head>
    <title>Rock Paper Scissors Lizard Spock</title>
    <style>
    body {
      font-family: 'Helvetica Neue';
      margin: 15px 0 0 30px;
    }

    .choices img {
      width: 15%;
      margin-right: 2.5%;
      cursor: pointer;
      opacity: 0.5;
      transition: 1s all ease;
    }

    .choices img:hover {
      opacity: 1;
    }

    h2, h3 {
      text-transform: capitalize;
    }

    #results {
      list-style: none;
    }

    #results li {
      background: #999;
      color: #fff;
      font-size: 24px;
      border-radius: 8px;
      padding: 5px;
      width: 80%;
      margin-bottom: 10px;
    }
    </style>
  </head>
  <body>
    <h1>Rock Paper Scissors Lizard Spock</h1>
    <div class='choices'>
      <img src="images/rock.png">
      <img src="images/paper.png">
      <img src="images/scissors.png">
      <img src="images/lizard.png">
      <img src="images/spock.png">
    </div>
    <ul id="results">
    </ul>

    <script src='lib/Player.js'></script>
    <script src='lib/Game.js'></script>
    <script src='http://code.jquery.com/jquery-2.1.1.min.js'></script>
    <script>
      $(document).ready(function(){
        var alex = new Player('Alex');
        var tony = new Player('Tony');
        var game = new Game(alex, tony)

        $('.choices img').on('click', function(){
          alex.picks($(this).data('pick'));
          tony.picks('rock');

          $('#results').prepend('<li>' + game.winningMessage() + '</li>');
        })
      })
    </script>
  </body>
</html>
```

Having the CSS in the HTML file is bad practice, but just for simplicity let's have everything in the same file for the moment to ease us through the walkthrough.  Note the different CSS styles here.  We have '.choices img' (ask yourself why we are not just using the 'img' CSS selector).  These images are set to have a width of 15% of the screen, and when they are hovered over we change the opacity to 1.  Also using CSS transition to ease from half opacity to full opacity.  We can adjust the rate at which the change happens, and it's not just the opacity - we can adjust the positioning, margins etc. and ease those in as well.

We've also got our images, and we're loading our own scripts and we're also loading jQuery which is an animations/UX library.

Let's look at [jQuery CDN](https://code.jquery.com/).  This is a great resource for fast downloads of the jQuery libraries we need.  There are also minified versions which we can use to improve download times.  Dealing with the qwerks of all the different browsers is a real pain (particularly the way that JavaScript talks to the Document Object Model (DOM), i.e. the HTML page), but that's something that the jQuery library will take care of for us.  jQuery is designed to make it easy for JavaScript to interact with HTML.

Let's see how jQuery actually works.  Let's start by adjusting our results element to an h2 tag and open a place for a new script:

```html
  <h2 id="results"></h2>

  <script src='lib/Player.js'></script>
  <script src='lib/Game.js'></script>
  <script src='http://code.jquery.com/jquery-2.1.1.min.js'></script>
  <script>

  </script>

```
Note that we have scripts at the bottom, which [used to be best practice](http://stackoverflow.com/questions/436411/where-is-the-best-place-to-put-script-tags-in-html-markup) but things have changed, although there is perhaps still [some disagreement in the community](https://developers.google.com/apps-script/guides/html/best-practices).  

We can start writing some JavaScript within these script tags:

```javascript
jQuery(document).ready(function(){

})
```

Getting started like this, like our 'prototype' methods, should just be considered boilerplate.  You don't need to worry too much about how it's workin, but the ready function is ensuring that our HTML document is fully loaded before we start running our JavaScript.  Now let's grab a reference to the results element.


```javascript
jQuery(document).ready(function(){
  jQuery('#results').html('Hello world');
})
```

and let's reload our index.html page in order to see that this is working.  Given that's working we can slim down our code by using the '$' alias like so:


```javascript
$(document).ready(function(){
  $('#results').html('Hello world');
})
```

Note that we can save the jquery locally and then load if locally so that we can work offline:

```html
  <h2 id="results"></h2>

  <script src='lib/Player.js'></script>
  <script src='lib/Game.js'></script>
  <script src='jquery-2.1.1.min.js'></script>
  <script>
```

Anyhow, we'd like our buttons to do something.  For that we need an event handler.  What kind of event might we be listen for?

mouseOver, form submission, drag and drop - any user action can be listened for.  In this case let's listen for something happening to the images.  Let's use jQuery to grab a reference to those images using `$('.choices img')`.  Think about why we are selecting via '.choices img' rather than just 'img'?

Nevertheless, having got a reference to the relevant images in the page let's assign a handler for the user 'click' event

```javascript
$(document).ready(function(){
  $('.choices img').on('click', function(){
    $('#results').html('Click registered');
  });
})
```

Now when we reload index.html and click on the images we should see the 'Click registered' text appear.  Now we can update this to work with the game itself.

```javascript
$(document).ready(function(){
  var sam = new Player('Sam');
  var tony = new Player('Tony'); 
  var game = new Game(sam, tony);
  $('.choices img').on('click', function(){
    sam.picks('Paper');
    tony.picks('Rock');
    $('#results').html(game.winningMessage());
  });
})
```

The above code will not actually work - can you think where to look for the error messages?  It's the chrome console which should tell you something like:

```
Uncaught TypeError: Cannot read property 'Rock' of undefined on Game.js, line 44
```

and the problem here is that our lookup hash of winning combinations is using all lower case for the keys, and we have capitalised the first letter in our JavaScript above.  The simple fix is of course:


```javascript
$(document).ready(function(){
  var sam = new Player('Sam');
  var tony = new Player('Tony'); 
  var game = new Game(alex, tony);
  $('.choices img').on('click', function(){
    sam.picks('paper');
    tony.picks('rock');
    $('#results').html(game.winningMessage());
  });
})
```

And if we reload index.html again we should get the curious message that 'Sam covers Tony' for every possible selection.  So now we can make this have more functionality.  The computer can just stick always choosing the same option, but we don't want to ignore what the user has selected. So how can we get the information about which image the user clicked on?

We could switch on the image src or the image id, but the problem is that we start mixing up the design side of things with the programming functionality.  The id of elements or the names of the the image file may change for stylistic reasons, and we don't want those changes to break the functionality of our system.

The best practise way to deal with this is to use data-attribute attributes of html, so for example we might do the following:

```html
    <div class='choices'>
      <img src="images/rock.png" data-pick='rock'>
      <img src="images/paper.png" data-pick='paper'>
      <img src="images/scissors.png" data-pick='scissors'>
      <img src="images/lizard.png" data-pick='lizard'>
      <img src="images/spock.png" data-pick='spock'>
    </div>
```

Note that data attributes just need to start with 'data-' but can be anything, so 'data-choice', 'data-user-choice'. Whatever you like.  These data-attributes won't be used for any stylistic parts of the system so we can rely on them for our functionality.  Designers might not realise that page functionality relies on things like id tags.  Note also that ids are unique so can't be used if we had multiple identical images that needed to have the same functionality on the same page.

So the last thing we need some way of accessing the image pick.  There's a keyword that we'll use to access the pick here.  Can you think what that is?

It's the 'this' keyword, which we've previously encountered and thought of it as the JavaScript version of Ruby self, however it does have other uses.  Sometimes it can just mean the thing we are talking about in the current context.  In this context we can use 'this' to refer to the image that we have just clicked.

BTW, note that one really useful functionality here is the ability to log things to the JavaScript console using statements like "console.log('Image clicked')".  Let's just comment out the other functionality for the moment and see how that works:

```javascript
$(document).ready(function(){
  var sam = new Player('Sam');
  var tony = new Player('Tony'); 
  var game = new Game(alex, tony);
  $('.choices img').on('click', function(){
    console.log('Image clicked')
    console.log($(this))
    //sam.picks('paper');
    //tony.picks('rock');
    //$('#results').html(game.winningMessage());
  });
})
```

[Note there is also debugger functionality available from the JavaScript console.]

If we reload index.html and look at the console while we are clicking the images we can see the log message as well as details of the 'this' object.  Now that we have a reference to the image we can grab the data attribute from it like so


```javascript
$(document).ready(function(){
  var sam = new Player('Sam');
  var tony = new Player('Tony'); 
  var game = new Game(alex, tony);
  $('.choices img').on('click', function(){
    alert($(this).data('pick'))
    //sam.picks('paper');
    //tony.picks('rock');
    //$('#results').html(game.winningMessage());
  });
})
```

Note that here we are using the more obnoxious 'alert' here to check what is being picked.  And finally to get the functionality that we want we can move the information about the pick into our game code:

```javascript
$(document).ready(function(){
  var sam = new Player('Sam');
  var tony = new Player('Tony'); 
  var game = new Game(alex, tony);
  $('.choices img').on('click', function(){
    sam.picks($(this).data('pick'));
    tony.picks('rock');
    $('#results').html(game.winningMessage());
  });
})
```

and refreshing index.html we should see that the system is now working.  Clearly the computer is just selecting the same choice over and over again, so we could extend that but rather than that, let's add a history of past matches with two changes: one to the HTML and another in the JavaScript:

```html
  <ul id="results"></ul>

  <script src='lib/Player.js'></script>
  <script src='lib/Game.js'></script>
  <script src='jquery-2.1.1.min.js'></script>
  <script>
```

```javascript
$(document).ready(function(){
  var sam = new Player('Sam');
  var tony = new Player('Tony'); 
  var game = new Game(alex, tony);
  $('.choices img').on('click', function(){
    sam.picks($(this).data('pick'));
    tony.picks('rock');
    $('#results').prepend('<li>' + game.winningMessage() + '</li>');
  });
})
```

Refreshing index.html we should now see a nice history of our matches.  And you might be surprised how much of the interactivity on the web can be covered by simple html and CSS manipulations based on javascript like this.



Exercises
--------
* How could we have the history in chronological rather than reverse chronological order?
* Create your own fun RPSLS interface using CSS and JavaScript
* Get the computer player to choose something random
* Have the computer player execute some sort of strategy to maximise it's chance of winning

Resources
-------

* [jQuery documentation](http://api.jquery.com)
* [Isobar Code Standards](http://isobar-idev.github.io/code-standards/)
* [MDN CSS Documentation](https://developer.mozilla.org/en-US/docs/Web/CSS)


TODO
-----
* add how caching works
* add note about forced refresh





