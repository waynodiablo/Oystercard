# Bookmark Manager

This week's project is a bookmark manager. The goal is to expose you to the following aspects of web development:

* Relational databases
* Security considerations
* More feature testing with Capybara

In addition to the technologies mentioned above, this project is going to be more challenging on the front-end. You shouldn't need more than we've covered in the previous weeks but you should expect to spend more time on the front-end, compared to Battleships – web version. Of course, we'll also continue to be using the technologies we're familiar with: Sinatra, RSpec, etc.

***As usual note that there may be subtle errors in the following walkthrough.  Please try to approach those as challenges on which to polish your debugging skills - pull requests always welcome.***

We are going to build a bookmark manager, similar to pineapple.io or delicious.com in spirit. A bookmark manager is a good use case for exploring how relational databases work.

A bookmark manager is a website to maintain a collection of links, organised by tags. You can use it to save a webpage you found useful. You can add tags to the webpages you saved to find them later. You can browse links other users have added.

***As usual please work on this project with a pair partner. Please take turns on the keyboard as the driver as described in the [pairing pill](pills/pairing.md) :pill:.***

User Interface Sketch (Hi-Fi)
------

This is the basic view of the website. You will build it by working through the sequence of challenges. As we go on we will be challenging you to extend the functionality of this website.

![](https://dchtm6r471mui.cloudfront.net/hackpad.com_jubMxdBrjni_p.52567_1380279073159_Screen%20Shot%202013-09-27%20at%2011.06.12.png "Bookmark Manager")

## Challenges

 1. [Creating User stories](01_creating_user_stories.md)
 2. Viewing links
 3. ....


---------------

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

* [Three Tier Web Database Architecture :pill: ](pills/three_tier_architecture.md)
* [Three Tier Web Database Diagram](https://docs.google.com/drawings/d/17ES4_vO90p3x3np1K3X5b5C_JVs14VbJZ5N8KraVRUw/edit)
