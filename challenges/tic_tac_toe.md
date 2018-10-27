# More advanced OO with games: Tic Tac Toe

***Please note, as with all Makers Academy materials, there may be subtle errors in the following materials.  Please try to approach those as challenges on which to polish your debugging skills - pull requests always welcome.***

Tic Tac Toe (or Naughts and Crosses) is a game where each player takes a turn on a 3X3 grid. The winner is the first person to fill a row, column or diagonal with their O or X marker.

The focus of building Tic Tac Toe is build your skills of TDD, have multiple classes which work together, introduce **Encapsulation** and to make you think about the Single Responsibility Principle **SRP**. Although the game is quite small it can be crafted in a way which touches upon some advanced principles which will help you with larger applications later.

***Please work on this project with a pair partner. Please take turns on the keyboard as the driver as described in the [pairing pill](pills/pairing.md) :pill:.***


## Version 0: Modelling the domain

Your first task is to spend some time researching the domain of the Tic Tac Toe game and discovering the objects that you will need for this application to work (think back to what we did with [boris bikes](/boris_bikes.md) in Version 0).

Research Encapsulation but don't try to build it too complicated from the start. Remember KISS (Keep it simple stupid). No application is coded perfectly straight away, let yourself break the rules and go back to refactoring afterwards onces the tests pass.

One of the things you have to keep in mind is to simplify as much as you can when you are creating the model of your game. Think of what you need to build first and what you will have to consider, don't try to get everything nailed down ( _and designed perfectly_ ) to begin with, you will learn more about the game as you go.

**Tasks**:

1. Create the **CRC** model of the classes involved in the game.
2. Create your **tic_tac_toe** repository (use the name _tic_tac_toe_) in Github.
3. Add a description of your project into the `README.md` file.
4. Add the domain model ( _the explanation of the classes and the interactions_ ) into the `README.md` file.

## Version 1: The Model


We have recognised the objects that make up the domain of the game. Let's implement them! Don't try to implement the game yet though ( _that is the logic that will make the players take a turn at a time till one of the players wins_ ), we are going to leave that for a later version.

The important thing here is that, once we have recognised the objects that make up the Tic Tac Toe game we start implementing them with the desired functionality they should have ( _Does a board place a marker? How do we know when the game is over? How does the board look like? etc._ ). If we make sure that every object has it's responsibilities clearly defined we will be able to _"wire"_ them into a turn based game fairly easily.

When you model your domain, make sure that your objects follow the [Single Responsibility Principle](https://en.wikipedia.org/wiki/Single_responsibility_principle) ( **SRP** from now on ).

Do you know why? What's the benefit of the **SRP**?

The **SRP** is one of five principles that make up **SOLID** ( _Single responsibility, Open-closed, Liskov substitution, Interface segregation and Dependency inversion_), which will help you create software that's cleaner and easier to maintain/extend. Learning these principles ( _and understanding them_ ) will make you stand out as a software developer.

**Tasks**:

1. Code the classes and their interactions ( _Test First!, and swap driver/navigator roles frequently :twisted_rightwards_arrows:._)
2. Think about the classes you have created. Are they following the **SRP** ?
3. Play with your code in `irb` ( _if you prefer `pry` go with it_ )
4. With Tic Tac Toe it's quite easy to build it all using 1 class (crazy I know). Once you've decided on your classes this can always be changed. If inside hypethtical tic tac toe class you have a lot of methods refering to a board or a grid this is a huge indication that a class is screaming ** make me, make me **.

## Supporting Material

### Videos

- [Class Methods](https://www.youtube.com/watch?v=_I6ft00Ep9c)
- [Blocks, Procs &amp; Lambdas](https://www.youtube.com/watch?v=2HTR4oOZ9iM)
- [SOLID](https://www.youtube.com/watch?v=dBMcKzlfgSk)
- [SOLID II](https://www.youtube.com/watch?v=x-bX66IzcWM)

### Resources

- [Makers Lecture - Blocks, Procs and Lambdas](https://www.youtube.com/watch?v=2HTR4oOZ9iM)
- [SOLID - Wikipedia](https://en.wikipedia.org/wiki/Solid_(object-oriented_design))
- [Principles of OOD - Robert C. Martin (unclebob)](http://www.butunclebob.com/ArticleS.UncleBob.PrinciplesOfOod)
- [User experience design - Wikipedia](https://en.wikipedia.org/wiki/User_experience_design)
- [User interface design - Wikipedia](https://en.wikipedia.org/wiki/User_interface_design)
- [UX Myths](http://uxmyths.com)

![Tracking pixel](https://githubanalytics.herokuapp.com/course/challenges/tic_tac_toe.md)
