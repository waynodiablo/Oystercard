# Bookmark Manager

This week's project is a bookmark manager. The goal is to expose you to the following aspects of web development:

* Relational databases
* Security considerations
* More feature testing with Capybara

In addition to the technologies mentioned above, this project is going to be more challenging on the front-end. You shouldn't need more than we've covered in the previous weeks but you should expect to spend more time on the front-end, compared to Battleships – web version. Of course, we'll also continue to be using the technologies we're familiar with: Sinatra, RSpec, etc.

***As usual note that there may be subtle errors in the following walkthrough.  Please try to approach those as challenges on which to polish your debugging skills - pull requests always welcome.***

## High-level specification

We are going to build a bookmark manager, similar to pineapple.io or delicious.com in spirit. A bookmark manager is a good use case for exploring how relational databases work.

A bookmark manager is a website to maintain a collection of links, organised by tags. You can use it to save a webpage you found useful. You can add tags to the webpages you saved to find them later. You can browse links other users have added.

The website will have the following functionality:

* Show a list of links from the database
* Add new links
* Add tags to the links
* Filter links by a tag

###Exercise

* Write User stories/features in the Stakeholder/Motivation/Action format for each of the above capabilities, e.g.

```
As a time-pressed user
So that I can quickly go to web sites I regularly visit
I would like to see a list of links on the homepage
```
```
As a time-pressed user
So that I can quickly find web sites I recently bookmarked
I would like to see links in reverse chronological order
```

User Interface Sketch (Hi-Fi)
------

This is the basic view of the website. This tutorial will discuss how to build it, step by step. At the end of the section there are multiple exercises challenging you to extend the functionality of this website.

![](https://dchtm6r471mui.cloudfront.net/hackpad.com_jubMxdBrjni_p.52567_1380279073159_Screen%20Shot%202013-09-27%20at%2011.06.12.png "Bookmark Manager")

Now you have a mockup and a few user stories you're ready to start!

***As usual please work on this project with a pair partner. Please take turns on the keyboard as the driver as described in the [pairing pill](pills/pairing.md) :pill:.***

## First Steps

As you'd do with every new project, create a new repository on Github.  

* Name your project 'bookmark_manager'.
* From your project directory, run `bundle init` to generate a Gemfile.
* In the Gemfile:
  - specify the version of Ruby that you wish to use.
  - make a test group and add `gem 'rspec'` and `gem 'capybara'`
* Run `bundle`.
* Add `require 'capybara/rspec'` to your spec_helper.rb (use `rspec --init` if you're not comfortable creating your own spec_helper).

Commit the changes, push them to Github and switch Driver/Navigator Roles&nbsp;:twisted_rightwards_arrows:

## Bookmark Manager Outline

* [Viewing and creating links](bookmark_manager_stage_0.md)
* [Tagging links](bookmark_manager_stage_1.md)
* Adding user accounts
  * [Signing up](bookmark_manager_stage_2.md)
  * [Password confirmation](bookmark_manager_stage_3.md)
  * [Sanitizing user inputs](bookmark_manager_stage_4.md)
  * [Validation](bookmark_manager_stage_5.md)
  * [Preventing duplicate registrations](bookmark_manager_stage_6.md)
  * [Signing in and out](bookmark_manager_stage_7.md)
  * [Password recovery](bookmark_manager_stage_8.md)
* [Styling the website](bookmark_manager_stage_style.md)

[First stage](bookmark_manager_stage_0.md)

## Resources

* [Three Tier Web Database Architecture :pill: ](../pills/three_tier_architecture.md)
* [Three Tier Web Database Diagram](https://docs.google.com/drawings/d/17ES4_vO90p3x3np1K3X5b5C_JVs14VbJZ5N8KraVRUw/edit)
