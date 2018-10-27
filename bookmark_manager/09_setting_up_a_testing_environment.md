# Setting up a Testing Environment

[Back to the Challenge Map](00_challenge_map.md#challenges)

We've built a Sinatra application that can read bookmarks from the bookmark_manager database and display them to the user. We've also interacted with the database via `psql`, `pg`, and now a GUI, TablePlus.

> `psql`, `pg` and TablePlus are **interfaces** to the PostgreSQL server.

Right now, we have a problem:

- Our feature and unit tests expect three specific bookmarks.
- We've been adding bookmarks and changing bookmarks in the `bookmark_manager` database via `psql`, `pg`, and TablePlus.

So, our feature test is probably failing right now. It's a real pain to have to change the data back to the 'just right' three bookmarks every time we want to run that feature test.

And, in future, we're planning on enabling the user to add more bookmarks. This problem is going to get worse!

In this challenge, you will write a script to **reset your database** every time you run the tests. You'll build a **test environment** for your web application.

> If you did not manage to isolate your unit test for `Bookmark.all` in step 7, then this might also be failing.

## Learning Objectives covered

* Set up a test environment.

## To complete this challenge, you will need to

- [ ] Create a **test** database, `bookmark_manager_test`, with a `bookmarks` table.
- [ ] You are using the databases in the correct contexts, so that:
  - [ ] When you run tests using `rspec`, bookmarks are read from the new `bookmark_manager_test` database.
  - [ ] When you run the application locally, bookmarks are read from the `bookmark_manager` database.
- [ ] Write a helper method that **truncates** (empties) the `bookmarks` table in the test database before each test run.
- [ ] Run this helper method automatically right before **each** RSpec spec, so every test starts with a 'clean' test database.
- [ ] Add required test bookmarks to the `bookmark_manager_test` database in the feature and `Bookmark` tests.
- [ ] Make sure your feature and unit tests are passing.
- [ ] Update your database setup instructions to include the test database.

## Hints
&nbsp;<details><summary>CLICK ME</summary>
#### Switching database depending on environment

You might want to use an [Environment Variable](http://blog.honeybadger.io/ruby-guide-environment-variables/), e.g. `ENV`, to store the current environment. You could then use it to connect to the correct database for your environment.

Think about how you can ensure that the environment variable is assigned a particular value every time you run RSpec. For example, the `spec_helper.rb` file is run when you use `rspec`.

How could you use this environment variable to connect to the `bookmark_manager_test` database? You'll probably need to check the environment variable, and use this value to decide which database to connect to.

#### Dropping and re-creating tables between tests

Investigate the difference between `TRUNCATE` and `DROP TABLE` in PostgreSQL.

You might want to write a helper method in a new file, `setup_test_database.rb`, that uses `pg` to remove the bookmarks table using `DROP TABLE IF EXISTS`, and then re-create the table. Try running this helper method manually before you run your tests and see what happens.

#### Using the helper method with RSpec

The `spec/spec_helper.rb` is automatically executed whenever you run `rspec` (see your `.rspec` for why). In the Spec Helper, you can configure RSpec. You can make something happen before every spec with the following:

```ruby
config.before(:each) do
  # Whatever you put here will happen before each spec runs.
end
```

> You can call methods, and even use filesystem commands like `require` and `load` inside this `configure` block.

#### Adding expected bookmarks

You can `require` and use `pg` in your specs too: for instance, to insert data into the database in each `it()` block.

#### Passing failing tests
Once your feature test is passing, your unit tests for `Bookmark.all` are probably failing. Think about what the mock `PG` object is expecting to receive when `connect` is called.
&nbsp;</details>

## Resources

* [Environment Variables in Ruby](http://blog.honeybadger.io/ruby-guide-environment-variables/)
* [How do I get the current Rack Environment?](https://stackoverflow.com/questions/15459569/how-to-get-the-current-rack-environment-in-rake)
* [PostgreSQL `DROP TABLE IF EXISTS` command](https://www.postgresql.org/docs/8.2/static/sql-droptable.html)
* [PostgreSQL `TRUNCATE` command](https://www.postgresql.org/docs/8.2/static/sql-truncate.html)
* [Difference between TRUNCATE ab DROP TABLE](https://stackoverflow.com/questions/135653/difference-between-drop-table-and-truncate-table)
* [Running a command before each RSpec test](https://stackoverflow.com/questions/9958110/is-it-possible-to-add-somewhere-a-beforeeach-hook-so-that-all-spec-file-c)

## [Walkthrough](walkthroughs/09.md)


![Tracking pixel](https://githubanalytics.herokuapp.com/course/bookmark_manager/09_setting_up_a_testing_environment.md)
