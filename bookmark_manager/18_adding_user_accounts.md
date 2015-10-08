## Adding User Accounts

[Back to the Challenge Map](0_challenge_map.md)

At this point you have implemented the full functionality of the bookmark manager. At the moment
the application only works for a single user. As with pinapple.io and delicious.com we would like
to provide this functionality to multiple users so that each user can organise their own data as well
as view how others have organised theirs.

In this challenge you will create the functionality for signing up for a user account.

## Learning Objectives covered

* Bcrypt as a library for encrypting/decrypting strings
* Explain that Bcrypt functionality can be included in Ruby models by including the bcrypt gem
* Use Bcrypt to encrypt a password and save it to the database
* Use session to manage a user's authenticated state

## To complete this challenge, you will need to

- [ ] Write a failing feature test that checks the following:
  - [ ] when a user signs up the `User` count increases by 1
  - [ ] the page displays a welcome message to the new user
  - [ ] the email address on that user in the database is correct.
- [ ] As usual this test should fail, make it pass with the appropriate changes to your
models, views and controllers.
- [ ] Ensure that your `User` model supports an encrypted Password
- [ ] Ensure that Sinatra is configured to have encrypted sessions
- [ ] Deploy to heroku and perform manual test for this functionality

## Resources

* [Password Hashing](https://crackstation.net/hashing-security.html)
* [Sinatra Sessions](http://www.sinatrarb.com/intro.html#Using%20Sessions)
* [Bcrypt Ruby](https://github.com/codahale/bcrypt-ruby)
* [Bcrypt - Wikipedia](https://en.wikipedia.org/wiki/Bcrypt)
* [Helper methods](http://www.sinatrarb.com/intro.html#Helpers)
* [Lazy initialization](https://en.wikipedia.org/wiki/Lazy_initialization#Ruby)

## [Solution](solutions/18.md)
