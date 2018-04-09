# Killing the Global Variable

Remember the learning objective in [the extracting logic to the model challenge](extracting_logic_to_the_model.md)?

- [ ] Commit to memory the fact that using a global variable will ruin any tech tests you do, and promise to your pair partner that you never will.

Let's look at removing the global variable `$game` from our code altogether.

### Learning Objectives covered
- Define the scope of a class instance variable
- Describe the singleton pattern
- Use Sinatra filters to DRY out route handlers
- Destroy global variables

### To complete this challenge, you will need to:

- [ ] Discuss the problem that the global variable(s) solved.
- [ ] Investigate and discuss why global variables are evil.
- [ ] Implement a *class method* on `Game` using a *class instance variable* to store an instance of `Game`.
- [ ] Investigate the difference between a *class _instance_ variable* and a *class variable*.  In general we avoid _class variables_ - why?
- [ ] Investigate the Singleton pattern and compare it to this approach.  What are the similarities/ differences?
- [ ] Investigate Sinatra filters.
- [ ] Implement a Sinatra filter to DRY out your route handlers.

### Resources

- [Class Variables and Methods](http://rubymonk.com/learning/books/4-ruby-primer-ascent/chapters/45-more-classes/lessons/113-class-variables)
- [Singleton Pattern](https://en.wikipedia.org/wiki/Singleton_pattern)
- [Sinatra Filters](http://www.sinatrarb.com/intro.html#Filters)

### [Walkthrough](walkthroughs/killing_the_global_variable.md)
