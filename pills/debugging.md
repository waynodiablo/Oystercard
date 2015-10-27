#Debugging

>It is a capital mistake to theorise before one has data. Insensibly one begins to twist facts to suit theories, instead of theories to suit facts.

— *A Scandal in Bohemia, 1892*

## Steps for debugging

Debugging follows a process identical to the **scientific method** (or Sherlock Holmes' process for solving crimes!). If you follow the steps below you should be able to fix your problems far quicker than if you go about debuggin in a haphazard way.

And remember, 

  1. Hypothesis -  read the exception messages properly!
  2. Analysis - think what the program is doing, rather than what it isn't doing. What do you want it to do?
  3. Experimentation - see below
  4. Conclusion

 - If you get stuck, **take a break**, switch your mind off, then start from the beginning again.
 - It's often a case that what you think is wrong isn't the actual problem, so always **check your assumptions** as any good scientist would do!
 - Always **think like the interpreter**. It's very rational.
 - The problem is likely to be in your variables so you need to **dissect them**.

## Dissection tools

Remember the choice of your tool is personal and changes from person to person but if **you're not using any of these tools you're going to find debugging incredibly difficult**!

### Ruby

   * Print statements - remember if you do this in the controller it will only show up in the server output
   * Raise exceptions
   * Rails logger - `tail -f log/development.log` shows the log
   * Pry debugger - add `pry-rails` to your Gemfile, then use `binding.pry` to break the code, `exit` to continue
   * [Byebug](https://github.com/deivid-rodriguez/byebug/blob/master/GUIDE.md) is another useful debugging tool
   * Rails console/irb
   * Git log/diff - what's changed since the bug was introduced?

In Ruby these are mostly summed up in [this article from the Rails docs](http://guides.rubyonrails.org/debugging_rails_applications.html) which is highly recommended going over when you have the time. And, since Rails 4.2, Rails has included the [Web Console gem](https://github.com/rails/web-console) by default. This means you get a debugging console on every error page - handy for checking those errant instance variables!

### JavaScript

   * `console.log` prints your value into the console
   * You can use the [built-in debugger in Chrome](https://developer.chrome.com/extensions/tut_debugging)

Some further reading:

   * [Zen of debugging](http://webadvent.org/2012/debugging-zen-by-ben-ramsey)
   * [The psychology of debugging](https://docs.google.com/file/d/13hFUiT8lD1FiaRkwrM5AOdbT2xSVZF8eg0JXdcqU4mZSAzXkwonp1M-TFqR8/edit)
   * [Debugging Railscasts](http://railscasts.com/?tag_id=10) - some of these are subscription only
