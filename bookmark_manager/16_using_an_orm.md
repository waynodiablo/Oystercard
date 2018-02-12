## Using an ORM

[Back to the Challenge Map](00_challenge_map.md)

We've built a CRUD application for managing links. The routes are RESTful.

Let's return to our specification:

* Show a list of links :white_check_mark:
* Add new links :white_check_mark:
* Delete links :white_check_mark:
* Update links :white_check_mark:
* Tag links into categories
* Filter links by tag

Our next challenge involves introducing a new model: `Tag`. This model will require its own table, and that table needs to connect to the `links` table.

Our current method – writing SQL in the model – is going to get very messy and complex when we start trying to join together data across `tags` and `links` tables.

We can use some existing software to make our job easier from here out.

In this challenge, you will swap out `Link`'s database interaction logic for the interface provided by the [DataMapper](http://datamapper.org/) ORM.

## To complete this challenge, you will need to

- [ ] Set up [DataMapper](http://datamapper.org/) and refactor the `Link` class to use it instead of our manual database interaction methods.
- [ ] Ensure all your tests are passing.

## Resources

* [DataMapper](http://datamapper.org/)

## [Walkthrough](walkthroughs/16.md)
