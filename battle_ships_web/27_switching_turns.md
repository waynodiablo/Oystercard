# Switching Turns

[Back to the Challenge Map](00_challenge_map.md)

We now have a game where we can damage an opponent. It's neatly refactored with 'skinny' controllers, and our Model layer is handling most of the calculations (like hit points). However, our game is kind of one-sided. While that might be quite fun enough for some people, the majority of our users at least want the opportunity to lose the game.

Our next User Story helps us tackle this:

```
As two Players,
So we can continue our game of Battle,
We want to switch turns
```

In this challenge, we will implement a turn switcher on `Game`. This challenge combines together steps from many previous challenges: check them if you get stuck.

### Learning Objectives covered
- Write a feature test using Capybara
- Pass a feature test using Capybara
- Implement a feature from the Model layer
- Refactor a controller to make it 'skinny'

### To complete this challenge, you will need to:

- [ ] Write and implement a Capybara-driven feature test for switching turns.

### Resources

- [Capybara Cheat Sheet](https://www.launchacademy.com/codecabulary/learn-test-driven-development/rspec/capybara-cheat-sheet)
- [Separation of Concerns](https://en.wikipedia.org/wiki/Separation_of_concerns)
- [Skinny Controllers, Skinny Models (Thoughtbot)](https://robots.thoughtbot.com/skinny-controllers-skinny-models)
- [Sandi Metz' Rules for Developers (Thoughtbot)](https://robots.thoughtbot.com/sandi-metz-rules-for-developers)

### [Solution](solutions/27_switching_turns.md)