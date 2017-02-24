# Skinny Controllers

[Back to the Challenge Map](README.md)

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

- [Forget fat models: it’s time for skinny controllers and skinny models](https://medium.com/makers-academy/forget-fat-models-its-time-for-skinny-controllers-and-skinny-models-a9b84ec481b7#.8vs2uzw1f)
- [Sandi Metz' Rules for Developers (Thoughtbot)](https://robots.thoughtbot.com/sandi-metz-rules-for-developers)

*This article contains some bad taste in their analogies - we apologise and are working on a suitable replacement.

### [Walkthrough](walkthroughs/skinny_controllers.md)
