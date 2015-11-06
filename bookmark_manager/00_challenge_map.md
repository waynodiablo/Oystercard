# Bookmark Manager

This week's project is a bookmark manager. The goal is to expose you to the following aspects of web development:

* Relational databases
* Security considerations
* More feature testing with Capybara

In addition to the technologies mentioned above, this project is going to be more challenging on the front-end. You shouldn't need more than we've covered in the previous weeks but you should expect to spend more time on the front-end, compared to last week. Of course, we'll also continue to be using the technologies we're familiar with: Sinatra, RSpec, etc.

***As usual note that there may be subtle errors in the following walkthrough.  Please try to approach those as challenges on which to polish your debugging skills - pull requests always welcome.***

We are going to build a bookmark manager, similar to pineapple.io or delicious.com in spirit. A bookmark manager is a good use case for exploring how relational databases work.

A bookmark manager is a website to maintain a collection of links, organised by tags. You can use it to save a webpage you found useful. You can add tags to the webpages you saved to find them later. You can browse links other users have added.

***As usual please work on this project with a pair partner. Please take turns on the keyboard as the driver as described in the [pairing pill](/pills/pairing.md) :pill:.***

User Interface Sketch (Hi-Fi)
------

This is the basic view of the website. You will build it by working through the sequence of challenges. As we go on we will be challenging you to extend the functionality of this website.

![](https://dchtm6r471mui.cloudfront.net/hackpad.com_jubMxdBrjni_p.52567_1380279073159_Screen%20Shot%202013-09-27%20at%2011.06.12.png "Bookmark Manager")

## Challenges

 1. [Creating User stories](01_creating_user_stories.md)
 2. [Understanding Databases](02_understanding_databases.md)
 3. [Setting up a Database](03_setting_up_a_database.md)
 4. [Creating Your First Table](04_creating_your_first_table.md)
 5. [Manipulating Table Data](05_manipulating_table_data.md)
 6. [Using DataMapper](06_using_data_mapper.md)
 7. [Research CRUD](07_research_crud.md)
 8. [Viewing Links](08_viewing_links.md)
 9. [Creating a Link Model](09_creating_a_link_model.md)
 10. [Creating a Modular Sinatra App](10_creating_a_modular_sinatra_app.md)
 11. [Creating Links](11_creating_links.md)
 12. [Configuring DatabaseCleaner](12_configuring_database_cleaner.md)
 13. [Configuring the Rack Env](13_configuring_the_rack_env.md)
 14. [Deploying to Heroku](14_deploying_to_heroku.md)
 15. [Tagging Links](15_tagging_links.md)
 16. [Filtering Tags](16_filtering_tags.md)
 17. [Multiple Tags](17_multiple_tags.md)
 18. [Adding User Accounts](18_adding_user_accounts.md)
 19. [Password confirmation](19_password_confirmation.md)
 20. [Improving Sign Up Workflow](20_improving_sign_up_workflow.md)
 21. [Levels of Validation](21_levels_of_validation.md)
 22. [Preventing Duplicate Registrations](22_preventing_duplicate_registrations.md)
 23. [Signing in](23_signing_in.md)
 24. [Signing Out](24_signing_out.md)
 25. [Refactoring](25_refactoring.md)
 26. [Password Recovery](26_password_recovery.md)
 27. [Mailing the Token](27_mailing_the_token.md)



---------------

## Old Bookmark Manager Outline (Reference Only)

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

* [Three Tier Web Database Architecture :pill: ](/pills/three_tier_architecture.md)
* [Three Tier Web Database Diagram](https://docs.google.com/drawings/d/17ES4_vO90p3x3np1K3X5b5C_JVs14VbJZ5N8KraVRUw/edit)
