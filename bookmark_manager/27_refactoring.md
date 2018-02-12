## Refactoring

[Back to the Challenge Map](00_challenge_map.md)

You now have a fully functioning signup, sign in and sign out mechanism. This is a good time to refactor our code somewhat as things have got a bit messy.  The app.rb file is full of routes and the layout file is full of lots of boolean logic.

In this challenge you will extract routing logic into a series of controllers and use partials to divide up the layout file into a series of smaller 'partial' views.

## Learning Objectives covered

* Be able to work with sinatra partials
* Refactor Sinatra Controllers

## To complete this challenge, you will need to

- [ ] Extract the `app.rb` routing logic into several controller files in `app/controllers`
- [ ] Use partials to divide up the layout file into a series of smaller 'partial' views
- [ ] Ensure that at each stage that all your tests pass, as well as testing manually on local and on Heroku

## Resources

* [Sinatra Partial](https://github.com/yb66/Sinatra-Partial)
* [Sinatra MVC](http://stackoverflow.com/questions/5015471/using-sinatra-for-larger-projects-via-multiple-files/5030173#5030173)

## [Walkthrough](walkthroughs/25.md)
