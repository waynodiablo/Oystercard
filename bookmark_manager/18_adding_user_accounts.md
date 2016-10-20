## Adding User Accounts

[Back to the Challenge Map](00_challenge_map.md)

You have now completed the original specification of the bookmark manager. Let's extend it to work for multiple users.

In this challenge you will create the functionality for signing up for a user account.

## Learning Objectives covered

* Understand that BCrypt is a library for encrypting/decrypting strings
* Explain that BCrypt functionality can be included in Ruby models by including the bcrypt gem
* Use BCrypt to encrypt a password and save it to the database
* Use session to manage a user's authenticated state
* Construct a form for signing up ('registering') a user
* Create a basic registration/authentication system from scratch

## To complete this challenge, you will need to

- [ ] Write a failing feature test that:
  - [ ] Visits a URL, sees a signup form, enters an email and password and submits the form.
  - [ ] Checks that, when the form is submitted, the browser is directed to a new page that shows a user welcome message.
  - [ ] Checks that the email address entered is displayed on the welcome page.
  - [ ] Checks that the `User` count increases by 1.
- [ ] Make the test pass
- [ ] Ensure that both the signup form URL and welcome page URL are RESTful.
- [ ] Ensure that your `User` model supports an encrypted Password
- [ ] Ensure that Sinatra is configured to have encrypted sessions
- [ ] Deploy to Heroku and check your code works online

## Resources

* [RESTful URLs](http://microformats.org/wiki/rest/urls)
* [Password Hashing](https://crackstation.net/hashing-security.html)
* [Sinatra Sessions](http://www.sinatrarb.com/intro.html#Using%20Sessions)
* [Bcrypt Ruby](https://github.com/codahale/bcrypt-ruby)
* [Bcrypt - Wikipedia](https://en.wikipedia.org/wiki/Bcrypt)
* [Helper methods](http://www.sinatrarb.com/intro.html#Helpers)
* [Lazy initialization](http://blog.jayfields.com/2007/07/ruby-lazily-initialized-attributes.html)
* [Memoization](http://gavinmiller.io/2013/basics-of-ruby-memoization/)

## [Walkthrough](walkthroughs/18.md)
