# MVC

> **Read through the below slowly. It'll take a couple of goes before you really get it.**

**MVC** stands for **model, view, controller** – the three key types of component that make up many web apps.

Rails is very *opinionated*, and expects you to develop your web apps using this MVC architectural pattern. So what are these three things, exactly?

## The components

### Models

Examples: *User*, *Comment*, *Review*

**Models** refer to the 'nouns' of your app – the things it deals with. Take a User model, for example: it tells your app what a user is. Your app needs to know that all users have a username and password, that the username must be unique, and so on – those details are stored in a *model*.

### Controllers

Examples: *Users*, *Comments*, *Reviews*

Hang on, aren't those examples the same as above? Not quite – note that they're plural here. The User model above defines *what a user is*, whereas the Users controller describes *what we can do to users* and *how they can be interacted with*.

**Controllers** contain the 'verbs' of your app which act on models.

In the case of Comments, we'll want to be able to create them, delete them, update them, view all of them as a list, view a single one of them in detail... Those methods are kept in a controller.

If we changed the way in which we interacted with Comments – say, we now want to get them using an API – we can just modify the controller to output JSON instead. We don't need to modify the model layer at all.

### Views

Examples: *root*, *restaurants#index*, *comments/all*

**Views** are used to actually show your users something. That might be a particular Restaurant, or a User's profile page, of all of the Comments on a site.

In Rails, your views are a mix of HTML and Ruby (hence the odd `.html.erb` file extension) – which makes sense, because you want those views to render something on a user's web browser.

In Rails, there are a couple more layers involved in the view, like the routes (which you can see when you run `rake routes`) and the web server.

## The interactions

Typically, the view talks to the controller, and the controller to the model.

For example:

**A user goes to `/restaurants/index`**

* your web server receives the request
* it looks up the corresponding controller – `restaurants_controller.rb`
* inside the controller it looks for the `index` method
* that method refers to pulling in `Restaurant.all`
* your `restaurant.rb` model is consulted – which triggers a database lookup to get those records and hand them back to the controller
* the controller hands the records to the view, which renders them
* the list of restaurants is displayed to the user.

## Why?

Separation of concerns.

Keeping your model, view and controller code isolated ensures that you can change one part without affecting the rest - like in the example above of switching out a view for a JSON API. Or if you wanted to change the way the information was presented to a user – just edit the view. 

That separation keeps your code clean, makes it semantic and easy to understand, and makes it *break less*.

