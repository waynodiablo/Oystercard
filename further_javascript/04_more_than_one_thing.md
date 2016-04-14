# More than One Thing

[Back to the Challenge Map](00_challenge_map.md)

Out application is now tracking state via a controller (and specifically, a `ViewModel`). But we want to display multiple things on the page!

In this challenge, you will store more than one item in the ViewModel, and iterate over it using *`ng-repeat`*. You will also use more complex Mustache syntax in the *Template* to interpolate results to the *View*.

### Learning Objectives covered
- Use iteration directives.
- Differentiate between Angular Views and Angular Templates.

### To complete this challenge, you will need to:

- [ ] Change the `todo` attribute of your `ToDoController` to use an array of strings instead of a single string. (Rename the attribute to `todos` to reflect this)
- [ ] Use the `ng-repeat` directive in your HTML to display all ToDos in the `ToDoController`.
- [ ] Instead of displaying simple strings, make each ToDo in `todos` a JavaScript object with two attributes: `text` (string) and `completed` (boolean).
- [ ] Use Mustache syntax to output your ToDos like this: 

```html
<p>ToDo1: completed</p>
<p>ToDo2: not completed</p>
```

### Resources

- [Official Angular website](https://angularjs.org/)

### [Walkthrough](walkthroughs/04_more_than_one_thing.md)
