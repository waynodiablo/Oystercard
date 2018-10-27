JavaScript Intro
================

[Video from this session](https://www.youtube.com/watch?v=ghrFsfIHzkg)

***Please note, as with all Makers Academy materials, there may be subtle errors in the following materials.  Please try to approach those as challenges on which to polish your debugging skills - pull requests always welcome.***

*Many thanks to [Alex Peattie](https://github.com/alexpeattie) for the design of these walkthroughs*

[Note also that the initial code for this walkthrough is available in https://github.com/makersacademy/rps-ruby-javascript]

We know how to do Rock Paper Scissors in Ruby:

```ruby
class Game

  PAIRS = {
    rock:     { beats: :scissors },
    paper:    { beats: :rock },
    scissors: { beats: :paper }
  }.freeze

  def initialize(player1, player2)
    @player1, @player2 = player1, player2
  end

  def winner
    return nil if same_pick?

    if PAIRS[@player1.pick][:beats] == @player2.pick
      @player1
    else
      @player2
    end
  end

  private

  def same_pick?
    @player1.pick == @player2.pick
  end

end

class Player

  attr_reader :pick, :name

  def initialize(name)
    @name = name
  end

  def picks(pick)
    @pick = pick
  end

end
```

Which we of course created in a test driven fashion with specs like so:

```ruby
require 'rspec'
require_relative '../lib/rock_paper_scissors'

describe 'Rock-Paper-Scissors' do

  let(:player1) { Player.new 'A' }
  let(:player2) { Player.new 'B' }
  let(:game) { Game.new player1, player2 }

  context 'winning and losing' do
    describe 'rock' do
      it 'should beat scissors' do
        player1.picks :rock and player2.picks :scissors
        expect(game.winner).to be(player1)
      end

      it 'should lose to paper' do
        player1.picks :rock and player2.picks :paper
        expect(game.winner).to be(player2)
      end
    end

    describe 'paper' do
      it 'should beat rock' do
        player1.picks :paper and player2.picks :rock
        expect(game.winner).to be(player1)
      end

      it 'should lose to scissors' do
        player1.picks :paper and player2.picks :scissors
        expect(game.winner).to be(player2)
      end
    end

    describe 'scissors' do
      it 'should beat paper' do
        player1.picks :scissors and player2.picks :paper
        expect(game.winner).to be(player1)
      end

      it 'should lose to rock' do
        player1.picks :scissors and player2.picks :rock
        expect(game.winner).to be(player2)
      end
    end
  end

  context 'draws' do
    describe 'any identical picks' do
      it 'should result in no winner' do
        draw_game_results = [:rock, :paper, :scissors].map do |x|
          player1.picks x and player2.picks x
          game.winner
        end
        expect(draw_game_results).to eq [nil, nil, nil]
      end
    end
  end
end
```

Here's a spec for the rock paper scissors in Jasmine (JavaScript's version of RSPec) that mirror the ruby specs:

```javascript
describe("Rock-Paper-Scissors", function() {

  beforeEach(function() {
    player1 = new Player();
    player2 = new Player();
    game = new Game(player1, player2);
  });

  describe('winning and losing', function() {
    describe('rock', function() {
      it('should beat scissors', function() {
        player1.picks('rock');
        player2.picks('scissors');
        expect(game.winner()).toBe(player1);
      });

      it('should lose to paper', function() {
        player1.picks('rock');
        player2.picks('paper');
        expect(game.winner()).toBe(player2);
      });

    });

    describe('paper', function() {
      it('should beat rock', function() {
        player1.picks('paper');
        player2.picks('rock');
        expect(game.winner()).toBe(player1);
      });

      it('should lose to scissors', function() {
        player1.picks('paper');
        player2.picks('scissors');
        expect(game.winner()).toBe(player2);
      });
    });

    describe('scissors', function() {
      it('should beat paper', function() {
        player1.picks('scissors');
        player2.picks('paper');
        expect(game.winner()).toBe(player1);
      });

      it('should lose to rock', function() {
        player1.picks('scissors');
        player2.picks('rock');
        expect(game.winner()).toBe(player2);
      });
    });
  });

  describe('draws', function() {
    describe('any identical picks', function() {
      it('should result in no winner', function() {
        var drawGameResults = ['rock', 'paper', 'scissors'].map(function(x) {
          player1.picks(x);
          player2.picks(x);
          return game.winner();
        });
        expect(drawGameResults).toEqual([null, null, null]);
      });
    });
  });
});
```

Let's reflect on the differences with between the JavaScript and the Ruby code.  

* In the JavaScript code there are lots of curly braces, i.e. '{' and '}''s.  This is what we use to define a begining and an end block of code. Notice how it's looks the same as an inline block in ruby. 
* In JavaScript we instantiate objects using terminology like 'new Player', and methods are in CamelCase rather than snake_case.  
* Also note that we require '()' in order to call methods; we don't have 'poetry mode' as we do in Ruby.  There are also semi-colons at end of the lines and the word 'function' spread all over the place.
* Also note the nested describe, this a bit like context in rspec
Generally developers use the console in Google Chrome (or other browser) to interactively test JavaScript rather than something like Ruby irb.  However if you are on a Mac you can get access to a command line JavaScript console by adding the following to you ~/.bashrc file or similar:

```sh
ln -s /System/Library/Frameworks/JavaScriptCore.framework/Versions/Current/Resources/jsc /usr/local/bin/jsc
```
Which allows you to explore some JavaScript oddities from the comfort of your own terminal:

```sh
→ jsc
> 2+2
4
> [] + {}
[object Object]
> {} + []
0
```
Javascript was written by Netscape for the web, as such there are a lot of hangovers from thiss lineage. 
Things like running tests are normally done in the browser using something like this SpecRunner.html:

```html
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Jasmine Spec Runner v2.0.0 | Sam Rocks</title>
    <link rel="shortcut icon" type="image/png" href="https://cdnjs.cloudflare.com/ajax/libs/jasmine/2.0.0/jasmine_favicon.png">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jasmine/2.0.0/jasmine.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jasmine/2.0.0/jasmine.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jasmine/2.0.0/jasmine-html.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jasmine/2.0.0/boot.js"></script>
    
    <script type="text/javascript" src="lib/RockPaperScissors.js"></script>
    <script type="text/javascript" src="spec/RockPaperScissorsSpec.js"></script>
  </head>
  <body>
  </body>
</html>
```

We load the JavaScript libraries we need using script tags like `<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jasmine/1.3.1/jasmine.js">`.  Note that using JS libraries on a content delivery network (CDN) like this can improve performance for our users since their browsers might have already cached those files from the CDN already, avoiding a need to load them again.

Given the above code laid out on the file system like so:

```sh
.
├── javascript
│   ├── SpecRunner.html
│   ├── lib
│   │   └── RockPaperScissors.js
│   └── spec
│       └── RockPaperScissorsSpec.js
└── ruby
    ├── Gemfile
    ├── Gemfile.lock
    ├── demo.rb
    ├── lib
    │   └── rock_paper_scissors.rb
    └── spec
        └── rock_paper_scissors_spec.rb
```


and an empty `lib/RockPaperScissors.js` file, we get an initial failure in Jasmine script runner (open SpecRunner.html in a browser) like this:

```
Rock-Paper-Scissors winning and losing rock should beat scissors.
ReferenceError: Player is not defined
```

Which is not so different from the error we might expect in Ruby.  This error is because we don't yet have anything in our `lib/RockPaperScissors.js` file.  Let's think about how we would fix this in Ruby?  

In Ruby we might start off by creating a 'class Player'.  In JavaScript we instead do this:

```javascript
function Player(){
  
}
```

Can anyone guess what the new error will be?

```
Rock-Paper-Scissors winning and losing rock should beat scissors.
ReferenceError: Game is not defined
```

So we can fix that by declaring a Game function.  Note that we use the keyword 'function' here and not 'class'.  JavaScript has no concept of 'classes'.  Instead it has 'objects' and 'prototypes'.  However we will be defining our Game 'object' using the 'function' keyword.

```javascript
function Game(){
  
}
```

Now we get a hard to decipher error:

```
Rock-Paper-Scissors winning and losing rock should beat scissors.
TypeError: undefined is not a function
```

on line 17 of the spec RockPaperScissorsSpec.js.  This is indicating that we haven't defined the method 'picks'.  In ruby we'd add something like `def picks` inside our class.  However in JavaScript we declare it outside the function used a 'prototype' attribute:

```javascript
function Player(){
  
}

Player.prototype.picks = function(){
  // blah blah
}
``` 

You might note some useful tab completion of the prototype function if you are using the Sublime editor. Note that the 'function' keyword is used to define 'classes' as well as methods, but also the equivalent of Ruby 'blocks' (look at Jasmine spec).

This changes the error to line 19, which we can fix in a similar fashion:

```javascript
function Game(){
  
}

Game.prototype.winner = function(){
  
}
```

These 'winner' and 'picks' methods might look like class methods, but they are in fact instance methods - as mentioned above we don't really have the concept of a class method in JavaScript.  The new code above will now give us a new error:

```javascript
Error: Expected undefined to be {  }.
    at new jasmine.ExpectationResult (https://cdnjs.cloudflare.com/ajax/libs/jasmine/1.3.1/jasmine.js:114:32)

```

Jasmine not as helpful as RSpec in terms of error messages.  We can make this error a bit more readable by adding some player names like this:

```javascript
describe("Rock-Paper-Scissors", function() {

  beforeEach(function() {

    player1 = new Player('Sam');
    player2 = new Player('Tony');
    game = new Game(player1, player2);

  });
```

So if we were in Ruby how would I save this player name to an instance variable?  

Usually we would use an initialise method, but we don't have those in JavaScript.  In JavaScript we just define our instance variables in the curly braces; there is no separate initialise method.  So where do you think we can pass a name into the below?


```javascript
function Player(){
  
}
``` 

The answer is to pass an argument in like so:

```javascript
function Player(name){
  this.name = name;
}
``` 

Hre 'this.' replaces the familiar '@' from Ruby to indicate an instance variable.  In coffee script we'll see a version of JavaScript that looks more similar to Ruby, but for the moment let's stick with plain old JavaScript.  That improves our error message like so:

```
Rock-Paper-Scissors winning and losing rock should beat scissors.
Expected undefined to be { name : 'Sam' }.
```

undefined is almost the equivalent of nil in ruby.  In JavaScript if you don't tell a method to return anything it will return 'undefined'.

Another interesting thing about JavaScript - let's try doing this:

```javascript
Game.prototype.winner = function(){
  return player1;
}
```

What would you expect to happen? To get "undefined method player1" or something?  Actually a whole set of our tests start passing … but why?

So this is a very common mistake in javascript - it's actually that code from the spec is leaking into the main code, which is very bad.  We want to ensure that all the variables created in our spec are local variables, by preceding them with 'var' in the appropriate place, e.g. 

```javascript
describe("Rock-Paper-Scissors", function() {
  var player1, player2, game;
  
  beforeEach(function() {

    player1 = new Player('Sam');
    player2 = new Player('Tony');
    game = new Game(player1, player2);

  });
```

and now we get the sort of error that we expected to have:

```
Rock-Paper-Scissors winning and losing rock should beat scissors.
ReferenceError: player1 is not defined
```

Let's start with having player1 always win.   Let's make the JavaScript equivalent of our Ruby logic for rock paper scissors:

```javascript
function Player(name){
  this.name = name;
}

Player.prototype.picks = function(pick){
  this.pick = pick;
}

function Game(player1, player2){
  this.player1 = player1;
  this.player2 = player2;
}

Game.prototype.winner = function(){
  return this.player1;
}
```

Which allows three of our specs to pass.  Now what would happen if we did this?

```javascript
Game.prototype.winner = function(){
  this.player1;
}
```

unlike Ruby, this won't work - we must explicitly return at the end of the function.  Also, we are going to have trouble if there are syntax errors, the error messages are not very helpful - will have to use console to find errors in particular places. 
Some other things to note about JavaScript compared to Ruby are:

* thre are no symbols in javascript, only strings
* hashes are very similar to Ruby, but there is no hash rocket syntax ('=>') - just use the ':'
* JavaScript hash keys can lose their quotes if there are no special characters
* 'this' is JavaScript's version of 'self'
* JavaScript 'if' statements require parentheses are required
* There is a difference between '==' and '==='
* No 'unless' in JavaScript.
* Not as many built in methods in javascript

There are also the semicolons.  The rule of thumb is on any line of code that is executing a method or doing assignments.  See this [guide on where to place semicolons](http://www.codecademy.com/blog/78-your-guide-to-semicolons-in-javascript).

There are a number of ways to define a method in JavaScript, but let's stick to the simple ones above for the moment.  

Resources
-----

* [Mozilla Intro to JavaScript](https://developer.mozilla.org/en-US/docs/Web/JavaScript/A_re-introduction_to_JavaScript)
* [Mozilla Intro to OO JavaScript](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Introduction_to_Object-Oriented_JavaScript)
* [Eloquent JavaScript](http://eloquentjavascript.net/)

Exercises
-----

* Complete this code by adding the rest of the game logic so we are not hard coding a winner
* Extend this code to support the Rock, Paper, Scissors, Lizard, Spock game







![Tracking pixel](https://githubanalytics.herokuapp.com/course/walkthroughs/javascript_intro.md)
