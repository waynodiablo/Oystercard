## Preventing Duplicate Registrations

[Back to the Challenge Map](0_challenge_map.md)

The application now validates that a user can not sign up without an email address. Currently it does not provide any form of feedback to the user as to why the sign up fails. As we saw in the Improving Sign Up Workflow challenge this can be improved.

In this challenge you will add a validation that checks that email addresses are unique and display meaningful messages to the user.

## Learning Objectives covered

* Use validation within models (new LO!!!)
* Use the flash to display messages to users
* Use validation within models through DataMapper's validates_uniqueness_of method
* Use validation at the database level through DataMapper's :unique option
* Using DataMapper validation error messages

## To complete this challenge, you will need to

- [ ] Write a failing feature test that checks that:
  - [ ] A user can not sign up with an already registered email address
  - [ ] The correct message is displayed to the user based on the error
- [ ] Make the test pass by adding the correct validation and displaying the message using the flash
- [ ] Update your previous feature test for having an email address present to also display the correct message
- [ ] Make the test pass
- [ ] Ensure to test manually locally and on Heroku

## Resources

* [DataMapper Validations](http://datamapper.org/docs/validations.html)
* [DM Validations](https://github.com/datamapper/dm-validations)
* [Sinatra Flash](https://github.com/SFEley/sinatra-flash)

## [Solution](solutions/22.md)
