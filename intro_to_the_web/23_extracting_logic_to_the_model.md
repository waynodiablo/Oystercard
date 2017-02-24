# Extracting Logic to the Model

[Back to the Challenge Map](README.md)

We have now implemented a handful of User Stories. At the moment, our Battle app is going through the motions, but nothing is really happening. Our next User Story asks us to do something about that:

```
As Player 1,
So I can start to win a game of Battle,
I want my attack to reduce Player 2's HP
```

This User Story is more complex than previous ones. It requires us to track HP, and to manipulate it on a per-player basis. This is far more than a simple **controller** or **router** should handle. Before we can reasonably implement it we should refactor our code to use some **Application logic** stored in a **Model layer**. We can store our Model layer in `/lib`, and access it from our controller. This is known as a **Separation of Concerns**.

In this challenge, you will create a `Player` class in the Model layer. It will interact with your existing controller code.

### Challenge Setup

We can imagine the layers of our program to be something like this:

```
    |  Incoming
    V  request
_____________________
|     Controller    |
---------------------
|       Model       |
_____________________
```

Our Controller (for now, anything in `app.rb`) will receive the incoming request and call the appropriate action (for example, `post '/names'`.

If the Controller action is complex - for example, it stores complex data (i.e. more than simple strings) or creates new objects - it should pass that sort of job over to the Model (for now, anything in `/lib`). Our Model will be the kind of Object-Oriented program you have been building so far. You could imagine that the Controller provides web access to your Ruby code from a browser.

### Important note

This challenge introduces the use of a Global Variable (`$variable`). In Ruby, the sight of a global variable is a major code smell :poo:. We are using a global variable here in lieu of a better approach that we'll introduce in the final challenge. **If you ever use a global variable in a hiring tech test, you will instantly fail. Don't do it.**

### Learning Objectives covered
- Refactor code to the Model layer

### To complete this challenge, you will need to:

- [ ] Create a new spec file for a `Player` class, `spec/player_spec.rb`
- [ ] Give `Player` a tested method that returns its name
- [ ] `require` the `Player` class in your controller file, `app.rb`
- [ ] Instead of storing player names as strings in the `session`, store them as attributes of instances of the `Player` class in global variables (declared using `$`)
- [ ] Commit to memory the fact that using a global variable will ruin any tech tests you do, and promise to your pair partner that you never will
- [ ] Update your instance variables to reference the `Player` instances rather than the `session` keys
- [ ] Ensure all your tests still pass.

### Resources

- [Separation of Concerns](https://en.wikipedia.org/wiki/Separation_of_concerns)

### [Walkthrough](walkthroughs/23_extracting_logic_to_the_model.md)
