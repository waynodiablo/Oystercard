## Configuring database cleaner

[Back to the Challenge Map](00_challenge_map.md)

You now have two passing feature tests, the second of which is creating and persisting data to the database. If you inspect the `links` table in the database now, you'll notice that it's quickly filling up with a lot of data. In order for our tests to be reliable, the database needs to start in a clean state for every test.

In this challenge you will use the DatabaseCleaner gem to ensure that the database is empty between tests.

## Learning Objectives covered

* Use DatabaseCleaner to remove data from a test database

## To complete this challenge, you will need to

- [ ] Comment out the `Link.create(url: params[:url], title: params[:title])` in the `app.rb`. If you remove a line of code, a test should break. Is this the case?
- [ ] Discuss with your partner why it's important to clean up between tests
- [ ] Make the test fail by installing and configuring the DatabaseCleaner gem
- [ ] Make the test green again 

## Resources

* [DatabaseCleaner gem - GitHub](https://github.com/DatabaseCleaner/database_cleaner)

## [Solution](solutions/12.md)
