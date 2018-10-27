More JavaScript
===============

[Video of the walkthrough](https://www.youtube.com/watch?v=xx3CB-ozO98)

***Please note, as with all Makers Academy materials, there may be subtle errors in the following materials.  Please try to approach those as challenges on which to polish your debugging skills - pull requests always welcome.***

*Many thanks to [Alex Peattie](https://github.com/alexpeattie) for the design of these walkthroughs*

So carrying on from our earlier half finished JavaScript RPS game, we have several tests that are still failing.  We know how to handle the game logic in ruby:

```ruby
    if PAIRS[@player1.pick][:beats] == @player2.pick
      @player1
    else
      @player2
    end
```

Let's convert that to JavaScript:

```javascript
Game.prototype.winner = function() {
  
  if(PAIRS[this.player1.pick]['beats'] === this.player2.pick){
    return this.player1;
  } 
  else {
    return this.player2; 
  }

};
```
[Note the use of the triple '==='.  See this [stackoverflow post](http://stackoverflow.com/questions/359494/does-it-matter-which-equals-operator-vs-i-use-in-javascript-comparisons) for more on the difference between '===' and '==']

All tests now fail because we haven't got the PAIRS constant that we have in ruby:

```ruby
  PAIRS = {
    rock:     { beats: :scissors },
    paper:    { beats: :rock },
    scissors: { beats: :paper }
  }.freeze
```

There are no constants in javascript so we'll need to create a variable:

```javascript
var PAIRS = {
  rock:     {beats: 'scissors'},
  paper:    {beats: 'rock'},
  scissors: {beats: 'paper'}
}
```

Not very happy about this floating around in RockPaperScissors.js file.  Could put it in the winner method, but then can only access from that method.  I can put it in the Game declaration but then we'll have a new copy created for every instance of game, which is not very efficient.  Alternatively we can put the PAIRs in the prototype so there will only be one instance of it shared by all objects of type Game:

```javascript
Game.prototype.PAIRS = {
  rock:     {beats: 'scissors'},
  paper:    {beats: 'rock'},
  scissors: {beats: 'paper'}
}
```

This then requires us to refer to PAIRS using 'this.'

```javascript
Game.prototype.winner = function() {
  
  if(this.PAIRS[this.player1.pick]['beats'] === this.player2.pick){
    return this.player1;
  } 
  else {
    return this.player2; 
  }

};
```

All tests apart from the draw condition should now work. Let's copy that from the ruby code:

```ruby
  def same_pick?
    @player1.pick == @player2.pick
  end
```

and make it more JavaScripty:

```javascript
Game.prototype.isSamePick = function() {
  return this.player1.pick === this.player2.pick;
};
```

Note that we can't use the question mark in JavaScript methods.  We can prepend with an underscore '_' to indicate that a method is a private method, and that we shouldn't call it from outside the function.  So now we can handle the draw case:


```javascript
Game.prototype.winner = function() {
  if(this._isSamePick()) return null;  

  if(this.PAIRS[this.player1.pick]['beats'] === this.player2.pick){
    return this.player1;
  } 
  else {
    return this.player2; 
  }

};
```

Note there is no nil in JavaScript - you have [undefined and null](http://stackoverflow.com/questions/5076944/what-is-the-difference-between-null-and-undefined-in-javascript).  Note also that we can't reorder the if statements in javascript as we can in ruby, i.e. the 'if' statement has to be at the start of the line.

So to re-iterate why the PAIRs variable is now in the Game function - if it was floating around as a var it would potentially interfere with other libraries that we might be using.

`this.PAIRS` inside the game function would get created potentially 1000's of times; one for each time we create a game object.  `var PAIRS` outside any of the functions clobbers the global name space which is bad.

```javascript
player1.picks('Rock')
player1.pick = 'Rock'
```

are equivalent, but the former gives us better encapsulation - it's similar to an attr_reader in Ruby, and it means if there's something we need to do each time we update a pick the former approach has a specific method, a dedicated location to ensure consistency of the object's internal state.

Exercises
------

* Work out how to add random choices on the part of a computer player by adding some additional methods.












![Tracking pixel](https://githubanalytics.herokuapp.com/course/walkthroughs/more_javascript.md)
