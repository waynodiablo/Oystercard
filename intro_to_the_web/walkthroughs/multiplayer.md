# Walkthrough – Multiplayer

[Back to the Challenge](../multiplayer.md)

Let's implement our User Stories in turn. In this walkthrough, I'll link you to my git commits for implementing each story. You should be able to interpret my intentions from the commit itself.

Our first User Story:

```
As Player 1,
So I can see how close I am to losing,
I want to see my own hit points
```

Head [here](https://github.com/sjmog/battle/commit/d5289ab67bb0c7b45a5d866a4915ec51d9afcc31) for the git commit solving this story (it's a very simple one).

Our second User Story:

```
As Player 1,
So I can lose a game of Battle,
I want Player 2 to attack me, and I want to get a confirmation
```

Head [here](https://github.com/sjmog/battle/commit/5e299b1f038c9c29c607262d64bf648508a55bbf) to see the git commit solving this story.

> Somewhat naughtily, I have also refactored the confirmation page 'OK' form to use a POST request. I've done this as clicking 'OK' now changes the state of the server (it switches the turn).

Our third User Story:

```
As Player 1,
So I can start to lose a game of Battle,
I want Player 2's attack to reduce my HP
```

Head [here](https://github.com/sjmog/battle/commit/480e6433eb825a5bce4b9221fe99c8aa15775e98) to see the git commit solving this story.

> I'm not happy with this commit. I don't like how `app.rb` calls `@game.attack(@game.opponent_of(@game.current_turn))`: this violates the ['Tell, don't Ask'](https://robots.thoughtbot.com/tell-dont-ask) principle of good program design. Can you refactor your approach to be better?

By this point, I was concerned that `Game` was getting overly-responsible again, so I [refactored an `Attack` object](https://github.com/sjmog/battle/commit/0e95307771acd92b6d898a3c1138c03be835696b) out of my code. The pattern I used was inspired by [this Thoughtbot article](https://robots.thoughtbot.com/meditations-on-a-class-method).

Once you're happy you have approximated solutions to these feature tests, let's move on to losing and winning the game.

[Forward to the Challenge Map](../README.md)


![Tracking pixel](https://githubanalytics.herokuapp.com/course/intro_to_the_web/walkthroughs/multiplayer.md)
