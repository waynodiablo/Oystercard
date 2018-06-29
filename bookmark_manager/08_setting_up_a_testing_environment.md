# Setting up a Testing Environment

[Back to the Challenge Map](00_challenge_map.md#challenges)

We've built a Sinatra application that can read bookmarks from the bookmark_manager database and display them to the user. We've also interacted with the database via `psql`, `pg`, and now a GUI, TablePlus.

> `psql`, `pg` and TablePlus are **interfaces** to the PostgreSQL server.

Right now, we have a problem:

- Our feature and unit tests expect three specific bookmarks.
- We've been adding bookmarks and changing bookmarks via `psql`, `pg`, and TablePlus.

So, our feature and unit tests are probably failing right now. It's a real pain to have to change the data back to the 'just right' three bookmarks every time we want to run that feature test.

And, in future, we're planning on enabling the user to add more bookmarks. This problem is going to get worse!

In this challenge, you will write a script to **reset your database** every time you run the tests. You'll build a **test environment** for your web application.

## Learning Objectives covered

* Set up a test environment.

## To complete this challenge, you will need to

- [ ] Create a **test** database, `bookmark_manager_test`, with a `bookmarks` table.
- [ ] Enable the following condition somehow:
  - [ ] When you run your application using `rackup`, bookmarks are read from the `bookmark_manager` database.
  - [ ] When you run your application tests using `rspec`, bookmarks are read from the `bookmark_manager_test` database.
- [ ] Write a script that **truncates** (empties) the `bookmarks` table in the test database before each test run.
- [ ] Run this script automatically right before **each** RSpec spec, so every test starts with a 'clean' test database.
- [ ] Add required test bookmarks in each test that expects them.

## Hints

#### Switching database depending on environment

You might want to use the global Rack [Environment Variable](http://blog.honeybadger.io/ruby-guide-environment-variables/), `ENV`, as a variable that stores the current environment. You could then use it to connect to the correct database for your environment.

Think about how you can ensure that the variable is assigned a particular value every time you run RSpec.

#### Truncating tables between tests

You might want to write a script, `setup_test_database.rb`, that uses `pg` to `TRUNCATE` the bookmarks table.

#### Integrating external scripts with RSpec

The `spec/spec_helper.rb` is automatically executed whenever you run `rspec` (see your `.rspec` for why). In the Spec Helper, you can configure RSpec. You can make something happen before every spec with the following:

```ruby
config.before(:each) do
  # Whatever you put here will happen before each spec runs
end
```

> You can call methods, and even use filesystem commands like `require` and `load` inside this `configure` block.

#### Adding expected bookmarks

You can `require` and use `pg` in your specs too: for instance, to insert data into the database in each `it()` block.

## Resources

* [How do I get the current Rack Environment?](https://stackoverflow.com/questions/15459569/how-to-get-the-current-rack-environment-in-rake)
* [PostgreSQL `DROP TABLE IF EXISTS` command](https://www.postgresql.org/docs/8.2/static/sql-droptable.html)
* [PostgreSQL `TRUNCATE` command](https://www.postgresql.org/docs/8.2/static/sql-truncate.html)
* [Running a command before each RSpec test](https://stackoverflow.com/questions/9958110/is-it-possible-to-add-somewhere-a-beforeeach-hook-so-that-all-spec-file-c)

## [Walkthrough](walkthroughs/08.md)
