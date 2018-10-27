## Upgrading your toolset

[Back to the Challenge Map](00_challenge_map.md#challenges)

We've built a Sinatra application that can read bookmarks from the bookmark_manager database and display them to the user. interacted with the database via `psql`, PostgreSQL's built-in interface. We've also interacted with the database in Ruby, via `pg`, PostgreSQL's official Ruby interface.

In the next few challenges, we're going to:

- Upgrade our tooling so we can see what's going on in our database more easily.
- Add the 'create new bookmarks' feature to our application using the `pg` gem.
- Refactor all the complicated SQL in our `Bookmark` model using an Object-Relational Map.

> Feel free to just have a go at doing the stuff above yourself!

In this challenge, you will play with some tooling that gives you more insight into your database.

## Learning Objectives covered

* Use database GUIs to interact with databases.

## To complete this challenge, you will need to

- [ ] Download and install [TablePlus](https://tableplus.io/).
- [ ] Connect TablePlus to your PostgreSQL database management system.
- [ ] Use the `INSERT`, `UPDATE`, `DELETE`, and `SELECT` commands within TablePlus to add, update, delete, and read some data from the `bookmarks` table in the `bookmark_manager` database.
- [ ] Run your Sinatra application, and watch new bookmarks appearing in the application when you add them to the database via TablePlus.

> Adding and changing bookmarks to your database will probably break your feature test. We'll look at solving this problem in the next challenge.

## Resources

* [Why we built TablePlus](https://medium.com/tableplus/modern-native-tool-for-relational-database-79efc35b647d)

## [Walkthrough](walkthroughs/08.md)


![Tracking pixel](https://githubanalytics.herokuapp.com/course/bookmark_manager/08_upgrading_your_toolset.md)
