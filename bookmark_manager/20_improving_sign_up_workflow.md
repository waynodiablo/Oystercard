## Improving the sign up workflow

[Back to the Challenge Map](00_challenge_map.md)

Now you have implemented the password confirmation functionality you can be sure that users have signed up with the correct password.

However our code does not have any logic for handling the situation when the user enters an incorrect password confirmation. It just fails silently, redirecting the user to the links page. In the controller, the user.id will be nil because datamapper won't save the record if the validations fail.

In this challenge you will create functionality for handling the situation when the passwords do not match.

## Learning Objectives covered

* Use the flash to display messages to users

## To complete this challenge, you will need to

- [ ] Extend your existing test for password confirmation to include checks for:
  - [ ] The browser stays on the `/users` page
  - [ ] The page should display a message that 'Password and confirmation password do not match'
- [ ] Make the test pass by:
  - [ ] Updating the controller logic
  - [ ] Using the sinatra-flash gem to show the error message in the view
- [ ] Improve the user experience by ensuring that the email is persisted in the form after
a password confirmation mismatch

## Resources

* [Sinatra Flash](https://github.com/SFEley/sinatra-flash)
* [Web Form Usability](http://www.smashingmagazine.com/2011/11/extensive-guide-web-form-usability/)
* [Web Forms](http://thoughtfulweb.com/thoughts/on/web-forms-a-great-big-user-experience-brick-wall)

## [Solution](solutions/20.md)
