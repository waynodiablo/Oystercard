## Password Recovery

[Back to the Challenge Map](00_challenge_map.md)

Now that you have refactored your application you can move on to the final feature. In this
challenge you will implement password recovery, this allows users who have forgotten their password
to be able to reset it to a new one.

## Learning Objectives covered

* Be able to work with sinatra partials (new LO!!!!)
* Refactor Sinatra Controllers (new LO!!!!)

## To complete this challenge, you will need to

- [ ] Write a failing test that ensures that when a user requests a password reset:
  - [ ] The user has a password token set
  - [ ] They receive the appropriate message on the password reset page
- [ ] Make the test pass
- [ ] Write a failing test that ensures that when a user visits the password reset page with a correct token:
  - [ ] The user is prompted to enter a new password
  - [ ] The password is actually changed
  - [ ] The password reset token is reset to nil
- [ ] Ensure that at each stage that all your tests pass, as well as testing manually on local and on Heroku

## Resources

* [Sinatra Partial](https://github.com/yb66/Sinatra-Partial)
* [Sinatra MVC](http://stackoverflow.com/questions/5015471/using-sinatra-for-larger-projects-via-multiple-files/5030173#5030173)

## [Solution](solutions/25.md)
