## Password Confirmation

[Back to the Challenge Map](00_challenge_map.md)

Now a user can register on our website but it would be nice to ask for password confirmation on registration to make sure there's no mistake in the password.

In this challenge you will create password confirmation functionality.

## Learning Objectives covered

* Configure password verification with a password_confirmation field
* Use validation within models

## To complete this challenge, you will need to

- [ ] Write a failing feature test that:
  - [ ] Fills in an email and password into the user signup form.
  - [ ] Fills in a **mismatching** confirmation password into the user signup form.
  - [ ] Checks that when the form is submitted, no new users are created.
- [ ] As usual this test should fail, make it pass with the appropriate changes to your
models, views and controllers.
- [ ] Use `validates_confirmation_of` to validate that the passwords match
- [ ] Deploy to Heroku and perform manual test for this functionality

## Resources

* [DataMapper validates_confirmation_of](http://www.rubydoc.info/gems/dm-validations/DataMapper/Validations/ValidatesConfirmation)
* [DataMapper Validations](http://datamapper.org/docs/validations.html)
* [DM Validations](https://github.com/datamapper/dm-validations)
* [Why confirm password fields must die](http://uxmovement.com/forms/why-the-confirm-password-field-must-die/)
* [Do You Need To Confirm/Verify Passwords On Sign Up?](http://www.leemunroe.com/confirm-passwords-signup/)

## [Walkthrough](walkthroughs/21.md)
