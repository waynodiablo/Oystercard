# Setting up Jasmine

[Back to the Challenge Map](0_challenge_map.md)

To be able to TDD, we need a testing framework. The very awesome [Pivotal Labs](http://pivotal.io/labs) have built [Jasmine](https://github.com/Jasmine/jasmine) which conveniently has syntax that is extremely similar to RSpec.

In this challenge, you will install Jasmine, set up a new project and try to find common ground between RSpec and Jasmine.

### Learning Objectives covered
- Recall that Jasmine is a JavaScript testing framework
- Explain that Jasmine's test environment is the browser
- Use Jasmine to Test-Drive Development of a web page with JavaScript functionality
- Compare and contrast Jasmine and RSpec - syntax, test environment, and extensibility

### To complete this challenge, you will need to:

- [ ] Install Jasmine standalone (note - if you are following the README on the Jasmine page, stop before the step labelled "Add the following to your HTML file") in a new folder with an appropriate name for a JavaScript based FizzBuzz exercise, which is what we will build first. (If you're not sure what FizzBuzz is, the next challenge will explain the rules.)
- [ ] Inspect the files in the `src` and `spec` folders and discuss the similarities and differences to Ruby and RSpec with your pair partner
- [ ] Create empty `fizzBuzz.js` and `fizzBuzzSpec.js` files in appropriate locations.
- [ ] Use script tags to load these files in your `SpecRunner.html`.
- [ ] Open `SpecRunner.html` in Chrome.  You should see "No specs found".
- [ ] Look in the Console tab of the Chrome dev tools.  You should see no errors.
- [ ] Look in the Network tab of the Chrome dev tools to check your JavaScript files are being loaded.
- [ ] Delete the unused files in `src/` and `spec/` that came with the original Jasmine installation from `SpecRunner.html` and from your jasmine directory.

### Resources
- [Jasmine](https://github.com/jasmine/jasmine)
- [Jasmine documentation](http://jasmine.github.io/2.3/introduction.html)
- [A detailed breakdown of the &lt;script&gt; tag](http://www.sitepoint.com/a-detailed-breakdown-of-the-script-tag/)

### [Walkthrough](walkthroughs/2.md)
