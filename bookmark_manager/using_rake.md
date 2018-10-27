## Using Rake

[Back to the Challenge Map](00_challenge_map.md#challenges)

We've built a Sinatra application that can read and write from and to a database. It's structured in an MVC style, and has test and development environments.

Whenever a new developer wants to clone and run our application, they have to dive into `psql` to set up test and development databases with the correct tables. That's a problem: we can make it easier for them.

In this challenge, you will use **Rake**, a **task runner**, to automate the tasks of setting up the database. You'll start by moving the test environment setup script to Rake, and write a script to set up a database through Rake.

## Learning Objectives covered

* Use Rake to automate environment tasks.

## To complete this challenge, you will need to

- [ ] Replace the setup test database script (the one that adds links to the database) with a Rake task.
- [ ] Replace the line in `spec_helper.rb` that runs the test database setup script with a call to the Rake task.
- [ ] Write a new Rake task to set up the development and test databases from scratch. It should run when a developer types `rake setup`.

## Resources

* [Rake (Github)](https://github.com/ruby/rake)
* [How do I run Rake tasks from Ruby files?](https://stackoverflow.com/questions/3530/how-do-i-run-rake-tasks-within-a-ruby-script)
* [Rake .invoke versus .execute](https://stackoverflow.com/questions/32381017/running-rake-tasks-in-rspec-multiple-times-returns-nil)

## [Walkthrough](walkthroughs/using_rake.md)


![Tracking pixel](https://githubanalytics.herokuapp.com/course/bookmark_manager/using_rake.md)
