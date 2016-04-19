## Testing services

[Back to the Challenge Map](00_challenge_map.md)

As a final step in replicating the original design spike, we're going to test
building a `ToDoService` which fetches a list of ToDos from an API.

We're not going to want to hit the actual API in our tests, so we're going to need to mock out our HTTP calls, both in our unit tests and our e2e/feature tests.

You'll also note that the way we spiked our `ToDoService` made it hard to unit-test, if you check for a return value it will be an empty array in a unit test, as the values come back from the HTTP request asynchronously. Rather than directly return our array, we're going to need to either use a callback (which is a perfectly valid solution), or return a promise as [suggested in this article](http://blog.ninja-squad.com/2015/05/28/angularjs-promises/).

This is a problem with spiking and not coding test-first in general - it makes it harder to see when we're building code that is hard to test. This is why you should always throw away anything you build with a spike and rebuild it test-first!

> If you're wondering why returning an empty array in your service worked in [Challenge 7](walkthroughs/07_connecting_to_an_api), it's because of Angular's two way data-binding. It actually was an empty array at first that you set to `this.todos` in your controller. But when the ToDos returned from the API and were pushed onto the `todos` array (ADD GITHUB LINK SLACK LEO IF HE FORGOT in the `_handleResponseFromApi` function inside of `ToDoService`), two way data-binding means Angular automatically updates the view so you see them on the page. It all happens so quickly you probably didn't notice it was happening asynchronously! This is the magic and the danger of Angular...

### Learning Objectives covered
- Testing services
- Mocking HTTP calls in unit tests/feature tests
- Injecting mock objects in JavaScript
- Working with promises

### To complete this challenge, you will need to:

- [ ] Test-drive in Karma building a `ToDoService` with a `getAll()` method which retrieves ToDos from http://quiet-beach-24792.herokuapp.com/todos.json - you'll
  need to use [`httpBackend`](https://docs.angularjs.org/api/ngMock/service/$httpBackend) to mock out the API calls that your service does.
- [ ] Update your controller test so that it saves to `self.todos` all of the ToDos return from `ToDoService.getAll()`. You'll need to use `$httpBackend` again
- [ ] Use [Protractor HTTP Mock](https://github.com/atecarlos/protractor-http-mock) to mock out HTTP calls in protractor (warning the documentation is not great for that repo!).

### Resources

- [Tips on Promises](http://blog.ninja-squad.com/2015/05/28/angularjs-promises/)
- [Angular Docs: Mocking HTTP calls using httpBackend](https://docs.angularjs.org/api/ngMock/service/$httpBackend)
- [Protractor HTTP Mock](https://github.com/atecarlos/protractor-http-mock)
- [Angular Docs: Services](https://docs.angularjs.org/guide/services)

### [Walkthrough](walkthroughs/13_testing_services.md)
