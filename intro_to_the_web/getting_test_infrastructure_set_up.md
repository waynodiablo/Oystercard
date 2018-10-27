# Getting test infrastructure set up

[Back to the Challenge Map](README.md)

We have a basic project structure. Let's get our testing infrastructure glued together.

### Learning Objectives covered

- Getting test infrastructure set up
- Write a feature test using Capybara
- Pass a feature test using Capybara

### To complete this challenge, you will need to:

- [ ] Add a dependency for `capybara` to your Gemfile, and install using `bundle`.
- [ ] In your `spec/spec_helper.rb` file
  - [ ] Set your RACK_ENV to `test`.
  - [ ] Require your Sinatra app file, `capybara`, `capybara/rspec` and `rspec`.
  - [ ] Tell Capybara about your app class using `Capybara.app`.
- [ ] In `spec/features`, write a feature test that checks that the hompage says `Testing infrastructure working!`.
- [ ] Run `rspec` and check that your feature test fails with with `1 example, 1 failure`.
- [ ] Update your app so that the homepage displays `Testing infrastructure working!`.
- [ ] Run `rspec` and check that your feature test passes.

### Resources

- [Capybara README](https://github.com/teamcapybara/capybara/blob/master/README.md)
- [Capybara Cheat Sheet](https://www.launchacademy.com/codecabulary/learn-test-driven-development/rspec/capybara-cheat-sheet)

### [Walkthrough](walkthroughs/getting_test_infrastructure_set_up.md)


![Tracking pixel](https://githubanalytics.herokuapp.com/course/intro_to_the_web/getting_test_infrastructure_set_up.md)
