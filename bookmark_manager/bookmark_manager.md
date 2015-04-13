# Bookmark manager

This week's project is a bookmark manager. The goal is to expose you to the following aspects of web development:

* Relational databases
* Security considerations
* More Acceptance testing with Capybara

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
As a time pressed computer user
So that I can quickly find web sites I recently bookmarked
I would like to see a reverse chronological list of links on the site homepage
```


User Interface Sketch (Hi-Fi)
------

This is the basic view of the website. This tutorial will discuss how to build it, step by step. At the end of the section there are multiple exercises challenging you to extend the functionality of this website.

![](https://dchtm6r471mui.cloudfront.net/hackpad.com_jubMxdBrjni_p.52567_1380279073159_Screen%20Shot%202013-09-27%20at%2011.06.12.png "Bookmark Manager")

Note that every project you work on should start with user stories/features in the Stakeholder/Motivation/Action format, and a user interface experience sketch.  Usually that sketch will be Lo-Fi (Low Fidelity), rather than the Hi-Fi (High Fidelity) one that we show here.  In this case imagine that there was a quick Lo-Fi (pencil and paper) sketch that was done, agreed by the client, and was then mocked up in HTML and CSS only, or just using a graphics package like PhotoShop.  Now you have a Hi-Fi mockup and a few user stories you're ready to start!

***As usual please work on this project with a pair partner. Please take turns on the keyboard as the driver as described in the [pairing pill](pills/pairing.md) :pill:.***

## First Steps

As you'd do with every new project, create a new repository on Github.  Please name your project 'bookmark_manager'. Since we are going to use Sinatra go ahead and create an empty Sinatra application with a Gemfile and config.ru, and a Rakefile to run RuboCop and RSpec:

```rb
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

RuboCop::RakeTask.new :cop
RSpec::Core::RakeTask.new :spec

task default: [:cop, :spec]
```

Commit the changes, push them to Github and switch Driver/Navigator Roles&nbsp;:twisted_rightwards_arrows:

## Bookmark Manager Outline

* [Adding the database](bookmark_manager_stage_0.md)
* [Managing links and tags](bookmark_manager_stage_1.md)
* Adding user accounts
  * [Signing up](bookmark_manager_stage_2.md)
  * [Password confirmation](bookmark_manager_stage_3.md)
  * [Handling input errors](bookmark_manager_stage_4.md)
  * [Three levels of data checks](bookmark_manager_stage_5.md)
  * [Preventing duplicate registrations](bookmark_manager_stage_6.md)
  * [Rake tasks for database management](bookmark_manager_stage_7.md)
  * [Signing in and out](bookmark_manager_stage_8.md)
  * [Forgotten password](bookmark_manager_stage_9.md)
* [Styling the website](bookmark_manager_stage_style.md)

## Exercises

Once you have completed the walkthrough you should be able to do all of the following (in no particular order).

* Show the list of available tags on the homepage
* Move the form to add a link to its own route
* Add user_id to tags and links. Display who the link was submitted by. Same for a tag
* Allow the user to add a link to favourites (this will be a many-to-many relationship)
* Display how many users favourited the link
* Create a user profile page that will show the links they submitted, tags they created and their favourites.
* Display the link to the user's profile at the top of the page if the user is logged in
* Implement forgotten password functionality
* Redirect the user with a flash message if a logged in user tries to sign up or sign in
* Send a welcome email when the user signs up
* Create validations for all models:
* email must have the correct format (see an example in Datamapper Validations)
* email and password must be present
* link must have a title and a url
* tag must have some text
* Add a description property to the link.
* Add a username to the User model, so that username instead of an email was shown next to the link.

## Resources

* [Three Tier Web Database Architecture](https://docs.google.com/drawings/d/17ES4_vO90p3x3np1K3X5b5C_JVs14VbJZ5N8KraVRUw/edit)