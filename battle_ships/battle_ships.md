# More advanced OO with games: Battle Ships

***Please note, as with all Makers Academy materials, there may be subtle errors in the following materials.  Please try to approach those as challenges on which to polish your debugging skills - pull requests always welcome.***

Battleships (or Battleship) is a game where each player has a board upon which they can place a number of ships. The boards are 10x10 two dimensional grid.

<img src="../images/battleships.jpg" width="500px" height="500px">

After each player has placed their ships on their own board they take turns to shoot on the opponent's board. In each round, each player takes a turn to announce a target square in the opponent's grid which is to be shot at. The opponent announces whether or not the square is occupied by a ship, and if it is a _hit_, they mark this on their own primary grid. The attacking player notes the hit or miss on their own _tracking_ grid, in order to build up a picture of the opponent's fleet.

When all of one player's ships have been sunk the game finishes and the player who has ships remaining is the winner.

***Please work on this project with a pair partner. Please take turns on the keyboard as the driver as described in the [pairing pill](pills/pairing.md) :pill:.***

Please see the [Learning Objectives](learning_objectives.md) for this project and also the resources at the bottom of this page.

## Talks this week:
We will cover a number of more advanced OO concepts this week, referencing the projects we have covered so far.

* *Class methods*:  creating different types of ship
* *Dependency inversion*: dealing with the weather in Airport Challenge.
* *Composition over inheritance*:  docking stations, vans and garages.
* *Implementing blocks*:  initializing a grid with cells.

## Version 0: The User Stories

If one thinks about what a player wants from a game of battleships, one can imagine a set of user stories like the following:

```
As a player
So that I can prepare for the game
I would like to place a ship in a board location

As a player
So that I can play a more interesting game
I would like to have a range of ship sizes to choose from

As a player
So that I can create a layout of ships to fox my opponent
I would like to be able to choose the directions my ships face in

As a player
So that I can have a coherent game
I would like ships to be constrained to be on the board

As a player
So that I can have a coherent game
I would like ships to be constrained not to overlap

As a player
So that I can win the game
I would like to be able to fire at my opponents board

As a player
So that I can refine my strategy
I would like to know when I have sunk an opponent's ship

As a player
So that I know when to finish playing
I would like to know when I have won or lost

As a player
So that I can consider my next shot
I would like an overview of my hits and misses so far

As a player
So that I can play against a human opponent
I would like to play a two-player game
```


## Version 1: Modeling the domain

It is a good idea to spend some time researching the domain of the battleships game and discovering the objects that you will need for this application to work (think back to what we did with [boris bikes](/boris_bikes/boris_bikes.md) in Version 0).

One of the things you have to keep in mind is to simplify as much as you can when you are creating the model of your game. Think of what you need to build first and what you will have to conside in future, don't try to get everything nailed down ( _and designed perfectly_ ) to begin with, you will learn more about the game as you go.

Consider also that you could build simple versions of the game first.  You could build a game with only a single player, or build a game with a grid of only 1x1 size, that only had 1 type of ship.  Get a very simple version working and then very gradually increase the complexity by adding new features.  One way to ensure that you are always building simple working versions is to choose one user story at a time and build a single feature test that reflects it, and try to stick exclusively to only that functionality necessary to support that user story.

**Tasks**:

1. Create a **Class Responsibility Collaborator** (CRC) or similar model of the classes involved in the game.
2. Create your **battleships** repository (use the name _battleships_) in Github.
3. Add a description of your project into the `README.md` file.
4. Add the domain model ( _the explanation of the classes and the interactions_ ) into the `README.md` file.

## Version 2: Building a prototype to explore in IRB

We have recognized the objects that make up the domain of the game. Let's implement them! Don't try to implement the game yet though ( _that is the logic that will make the players take a turn at a time until one of the players wins_ ), we are going to leave that for a later version.

The important thing here is that once we have recognized the objects that make up the battleship game, we start implementing them with the desired functionality ( _How does a ship register a shot? How do you place ships on a board? What does the board look like? etc._ ). If we make sure that every object has its responsibilities clearly defined we will be able to implement them in a turn-base game very easily.

