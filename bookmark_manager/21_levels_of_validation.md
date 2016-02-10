## Levels of Validation

[Back to the Challenge Map](00_challenge_map.md)

The User experience of sign up is somewhat improved.  We are validating that the user is setting their password correctly.  However we need some additional validations, such as ensuring that a user provides an email address and that it is correctly formatted.

In this challenge you will create functionality for validating the user supplied email address.

## Learning Objectives covered

* Use validation within models

## To complete this challenge, you will need to

- [ ] Ensure a user can't sign up with a blank email address:
  - [ ] Write a failing feature test to ensure a user can't sign up without entering an email
  - [ ] Add a check on the client side using HTML5 and confirm that this will not make the test pass and try it manually
  - [ ] Add an appropriate DataMapper validation, and check the test now passes
  - [ ] Add a database level constraint for the same thing, and see if the test passes without the DataMapper validation
- [ ] Ensure a user can't sign in with an invalid formatted email adress (e.g. `invalid@email`):
  - [ ] Write a failing feature test to ensure a user can't sign up with an invalid formatted email address
  - [ ] Add a check on the client side using HTML5 and confirm that this will not make the test pass and try it manually
  - [ ] Add an appropriate DataMapper validation, and check the test now passes
- [ ] Ensure to test manually, locally and on Heroku

## Resources

* [HTML5 Form Validation](https://developer.mozilla.org/en-US/docs/Web/Guide/HTML/Forms/Data_form_validation)
* [DataMapper Validations](http://datamapper.org/docs/validations.html)
* [DM Validations](https://github.com/datamapper/dm-validations)
* [PostgreSQL constraints](http://www.postgresql.org/docs/9.4/static/ddl-constraints.html)

## [Walkthrough](walkthroughs/21.md)
