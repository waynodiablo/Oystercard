# Controller Expressions

[Back to the Challenge Map](00_challenge_map.md)

We have built a controller module that holds several objects in state. Let's see how we can manipulate the state to add or remove ToDos.

In this challenge, you will write a **controller expression** bound to a button in your template using the **`ng-click`** directive. You will use this action to update the ViewModel. Finally, you will use the **`ng-model`** directive to create a temporary ViewModel.

### Learning Objectives covered
- Write controller expressions.
- Bind controller expressions to templates using `ng-click`.

### To complete this challenge, you will need to:

- [ ] Add a new method to the controller module (a 'controller expression'), `addToDo()`. When called, should add a new ToDo object to `todos`.
- [ ] Add a button to your template that uses the `ng-click` directive to call this controller expression.
- [ ] Use the `ng-model` directive attached to an `input` tag to add ToDos with custom text. You will need to update your `addToDo` method.
- [ ] Implement a way to remove ToDos.

### Resources

- [Angular Docs: Controller](https://docs.angularjs.org/guide/controller)

### [Walkthrough](walkthroughs/05_controller_expressions.md)


![Tracking pixel](https://githubanalytics.herokuapp.com/course/further_javascript/deprecated/angular_challenges_and_walkthroughs/05_controller_expressions.md)
