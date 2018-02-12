## Levels of Validation

[Back to the Challenge Map](00_challenge_map.md)

The user experience of sign up is somewhat improved.  We are validating that the user is setting their password correctly.  However we need some additional validations, such as ensuring that a user provides an email address and that it is correctly formatted.

In this challenge you will create functionality for validating the user supplied email address.

## Learning Objectives covered

* Use validation within models

## To complete this challenge, you will need to

- [ ] Ensure a user can't sign up with a blank email address:
  - [ ] Write a failing feature test to ensure a user can't sign up without entering an email
  - [ ] Use HTML5 client side validation to prevent the form being submitted when the email field is empty.
  - [ ] Research why it's important to have model validation **as well as** client side validation.
  - [ ] Confirm that, despite your client side validation, your feature test still fails.
  - [ ] Add an appropriate DataMapper validation, and check the test now passes
  - [ ] Research why it's important to have database validation **as well as** model and client side validation.
  - [ ] Add a database level constraint for the same thing, and see if the test passes without the DataMapper validation
- [ ] Ensure a user can't sign in with an email address that has an invalid format (e.g. `invalid@email`):
  - [ ] Write a failing feature test to ensure a user can't sign up with an email address that has an invalid format.
  - [ ] Use HTML5 client side validation to check the user's email address has a valid format.
  - [ ] Confirm that this will not make the test pass.
  - [ ] Add an appropriate DataMapper validation, and check the test now passes
- [ ] Ensure to test manually, locally and on Heroku

## Resources

* [HTML5 Form Validation](https://developer.mozilla.org/en-US/docs/Web/Guide/HTML/Forms/Data_form_validation)
* [DataMapper Validations](http://datamapper.org/docs/validations.html)
* [DM Validations](https://github.com/datamapper/dm-validations)
* [PostgreSQL constraints](http://www.postgresql.org/docs/9.4/static/ddl-constraints.html)

## [Walkthrough](walkthroughs/23.md)
