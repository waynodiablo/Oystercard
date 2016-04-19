## Testing factories and services

[Back to the Challenge Map](00_challenge_map.md)

As a final step in replicating the original design spike, we're going to test
building a `ToDoFactory`.

You'll need to inject your factory into your unit test, the resource on injecting mocks should help you with this.

### Learning Objectives covered
- Testing factories
- Refactoring in Angular

### To complete this challenge, you will need to:

- [ ] Test-drive in Karma building a `ToDoFactory` with a `complete()` method - you'll
  need to add a `ToDoFactory` as you did in [Challenge
6](06_pushing_logic_into_models.md).
- [ ] Update your controller test so it uses this new `ToDoFactory` to create a `new ToDo("ToDo Name")` rather than using the syntax `{text: "ToDo1", complete: true}`. How can you mark the first `ToDo` that exists on initialisation as complete?
- [ ] Change your controller to make this new test pass
- [ ] Get your Protractor tests passing following this refactor

### Resources

- [Angular Docs: Injecting Mocks](https://docs.angularjs.org/api/ngMock/function/angular.mock.inject)
- [Angular Docs: Factory Recipe](https://docs.angularjs.org/guide/providers#factory-recipe)
- [Angular Style Guide: Factories](https://github.com/johnpapa/angular-styleguide/blob/master/a1/README.md#factories)

### [Walkthrough](walkthroughs/12_testing_factories.md)
