## Improving the sign up workflow

[Back to the Challenge Map](00_challenge_map.md)

Now you have implemented the password confirmation functionality you can be sure that users have signed up with the correct password.

However our code does not have any logic for handling the situation when the user enters an incorrect password confirmation. It just fails silently, redirecting the user to the links page. In the controller, the user.id will be nil because datamapper won't save the record if the validations fail.

In this challenge you will create functionality for handling the situation when the passwords do not match.

## Learning Objectives covered

* Use the flash to display messages to users

## To complete this challenge, you will need to

- [ ] You already have a test that checks that a user cannot signup if they enter a password and password confirmation that don't match.  Extend this test by:
  - [ ] Checking the browser stays on the `/users` page
  - [ ] Checking the page displays a message that 'Password and confirmation password do not match'
- [ ] Make the test pass by:
  - [ ] Updating the controller logic
  - [ ] Using the sinatra-flash gem to show the error message in the view
- [ ] Improve the user experience by ensuring that the user's email is persisted in the signup form after a password confirmation mismatch

## Resources

* [Sinatra Flash](https://github.com/SFEley/sinatra-flash)
* [Web Form Usability](http://www.smashingmagazine.com/2011/11/extensive-guide-web-form-usability/)

## [Walkthrough](walkthroughs/22.md)
