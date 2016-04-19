## Testing services

[Back to the Challenge Map](00_challenge_map.md)

As a final step in replicating the original design spike, we're going to test
building a `ToDoService` which fetches a list of ToDos from an API.

We're not going to want to hit the actual API in our tests, so we're going to need to mock out our HTTP calls, both in our unit tests and our e2e/feature tests.

### Learning Objectives covered
- Testing services
- Mocking HTTP calls in unit tests/feature tests

### To complete this challenge, you will need to:

- [ ] Test-drive in Karma building a `ToDoService` with a `getAll()` method which retrieves ToDos from https://quiet-beach-24792.herokuapp.com/todos.json - you'll
  need to use [`httpBackend`](https://docs.angularjs.org/api/ngMock/service/$httpBackend) to mock out the API calls that your service does.
<!-- - [ ] Update your controller test so it uses this new `ToDoFactory` to create a `new ToDo("ToDo Name")` rather than using the syntax `{text: "ToDo1", complete: true}`. How can you mark the first `ToDo` that exists on initialisation as complete?
- [ ] Change your controller to make this new test pass
- [ ] Get your Protractor tests passing following this refactor -->

### Resources

  - [Angular Docs: Mocking HTTP calls using httpBackend](https://docs.angularjs.org/api/ngMock/service/$httpBackend)
- [Angular Docs: Services](https://docs.angularjs.org/guide/services)

### [Walkthrough](walkthroughs/13_testing_services.md)
