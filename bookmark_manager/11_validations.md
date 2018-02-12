## Validations

[Back to the Challenge Map](00_challenge_map.md)

We've built a Sinatra application that can read and write from and to a database. It's structured in an MVC style, and has test and development environments. New developers can setup the project by running `rake setup`.

Let's return to our specification:

* Show a list of links :white_check_mark:
* Add new links :white_check_mark:
* Delete links
* Update links
* Tag links into categories
* Filter links by tag

As part of the 'add new links' requirement, let's ensure that the user actually submits a link: not an empty string, or some other string.

In this challenge, you will create a **validation** that the submitted URL is, in fact, a URL.

## To complete this challenge, you will need to

- [ ] Add a new feature test that expects some kind of error message if the user does not submit a real URL.
- [ ] Pass this feature test by adding functionality to the `Link` model.

## Resources

* [How do I check if a URL is valid?](https://stackoverflow.com/questions/1805761/how-to-check-if-a-url-is-valid)
* [Sinatra Flash (for showing one-time messages)](https://github.com/SFEley/sinatra-flash)

## [Walkthrough](walkthroughs/11.md)
