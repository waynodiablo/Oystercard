## Interacting with PostgreSQL from Ruby

[Back to the Challenge Map](00_challenge_map.md#challenges)

We've built a Sinatra application that displays some hard-coded bookmarks. We've also created a database, added a database table, and played with some data in that table using `psql`.

In this challenge, you will get the application and database talking to each other.  You will remove the hard-coded array of bookmarks and your application will read them from a database instead.

## Learning Objectives covered

* Attach a database to a web application.

## To complete this challenge, you will need to

- [ ] Install the `pg` gem to your project.
- [ ] Test drive an update to the `.all` method of your `Bookmark` model, to do the following:
  - [ ] Use `PG` to connect to the PostgreSQL `bookmark_manager` database.
  - [ ] Retrieve all bookmark records from the `bookmarks` table.
  - [ ] Extract the URLs from the database response.
- [ ] Make sure you still pass the first feature, using this new response.
- [ ] Try adding and removing bookmarks via `psql` and check the `/bookmarks` page to see the results. How does this affect the tests?

## Hints
&nbsp;<details><summary>CLICK ME</summary>
- Use the [`pg` documentation](https://bitbucket.org/ged/ruby-pg/wiki/Home) to help you understand how your code will interact with `pg`.

- You can also `require 'pg'` in irb to investigate how it works.

- Depending on how closely you have been following the walkthroughs, you might see your tests failing as you work through this step.  Why might this be?

&nbsp;</details>

## Resources

* [Talking to PostgreSQL using Ruby via `pg`](http://zetcode.com/db/postgresqlruby/) (most useful is the section called 'Retrieving multiple rows of data')
* [`pg` documentation](https://bitbucket.org/ged/ruby-pg/wiki/Home)

## [Walkthrough](walkthroughs/07.md)
