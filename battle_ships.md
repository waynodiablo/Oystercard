# More advanced OO with games: Battle Ships

Battleships (or Battleship) is a game where each player has a board upon which they can place a number of ships. The boards are 10x10 two dimensional grid.

![Battleships grid](https://upload.wikimedia.org/wikipedia/commons/6/65/Battleship_game_board.svg)

After each player has placed their ships on their own board they take turns to shoot on the opponents board. In each round, each player takes a turn to announce a target square in the opponent's grid which is to be shot at. The opponent announces whether or not the square is occupied by a ship, and if it is a _hit_ they mark this on their own primary grid. The attacking player notes the hit or miss on their own _tracking_ grid, in order to build up a picture of the opponent's fleet.

When all of one player's ships have been hit the game finishes and the player who has ships remaining is the winner.

## Version 0: Modelling the domain

Your first task is to spend some time researching the domain of the battleships game and discovering the objects that you will need for this application to work (think back to what we did with [boris bikes](/boris_bikes.md) in Version 0).

One of the things you have to keep in mind is to simplify as much as you can when you are creating the model of your game. Think of what you need to build first and what you will have to consider, don't try to get everything nailed down ( _and designed perfectly_ ) to begin with, you will learn more about the game as you go.

**Tasks**:

- [] Create the **CRC** model of the classes involved in the game. 
- [] Create your **battleships** repository (use the name _battleships_) in Github.
- [] Add a description of your project into the `README.md` file.
- [] Add the domain model ( _the explanation of the classes and the interactions_ ) into the `README.md` file.
- [] Present your findings to your cohort and discuss why you chose the objects and the interactions the way you did ( _group discussion_ ).

## Version 1: The Model

We have recognised the objects that make up the domain of the game. Let's implement them! Don't try to implement the game yet though ( _that is the logic that will make the players take a turn at a time till one of the players wins_ ), we are going to leave that for a later version.

The important thing here is that, once we have recognised the objects that make up the battleship game we start implementing them with the desired functionality they should have ( _How does a ship register a shot? How do you place ships on a board? How does the board look like? etc._ ). If we make sure that every object has it's responsibilities clearly defined we will be able to _"wire"_ them into a turn based game fairly easily.

When you model your domain, make sure that your objects follow the [Single Responsibility Principle](https://en.wikipedia.org/wiki/Single_responsibility_principle) ( **SRP** from now on ). 

Do you know why? What's the benefit of the **SRP**?

The **SRP** is one of five principles that make up **SOLID** ( _Single responsibility, Open-closed, Liskov substitution, Interface segregation and Dependency inversion_), which will help you create software that's cleaner and easier to maintain/extend. Learning these principles ( _and understanding them_ ) will make you stand out as a software developer.

**Tasks**:

- [] Code the classes and their interactions ( _Test First!_ )
- [] Think about the classes you have created. Are they following the **SRP** ?
- [] Play with your code in `irb` ( _if you prefer `pry` go with it_ )
- [] Present one of the **SOLID** principles to your cohort.

## Version 2: The Game Engine

The objects that make up the battleship game work now the way they are supposed to work. You can use them in `irb`, but there is not much you can do with them apart from that; it's time to build the turn based logic around them.

Have you implemented a `Player` class? What about a `Game` ( _maybe we can call it `BattleShips`?_ )?

How will we go about implementing the game engine? What do we need?

**Here is a list of things your game must be able to do**:

- Initialise a new `Game` with two `Player(s)`
- Allow a `Player` to place `Ship(s)` on his `Board`
- Allow a `Player` to look into his opponents `Board` to see where he shot at ( _but not seeing the `Ship(s)`_ )
- Allow a `Player` to shoot at the opponents `Board`
- Report if a `Player` has won

One important thing here is that you don't focus on how people will play the game, but concentrate on the logic of the game itself using the objects you created previously. We will look into the user interface in our last version.

## Version 3: User Interface (the terminal)

Now it is time to work on the user interface of our battleship game. Usually we would start coding the user interface as soon as possible ( _there are some testing tools that help with this, but we haven't heard about them yet_ ) and drive the logic from there; you will soon learn the benefits from doing this.

The idea of the UI ( _or user interface_ ) is to provide the player a good UX ( _user experience_ ) while he is playing the game. You will have to spend some thought on how to implement the UI, this is best done on a piece of paper, story boarding the different _"screens"_ the players are presented with. Play around with that before you get your hands on the keyboard.

**Tasks**

- [] Research about user experience and user interfaces, how do they intersect? How are they related? Do you dare to give a little talk on this to your cohort ( _maybe as a lunch and learn?_ ). 
- [] Create a storyboard of screens you think you will need to implement in order to cater for a good UX.
- [] Present the UI and UX you have created to the your cohort and discuss the different approaches.
- [] Implement the User Interface.
- [] Let your cohort ( and the senior cohort ) play with your battleships game ( _maybe a little battleships tournament?_ )!

## Supporting Material

### Resources
- [Battleships Game - Wikipedia](https://en.wikipedia.org/wiki/Battleship_(game))
- [SOLID - Wikipedia](https://en.wikipedia.org/wiki/Solid_(object-oriented_design))
- [Principles of OOD - Robert C. Martin (unclebob)](http://www.butunclebob.com/ArticleS.UncleBob.PrinciplesOfOod)
- [User experience design - Wikipedia](https://en.wikipedia.org/wiki/User_experience_design)
- [User interface design - Wikipedia](https://en.wikipedia.org/wiki/User_interface_design)
- [UX Myths](http://uxmyths.com)