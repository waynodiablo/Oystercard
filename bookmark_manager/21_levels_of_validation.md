## Levels of Validation

[Back to the Challenge Map](0_challenge_map.md)

The User experience of sign up is somewhat improved.  We are validating that the user is setting their password correctly.  However we need some additional validations, such as ensuring that a user provides an email address.

In this challenge you will create functionality for validating the user supplies an email address.

## Learning Objectives covered

* Configure password verification with a password_confirmation field
* Use validation within models (new LO!!!)

## To complete this challenge, you will need to

- [ ] Write a failing feature test to ensure a user can't sign up without entering an email
- [ ] Add a check on the client side using html5 and confirm that this will NOT make the test pass AND try it manually
- [ ] Add an appropriate DataMapper validation, and check the test now passes
- [ ] Add a database level constraint for the same thing, and see if the test passes without the DataMapper validation
- [ ] Ensure to test manually locally and on Heroku

## Resources

* [HTML5 Form Validation](https://developer.mozilla.org/en-US/docs/Web/Guide/HTML/Forms/Data_form_validation)
* [DataMapper Validations](http://datamapper.org/docs/validations.html)
* [DM Validations Gem](https://github.com/datamapper/dm-validations)
* [PostGreSQL constraints](http://www.postgresql.org/docs/9.4/static/ddl-constraints.html)

## [Solution](solutions/21.md)
