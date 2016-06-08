## Viewing Links

[Back to the Challenge Map](00_challenge_map.md)

You should now have a understand the following key database concepts:

- how to set up a database; 
- creating tables; 
- manipulating table data via SQL &amp; an ORM (DataMapper), and 
- the unifying concept of CRUD.  

Now, it's time to play with those skills and construct a full-stack web application.

We have [a mockup and some user stories](01_creating_user_stories.md). Since you are a conscientious, Behaviour-Driven Developer, you will create a feature test for the first user story:

```
As a time-pressed user
So that I can quickly go to web sites I regularly visit
I would like to see a list of links on the homepage
```

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

## [Walkthrough](walkthroughs/08.md)
