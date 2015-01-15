# Taking Your Coding Further

Once you have [cleaned up your GitHub](https://github.com/makersacademy/post_course/blob/master/Clean%20your%20Github.md) it's likely that you are going to want to take your coding skills even further while you are looking for your first job.

## What Can I Do?

The first thing to be aware of is that in terms of the *product* you're building, it really **doesn't matter**. What you are looking to do here is not solve some important problem or build some great looking app, but to show off what you know about coding, exemplify good coding practices, and **stretch yourself** so that you keep on learning new things - so you'll want to do more than just a simple CRUD app.

Below are some things you want to be doing that employers absolutely love to see (and will prove how much you're learning as a coder).

> You'll notice that a lot of this is repeated from [cleaning up your GitHub](https://github.com/makersacademy/post_course/blob/master/Clean%20your%20Github.md). That's because this stuff is so important it bears repeating. Remember, it is the process of grasping and demonstrating these concepts that will be what leads you to getting your first coding job.

### [TDD](http://en.wikipedia.org/wiki/Test-driven_development)/[BDD](http://en.wikipedia.org/wiki/Behavior-driven_development) from outside-in

This is the absolute bread-and-butter of what makes a good coder and good code, and its importance just can't be over-stated. Basically, **if you're not test-driving your app, you're wasting your time**. We deliberately only look for hiring partners that believe in TDD, and similarly they are looking to see the same from you. 

Show how passionate about testing you've become: try out a new testing library, if you haven't done much BDD with [Cucumber](http://cukes.info/) try building a complete application using BDD, or have a go doing [BDD with JavaScript](http://eamodeorubio.github.io/bdd-with-js/#/). If you want to do more RSpec, maybe look at some more advanced RSpec commands like [verifying doubles](https://relishapp.com/rspec/rspec-mocks/docs/verifying-doubles) or a testing library like [Shoulda](https://github.com/thoughtbot/shoulda) or [Factory Girl](https://github.com/thoughtbot/factory_girl), and if you are doing any JavaScript you need to be test driving that too (yes, the JavaScript community can be pretty lax about doing this, but it doesn't mean you should be).

And think how about how your tests can be improved: are they [DRY](http://en.wikipedia.org/wiki/Don't_repeat_yourself)? Are they indicating code-smells in your underlying code? Do they read well when you run them in documentation format, so that someone could come in and just by reading this understand what your app does? Do they follow best practices, like those recommended in something like [better specs](http://betterspecs.org/)?

### Well-written OOP

OOP is almost as fundamental as TDD, and you should make sure you are always building unit-tested [SOLID](http://en.wikipedia.org/wiki/SOLID_(object-oriented_design)) objects that do just one thing, and one thing well (remember that if they get too big, that's probably a sign they need to be broken out into smaller objects).

As well, don't forget that your objects should be encapsulating inside themselves all the internal logic that relates to an object. This means that rather than doing something like:

```ruby
user = User.find('dave')
user.credit += 5
user.status = :in_credit
user.save!
```

you should **encapsulate** all of that logic inside of the user object where it belongs:

```ruby
user = User.find('dave')
user.add_credit!(5)
```

### Well-implemented MVC Architecture

Don't forget that just because you're writing some code inside an MVC framework like Rails, you're still doing OOP. So you could easily do something like in the previous code example to make your controllers slimmer by encapsulating all logic such as this inside of your models - writing a unit test first of course!

In fact, we should always be coding MVC like this - there should be minimal logic in our views and our controllers. Move logic into models or even other objects in your **lib** folders (or, in Node, extract them into modules). An advanced example of doing this is using [Service Objects](https://netguru.co/blog/service-objects-in-rails-will-help).

Also, if building in something like Rails, see if you can do more than just tie Gems together. Write some of your own libraries, or do some complex stuff in the models - as a general rule, the more unit tests you're writing the more interesting your code will be.

### Well-written code

Of course, throughout, you will want your code quality to remain high. Here's a recap of some things you should be doing:

* Follow a [Ruby](https://github.com/styleguide/ruby) or [Javascript](https://github.com/airbnb/javascript) style guide
* Indent consistently and remove trailing white-spaces
* Keep methods as small as possible
* Write your code for [humans not machines](http://programmer.97things.oreilly.com/wiki/index.php/Write_Code_for_Humans_not_Machines)

## But What Shall I Build?

Now keeping all of these best-practices in mind, you'll need to think of *something* to build. Below are some ideas: remember it is down to you whether you build this as a single page web-app, a command line app, entirely in Rails, as a Node module or whatever excites you. Just make sure you're following the guidelines above and you're **test driving** everything. If you're struggling to test-drive it, switch to a language/framework which makes it easier.

### Ideas

* Code a simplified version of your favourite board game
* Find an API that interests you (there's a [directory](http://www.programmableweb.com/apis/directory)) here, and try building a mash-up that consumes it - although remember you'll need to work out a way ideally of mocking calls to the API in your tests and to encapsulate the code that goes to the API inside an object
* Take a [design pattern](http://en.wikipedia.org/wiki/Software_design_pattern) and try and add it to an existing project - or if you're not sure where to start try adding the [Presenter pattern to improve your views in Rails](https://www.new-bamboo.co.uk/blog/2013/04/17/rails-presenters-skinny-everything/)
* Create a solver for some sort of puzzle e.g. sudoku, crosswords, tic-tac-toe (think of more original ones than these!)
* Go back to your Maker's jamboree and try an idea that never got used

If you're still really stuck ask a coach or your fellow alumni, and let us know when you're done so we can review how you got on!
