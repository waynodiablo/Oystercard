# Introduction to Rails

You'll use Rails to build a clone of Yelp, an app for reviewing restaurants.

## Convention over configuration

Last week, you did tons of low-level stuff.  You had to do lots of work that would have been much quicker and easier with libraries.

This week, you'll use Rails. Rails is a web application framework that prioritises convention over configuration.  This means two things:

1. You don't tell Rails how your code is structured.  You structure your code in the way Rails thinks is best.
2. The API tries to be very consistent.  You can often guess how a Rails API will work, based on the way other Rails APIs work.

### Advantages and disadvantages

#### Advantages

* You have to write less code, because you don't need to tell Rails the things it has already assumed.
* Your code is automatically structured is a half-decent way.
* You can learn the Rails API quite quickly by following its patterns.

#### Disadvantages

* It's easy to do things the way Rails wants you to.  It can be quite hard when you need to leave the Rails.
* Rails has a lot of magic in the way it does things because of the higher level abstractions it gives you.  It can be hard to understand what's going on under the covers.

### Example 1

When you write tests with rspec,  you run `rspec`, it will run all the files whose names match the pattern `*_spec.rb`.  This convention means:

* You have to write less code because you don't need to bother telling rspec where your tests are.
* Your test files are structured more sensibly because their names clearly name them as "specs".

### Example 2

In rspec, the `.to be()` matcher has the same syntax as `.to eq()`.  This convention means that:

* If you learn `.to be()` first and then you hear about `eq`, you can make a guess about how you use it and you're more likely to be right.

## Learning objectives

### Goals for the week

Ask yourself the same two questions:

* Are you having fun?

* Are you a better developer than you were yesterday?

#### Primary goal

By the end of the week, the goal is to be able to answer "yes" to the week's primary question:

* **Can you use Rails and its conventions to build a web app?**

#### Secondary goal

To help you towards your primary goal, your secondary goal will be to produce a diagram of how all the parts of Rails interact.

* Draw the diagram on Tuesday.
* Each morning, update the diagram with your latest understanding.

Your diagram can include boxes for every directory and file inside a standard Rails app.

#### Detailed learning objectives

* [Learning Objectives](learning_objectives.md)

## This Week's Project: Yelp

Yelp is a popular web application that allows users to rate and review restaurants, and find other diner's ratings and comments. For the rest of the week you will be building a clone of this site using Rails.

There are two tracks:

1. Build the project in teams using the [specification](yelp_project_specification.md), without the walkthrough; or
2. Take the road oft travelled, and complete the project using the [walkthrough](yelp_project_specification.md).

Both tracks will take you to the same place, but Track 1 is entirely self-led.

## Code reviews

We'll have code reviews 9.45 to 10.15 on Tuesday, Wednesday, Thursday and Friday.  They will be for both tracks.

## Standups

* **Project track:** Organise standups in your teams.

* **Walkthrough track:** 9.30am in the bytes announced.

## MVP

Remember to focus on getting to an MVP ASAP.

## Use Rails 4

## Related Pills

* :pill: [MVC](../pills/mvc.md)
* :pill: [Rails console](../pills/rails_console.md)
* :pill: [Active Record](../pills/activerecord.md)

## Resources

* [Michael Hartl's Rails tutorial](http://www.railstutorial.org/book)
* [Getting Started with Rails](http://guides.rubyonrails.org/getting_started.html)
* [Structure of Rails apps (diagram)](http://images.thoughtbot.com/ember-rails-terminology-differences/rails.png)
* [Active Record basics](http://guides.rubyonrails.org/active_record_basics.html)
* [Associations](http://guides.rubyonrails.org/association_basics.html)
* [Validations](http://guides.rubyonrails.org/active_record_validations.html)
* [Layouts and Rendering](http://guides.rubyonrails.org/layouts_and_rendering.html)
* [Active Record Migrations](http://guides.rubyonrails.org/migrations.html)
