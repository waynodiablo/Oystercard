## Authentication

[Back to the Challenge Map](00_challenge_map.md)

> Want to jump in on this challenge? Start from [this commit](https://github.com/sjmog/bookmark_manager/commit/d3fa868bb2699924cd3418ef77aec697cbbc26b8).

Bookmark Manager now has user registration. However, users can only sign up – they can't sign in or out.

In this challenge, you will implement sign in and out, which together are called **authentication**.

## Learning Objectives covered

* Build an Authentication system.

## To complete this challenge, you will need to

- [ ] Write a feature test for successful sign-in. _Wondering what to call your routes? Signing in is often thought of as 'creating a new session'._
- [ ] Implement successful sign-in:
  - [ ] Create the sign-in form.
  - [ ] On submission, use the user's email to find the user's data. Then wrap that data.
  - [ ] Set the `user_id` in the session to the User ID.
  - [ ] Redirect to the bookmarks page.
- [ ] Refactor the sign-in SQL into an `authenticate` class method on `User`.
- [ ] Write a feature test for unsuccessful sign-in: for instance, a user getting their email or password wrong.
- [ ] Implement unsuccessful sign-in:
  - [ ] Add a guard clause to `authenticate` that checks if a user exists with the provided email, and returns `nil` if not.
  - [ ] Add another guard clause to `authenticate` that checks if a user entered their password correctly (you can use `BCrypt::Password.new` to wrap the submitted password and compare), and returns `nil` if not.
  - [ ] If a user gets their email or password wrong, display an error and redirect to the sign-in form.
- [ ] Write a feature test for signing out. _Wondering what to call your routes? Signing out is often thought of as 'destroying a session'._
- [ ] Implement signing out:
  - [ ] Add a 'Sign out' button that destroys the session.
  - [ ] Clear the session and use the Flash to let the user know they've signed out.

## Resources

* [How to use bcrypt-ruby in general](https://github.com/codahale/bcrypt-ruby)

## [Walkthrough](walkthroughs/19.md)