When you model your domain, make sure that your objects follow the [Single Responsibility Principle](https://en.wikipedia.org/wiki/Single_responsibility_principle) ( **SRP** from now on ).

Do you know why? What's the benefit of the **SRP**?

**SRP** is one of five principles that make up **SOLID** ( _Single responsibility, Open-closed, Liskov substitution, Interface segregation and Dependency inversion_), which will help you create software that's cleaner and easier to maintain/extend. Learning these principles ( _and understanding them_ ) will make you stand out as a software developer.

**Tasks**:

1. Write tests for, the code the classes and their interactions (_swap driver/navigator roles frequently :twisted_rightwards_arrows:._)
2. Think about the classes you have created. Are they following **SRP**?
3. Explore your code in `irb` ( _if you prefer `pry` go with it_ ).  Can you create a board?  Add ships?  Take shots?

Don't try to implement everything at once. Start with an MVP with, say, a single-celled grid and a single ship (do we even need cells and/or a grid?).  Once you get a bit of playable logic that you can use in irb move forward slowly by adding in a little bit of complexity at a time, e.g. one additional type of ship; a 2x2 grid, but go slow; only one additional component at a time, and at each step make sure all your tests are green and that you can play your game in irb.

## Version 3: The Game Engine

The objects that make up the battleship game now work the way they are supposed to. You can use them in `irb`, but there is not much you can do with them apart from that; it's time to build the turn-based logic around them.

Have you implemented a `Player` class? What about a `Game`?

How will we go about implementing the game engine? What do we need?

**Here is a list of things your game must be able to do**:

- Initialize a new game with two players
- Allow a player to place ship on their own board
- Allow a player to shoot at their opponent's board
- Allow a player to see where on their opponents board they have hit and missed ( _but not see his opponent's ships_).  Is there a rudimentary way to do this in 'irb'?
- Report if a player has won

One important thing here is that you don't get distracted by how people will actually play the game, but concentrate on the logic of the game itself using the objects you have created.


## Extension: Creating a User Interface

Now it's time to work on the user interface of our battleship game.  What is the user interface?

The idea of the _user interface_ (UI) is to provide our players with a good _user experience_ (UI) while playing the game. You may need to spend some thought on how to implement the UI.  This is best done on paper, storyboarding the different _"screens"_ the players are presented with.

**Tasks**

1. Research about user experience and user interfaces, how do they intersect? How are they related? Do you dare to give a little talk on this to your byte?
2. Create a storyboard of screens you think you will need to implement for a good UX.
3. Present the UI you have created to your cohort and discuss the different approaches.
4. Can you implement the user interface?  Can your cohort play with your battleships game?

## Supporting Material

### Videos

- [Battleships](https://www.youtube.com/watch?v=yG7v_cmDj3E)
- [Class Methods](https://www.youtube.com/watch?v=_I6ft00Ep9c)
- [Blocks, Procs &amp; Lambdas](https://www.youtube.com/watch?v=2HTR4oOZ9iM)
- [SOLID](https://www.youtube.com/watch?v=dBMcKzlfgSk)
- [SOLID II](https://www.youtube.com/watch?v=x-bX66IzcWM)
- [Pairing and MVP on Battleships](https://www.youtube.com/watch?v=1prKzVeRKII)

### Resources

- [An example MVP sequence for Battleships](https://github.com/makersacademy/course/blob/master/pills/mvp.md)
- [Makers Lecture - Blocks, Procs and Lambdas](https://www.youtube.com/watch?v=2HTR4oOZ9iM)
- [Battleships Game - Wikipedia](https://en.wikipedia.org/wiki/Battleship_(game))
- [SOLID - Wikipedia](https://en.wikipedia.org/wiki/Solid_(object-oriented_design))
- [Principles of OOD - Robert C. Martin (unclebob)](http://www.butunclebob.com/ArticleS.UncleBob.PrinciplesOfOod)
- [Terminal Table Gem](https://github.com/tj/terminal-table)
- [User experience design - Wikipedia](https://en.wikipedia.org/wiki/User_experience_design)
- [User interface design - Wikipedia](https://en.wikipedia.org/wiki/User_interface_design)
- [UX Myths](http://uxmyths.com)
