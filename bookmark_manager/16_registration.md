## Registration

[Back to the Challenge Map](00_challenge_map.md#challenges)

We've built a CRUD application for managing links. The routes are RESTful.

> Want to jump in to this challenge? Start from [this commit](https://github.com/sjmog/bookmark_manager/commit/ecdcdbca3e859127a2123ce10791f27e20eac76b).

Let's return to our specification:

* Show a list of links :white_check_mark:
* Add new links :white_check_mark:
* Delete links :white_check_mark:
* Update links :white_check_mark:
* Comment on Links :white_check_mark:
* Tag links into categories :white_check_mark:
* Filter links by tag :white_check_mark:
* Users manage their links

Our next challenge involves introducing a new model: `User`. This model will require its own table: `users`. Users are a very common kind of resource. Creating a new user is often called **registration** (or 'user sign up'). Registration usually involves creating a record with:

* An email address (or username).
* A password (which must be stored securely).

In this challenge, you will **register** new users.

## Learning Objectives

* Build a registration system.

## To complete this challenge, you will need to

- [ ] Complete a user **registration** feature:
  - [ ] Update the Rake tasks to set up a `users` table.
  - [ ] Write a feature test for user registration.
  - [ ] Taking inspiration from `Link`, write a `User` class with a method, `create`, which is called during registration.
  - [ ] When the user is created, store the user ID in the `session`.
  - [ ] Whenever the user's information is to be displayed to the user, `.find` the current user from the database using the ID stored in `session`.
- [ ] Ensure the user password is stored securely: not as a plain text string.

## Resources

* [How do I get the ID of a row I just `INSERT`ed?](https://stackoverflow.com/questions/17870010/how-to-get-the-id-of-the-row-inserted-from-pgresult)
* [`PG::Result` documentation](http://www.rubydoc.info/gems/pg/0.17.1/PG/Result)
* [You're probably storing passwords incorrectly](https://blog.codinghorror.com/youre-probably-storing-passwords-incorrectly/)
* [BCrypt, a secure password hasher](https://github.com/codahale/bcrypt-ruby)

## [Walkthrough](walkthroughs/16.md)
