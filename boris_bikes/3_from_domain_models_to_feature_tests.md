# From a Domain Model to a Feature Test

[Back to the Challenge Map](0_challenge_map.md)

A **Domain Model** is an abstract representation of the Objects within a system, and the Messages they use to communicate with one another. Once you have a Domain Model for a feature, you need to think about how your Objects and Messages will work together in code. This is called a **Feature Test**.

In this challenge, you will Feature Test a feature, using the Domain Model you just made.

### Learning Objectives covered
- Define 'Feature Test'
- Define a 'stack trace'
- Use `irb` to run a 'feature test'

### Challenge setup

Here is the User Story you converted into a Domain Model:

```
As a person,
So that I can use a bike,
I'd like a docking station to release a bike.

As a person,
So that I can use a good bike,
I'd like to see if a bike is working
```

Here is a functional representation of that story:

Objects  | Messages
------------- | -------------
Person  |
Bike  | working?
DockingStation | release_bike

### To complete this challenge, you will need to:

- [ ] Start `irb` (or any other REPL) from the Command Line
- [ ] Set a variable `docking_station` equal to a new `DockingStation` object
- [ ] Explain to your pair partner what the resulting error means.

### Hints

<details><summary>CLICK ME</summary>
  <li>Don't panic when you see the error message!  Error messages are a good thing and can be super helpful as long as you engage with them properly.</li>
  <li>Read the error message line by line with your partner to see what information you can gain from it.</li>
</details>

### Resources

- [Ruby Variables](https://github.com/makersacademy/course/blob/master/pills/variables.md):pill:
- [IRB](http://ruby-doc.org/stdlib-2.0.0/libdoc/irb/rdoc/IRB.html)
- [What's a Domain Model?](http://sjmog.github.io/posts/502_domain-modelling/)
- [Feature Testing in IRB (video)](https://www.youtube.com/watch?v=rShBRLyEccY)

### [Walkthrough](walkthroughs/3.md)


![Tracking pixel](https://githubanalytics.herokuapp.com/course/boris_bikes/3_from_domain_models_to_feature_tests.md)
