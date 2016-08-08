# Connecting to an API

[Back to the Challenge Map](00_challenge_map.md)

Remember how there are two kinds of services? We've just used a _Factory_ to construct models. Now it's time to use a **Service** to connect to an API.

In this challenge, you will import ToDos from an API via a **Service**.

### Learning Objectives covered
- Use Services to connect to external services.

### To complete this challenge, you will need to:

- [ ] Construct an Angular Service that has one public method, `getAll()`.
- [ ] Within the `getAll()` method, retrieve all ToDos from an API located at http://quiet-beach-24792.herokuapp.com/ . Think about the precise path for todos: it follows RESTful conventions.
- [ ] Refactor your controller such that when the application loads, it populates the contents of `this.todos` with `ToDoFactory` instances created from information in the API.

### Resources

- [Angular Docs: Service Recipe](https://docs.angularjs.org/guide/providers#service-recipe)

### [Walkthrough](walkthroughs/07_connecting_to_an_api.md)
