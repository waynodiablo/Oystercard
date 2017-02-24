# Entering Players

[Back to the Challenge Map](README.md)

We have a basic project structure. Let's consider our first User Story:

```
As two Players,
So we can play a personalised game of Battle,
We want to Start a fight by entering our names and seeing them
```

In this challenge, you will allow players to enter their names and see them on-screen.

### Learning Objectives covered
- Use `params` to extract information from a request
- Write a feature test using Capybara
- Pass a feature test using Capybara

### To complete this challenge, you will need to:

- [ ] In `spec/features`, add a new Capybara feature test that expects players to fill in their names (in a form), submit that form, and see those names on-screen
- [ ] Create a `get '/'` route that renders a`index.erb` view with a form
- [ ] Point the `index.erb` form action to a `post '/names'` route
- [ ] Create a `post '/names'` route that uses `params` to render a `play.erb` view that displays the names
- [ ] Pass the feature test you wrote.

### Resources

- [Capybara Cheat Sheet](https://www.launchacademy.com/codecabulary/learn-test-driven-development/rspec/capybara-cheat-sheet)
- :pill: [`params`](../pills/params.md)
- [My First HTML form (MDN)](https://developer.mozilla.org/en-US/docs/Web/Guide/HTML/Forms/My_first_HTML_form)
- [How are parameters sent in an HTTP POST request? (Stack Overflow)](http://stackoverflow.com/questions/14551194/how-are-parameters-sent-in-an-http-post-request)
- [Relishapp notes on feature specs with capybara] (https://www.relishapp.com/rspec/rspec-rails/docs/feature-specs/feature-spec)

### [Walkthrough](walkthroughs/18_entering_players.md)
