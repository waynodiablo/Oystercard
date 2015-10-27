## Viewing Links

[Back to the Challenge Map](00_challenge_map.md)

You should now have a reasonable understanding of some key database concepts such as how to set up a database, creating tables, manipulating table data via SQL &amp; DataMapper and the unifying concept of CRUD.  Databases are one option for persisting data within an application.  Let's see how we can use this sort of persistence to help build our bookmark manager.

If you recall from [Challenge 1](01_creating_user_stories.md)( we have a mockup and a few user stories. The BDD cycle suggests we should always start with a feature test.

In this challenge you will be creating a feature test for the user story of a link being displayed, e.g.

```
As a time-pressed user
So that I can quickly go to web sites I regularly visit
I would like to see a list of links on the homepage
```

In the feature test we will use some DataMapper syntax to ensure that at least one bookmark (or link) is already persisted and available for display.

## Learning Objectives covered

* Use Capybara to create feature tests that include database functionality

## To complete this challenge, you will need to

- [ ] Setup a project named `bookmark_manager` with a Gemfile and RSpec/Capybara set up
- [ ] Write a feature test for the first user story
- [ ] Include DataMapper syntax to create a single `Link`
- [ ] Ensure the feature test fails on the DataMapper `Link` operation

## Resources

* [DataMapper Getting Started](http://datamapper.org/getting-started.html)
* [DataMapper CRUD operations](http://datamapper.org/docs/create_and_destroy.html)
* [Capybara Documentation](https://github.com/jnicklas/capybara)
* [Capybara Cheat Sheet](http://www.cheatography.com/ddovii/cheat-sheets/capybara-cheat-sheet/)

## [Solution](solutions/08.md)
