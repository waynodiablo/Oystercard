You did a pretty difficult job when you moved from using doubles to represent a station to using actual station objects. However, this will really help us to close the next few issues.

So far we have assumed that our users behave well: they touch in on every station and touch out on every station. However, in real life it's not like this. Sometimes people forget to touch in or touch out. Our code should expect this to happen. This is called an edge case: an unlikely but possible situation.

Discuss with your pairing partner what will happen to your journey history right now if a person forgets to touch in or touch out. What will be stored in your journey history?

Right now we are referencing Journey throughout our code. We are talking about journey repeatedly - we are adding journeys, completing journeys and knowing if a journey is incomplete. It is becoming clear that a journey object would be useful. A Journey class is screaming to get out!

Let's create a new Journey class, it should be responsible for starting a journey, ending a journey, calculating the fare of a journey, and returning whether or not the journey is complete.

## Learning Objectives covered
- Use the Extract Class refactoring pattern

## Interview questions you may expect:
- What is an edge case in software engineering? How do you validate code behaviour when an edge case is encountered?
- What is refactoring? When do you refactor code?
- What is the red/green/refactor cycle? Give me an example of using it.
- Explain when you would use Extract Class refactoring pattern and how you would do it.

## To complete this challenge:
- [ ] Write up a plan for how you will interact with your code and manually test in IRB.
- [ ] Update your test suite to reflect a new Journey class
- [ ] Create a new class Journey and move the functionality that relates to a journey from Oystercard to Journey
- [ ] Make sure all tests pass, all existing functionality is preserved
- [ ] The `#fare` method should return the minimum fare (for the moment), or the penalty fare of 6 if there was either no `entry_station` or no `exit_station`.
- [ ] Make sure the entire codebase is DRY
- [ ] Make sure all methods are three lines or shorter

## Suggested resources:
- [Edge case](https://en.wikipedia.org/wiki/Edge_case)
- [Test all possible cases on Better Specs](http://betterspecs.org/#all)
- [Extract Class on SourceMaking](https://sourcemaking.com/refactoring/extract-class)
- [Single Responsibility Principle](http://jjbohn.info/blog/2014/07/28/single-responsibility-principle-a-solid-week/)
- [Extract Class on Scrutinizer](https://scrutinizer-ci.com/docs/refactorings/extract-class)
- [DRY: Don't Repeat Yourself](https://en.wikipedia.org/wiki/Don%27t_repeat_yourself)
- [SOLID principles](https://en.wikipedia.org/wiki/SOLID_(object-oriented_design))

## [Solution](solutions/14_no_touch_in_or_out.md)
