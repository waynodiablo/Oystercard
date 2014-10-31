# MVC

**MVC** stands for **model, view, controller** – the three key types of component that make up many web apps.

Rails is very *opinionated*, and expects you to develop your web apps using this MVC architectural pattern. So what are these three things, exactly?

## The components

### Models

Examples: *User*, *Comment*, *Review*

**Models** refer to the 'nouns' of your app – the things it deals with. Take a User model, for example: it tells your app what a user is. Your app needs to know that all users have a username and password, that the username must be unique, and so on – those details are stored in a *model*.

### Controllers

Examples: *Users*, *Comments*, *Reviews*

Hang on, aren't those examples the same as above? Not quite – note that they're plural here. The User model above defines *what a user is*, whereas the Users controller describes *what we can do to users* and *how they can be interacted with*.

In the case of Comments, we'll want to be able to create them, delete them, update them, view all of them as a list, view a single one of them in detail... Those methods are kept in a controller.

If we changed the way in which we interacted with Comments – say, we now want to get them using an API – we can just modify the controller to output JSON instead. We don't need to modify the model layer at all.

### Views




## The interactions



## Why?

