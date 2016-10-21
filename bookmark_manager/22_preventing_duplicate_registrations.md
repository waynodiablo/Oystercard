## Preventing Duplicate Registrations

[Back to the Challenge Map](00_challenge_map.md)

In this challenge, you'll add a validation that checks that no existing user has already registered with the entered email.  You'll also add code that shows a meaningful error message to the user in this case.

And you'll add code that shows the user a meaningful error message if they doesn't enter an email address at all.

## Learning Objectives covered

* Use validation within models
* Use the flash to display messages to users
* Use validation within models through DataMapper's validates_uniqueness_of method
* Use validation at the database level through DataMapper's :unique option
* Using DataMapper validation error messages

## To complete this challenge, you will need to

- [ ] Write a failing feature test that checks that:
  - [ ] A user can not sign up with an already registered email address.
  - [ ] An error message is displayed to the user
- [ ] Make the test pass by adding the correct validation and displaying the message using the flash
- [ ] Update your previous feature tests that check email validation to check that appropriate messages are shown to the user
- [ ] Make those tests pass
- [ ] Ensure to test manually, locally and on Heroku

## Resources

* [DataMapper Validations](http://datamapper.org/docs/validations.html)
* [DM Validations](https://github.com/datamapper/dm-validations)
* [Sinatra Flash](https://github.com/SFEley/sinatra-flash)

## [Walkthrough](walkthroughs/22.md)
