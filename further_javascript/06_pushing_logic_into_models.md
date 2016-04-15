# Pushing Logic into Models

[Back to the Challenge Map](00_challenge_map.md)

We have built an application that can add and remove custom ToDos. However, our Controller is doing a lot of the legwork re: construction of those ToDos. Let's refactor some of the 'heavy lifting' in to the Model layer.

At current, our models are just object literals (constructed on-the-fly using `{}`):

```javascript
self.todos = [{ text: "ToDo1", completed: true }, { text: "ToDo2", completed: false }];
```

In this challenge, we will upgrade our object literals to more functional objects that can take more of the 'heavy lifting' of construction our of the Controller. In general programming, an object that handles the 'heavy lifting' of construction is called a **Factory**.

### Challenge Setup

Angular refers to parts of the application that do 'heavy lifting' as **services**. Confusingly, there are two main kinds of service:

- **Factories** for building models, and
- **Services** (confusing naming!) for doing other things, such as connecting to APIs.

Both Factories and Services are kinds of Angular service. Here, we're using a Factory. Next challenge, we'll use a Service. You'll learn more about the difference between them by using both.

### Learning Objectives covered
- Use Factories to construct Models.
- Refactor Controller logic into Factories.

### To complete this challenge, you will need to:

- [ ] Construct an Angular Factory that builds `Todo` models, `ToDoFactory`.
- [ ] Require this Factory as a dependency in your `ToDoController`.
- [ ] Refactor the `addToDo()` expression to use the `ToDoFactory` instead of constructing an object literal.
- [ ] Add a `complete()` method to your new `Todo` model, and 'wire it up' to the Template so you can complete ToDos.

### Resources

- [Angular Docs: Factory Reciple](https://docs.angularjs.org/guide/providers#factory-recipe)

### [Walkthrough](walkthroughs/06_pushing_login_into_models.md)
