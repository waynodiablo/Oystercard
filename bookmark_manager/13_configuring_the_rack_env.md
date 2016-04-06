## Configuring the Rack Environment

[Back to the Challenge Map](00_challenge_map.md)

Now that we have DatabaseCleaner, whenever we run the tests the contents of the database will be deleted, which is a good thing for testing, but it's not what we want in _development_ and _production_.

In this challenge you will set up your **Rack environment** variables to ensure a separation between your `test` and `development` environments.

## Learning Objectives covered

* Differentiate between `development`, `test`, and `production` environments

## To complete this challenge, you will need to

- [ ] Go to your application in the browser and create some links and confirm they are visible
- [ ] Run your tests and check that the links no longer appear on the page
- [ ] Create a database called `bookmark_manager_development`
- [ ] Configure your Sinatra app to run in `development` mode by default
- [ ] Set your environment to `test` when running specs by configuring your `spec_helper`
- [ ] Configure DataMapper to use the appropriate database for the environment (i.e. "bookmark_manager_development" when in the `development` mode)
- [ ] Check that data you create manually in the browser does not get removed when you run tests
- [ ] Discuss with your pair partner the key differences between test and development modes

## Resources

* [Sinatra Environments](https://blog.rainforestqa.com/2014-05-30-what-are-environments-for/)

## [Walkthrough](walkthroughs/13.md)
