## Creating Links

[Back to the Challenge Map](0_challenge_map.md)

You now have two passing feature tests, the second of which is creating and persisting data to the database.

As you might imagine the database will quickly fill up with a lot of data. In order for our tests to be reliable, the database needs to start in a clean state for every test.

In this challenge you will check for database cleanliness and use the DatabaseCleaner gem to ensure that the database is empty between tests.

## Learning Objectives covered

* Use DatabaseCleaner to remove data from a test database

## To complete this challenge, you will need to

- [ ] Create a test that checks that there are 0 links in the database
- [ ] Check that this test fails
- [ ] Fix this test by installing the DatabaseCleaner gem

## Resources

* [DatabaseCleaner gem - GitHub](https://github.com/DatabaseCleaner/database_cleaner)

## [Solution](solutions/12.md)
