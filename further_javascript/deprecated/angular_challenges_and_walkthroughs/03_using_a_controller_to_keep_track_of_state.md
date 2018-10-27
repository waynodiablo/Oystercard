# Using a Controller to keep track of State

[Back to the Challenge Map](00_challenge_map.md)

You now have a static website hooked up to an Angular application via a root module. At the moment, your website can only store _one thing_: whatever string is typed into the input.

This isn't much use: we want to store multiple things in our application, and to display multiple things on a page. To do that, we need something that can track the **state** of the application (much like we need `@instance_variables` to store the **state** of a Ruby object).

In this challenge, you will set up an **Angular Controller** and use it to keep track of the **state** of your application.

> State tracked by a Controller is often referred to as a **ViewModel**.

### Learning Objectives covered
- Use an Angular controller to keep track of a ViewModel.
- Use Mustache syntax to interpolate JavaScript.

### To complete this challenge, you will need to:

- [ ] Create a file, `controllers.js`, that will store your Angular Controllers.
- [ ] Build an Angular Controller, `ToDoController`, inside `controllers.js`.
- [ ] Add an attribute to your `ToDoController` called `todo`.
- [ ] Set this attribute equal to a string `"ToDo1"`.
- [ ] Bind your `ToDoController` to your HTML inside `index.html` using `ng-controller`. Remember to include the `controllers.js` script in your HTML first.
- [ ] Use *Mustache syntax* to display the `todo` attribute of the `ToDoController` inside your HTML.

### Resources

- [Official Angular website](https://angularjs.org/)

### [Walkthrough](walkthroughs/03_using_a_controller_to_keep_track_of_state.md)


![Tracking pixel](https://githubanalytics.herokuapp.com/course/further_javascript/deprecated/angular_challenges_and_walkthroughs/03_using_a_controller_to_keep_track_of_state.md)
