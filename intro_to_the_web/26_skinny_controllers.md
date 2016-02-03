# Skinny Controllers

[Back to the Challenge Map](00_challenge_map.md)

We just refactored the Model layer so our classes have one responsibility each. Now we're going to shrink some of the repetition in our Controller layer (in `app.rb`).

There is a saying when separating concerns like this:

> Keep your Controllers skinny.

It's an unpleasant phrase, but it's apt: in general, we want our controllers to do nothing more than small amounts of routing logic. Any of the complex stuff we want to push off into the Model. There's plenty of rationale for this: for one, you can reuse your Model layer with lots of different controllers if the Model layer stands independently.

In this challenge, you will refactor your controller to make it more 'skinny'. You'll also cut in half the number of pesky global variables :angry: we're using.

### Learning Objectives covered
- Refactor a controller to make it 'skinny'

### To complete this challenge, you will need to:

- [ ] Test-drive towards having `Game.new` accept two `Player` instances
- [ ] Change messages being called on `Player` instances to ones being called on a `Game` instance instead
- [ ] Replace the `$player_1` and `$player_2` global variables with references to a `$game` global variable that is instantiated when a game is started.

### Resources

- [Skinny Controllers, Skinny Models (Thoughtbot)](https://robots.thoughtbot.com/skinny-controllers-skinny-models)
- [Sandi Metz' Rules for Developers (Thoughtbot)](https://robots.thoughtbot.com/sandi-metz-rules-for-developers)

### [Walkthrough](solutions/26_skinny_controllers.md)