# Angular Week: Getting to grips with Angular

These are the basic nuts and bolts of Angular. Make sure you can answer these questions relatively well before you start the Project later this week. **Actually ask them to your pair: repetition and drilling is encouraged.**

Targeted resources are provided for most questions: we think these are the best way to answer them, but if you find better ones then follow your learning nose. **The best way to figure out the answers, as always, is by playing with the code you're building.** If we haven't provided resources, it's because the answer is clear from the tutorial.

Each question topic is targeted to a section of the [Phonecat tutorial](https://docs.angularjs.org/tutorial) **(given in parentheses)**. Don't spend too long diving in to any one question - you're getting an overview here!

### 1. MV* JavaScript (Before starting)
- Why would you want a JavaScript framework?
- Angular is often called an 'Model-View-Whatever' framework. What is that?

##### Resources

- [:pill: Pill: Angular Structure](https://github.com/makersacademy/course/blob/master/pills/angular_structure.md)
- [Stack Overflow Post: AngularJS Design](http://stackoverflow.com/questions/20286917/angularjs-understanding-design-pattern)
- [Angular Blog: MVWhatever](https://plus.google.com/+AngularJS/posts/aZNVhj355G2)

### 2. Single Page Applications (Before starting)
- What is a 'Single Page Application'?
- Why did a website like [Soundcloud](https://soundcloud.com) switch to being an SPA?

### 3. Installing and running `node`, `npm`, `package.json` ([Tutorial](https://docs.angularjs.org/tutorial))

_Avoid going down the Node rabbithole. This week is for learning Frontend stuff; you'll have a chance to spend more time with Node later. Right now, we use it for running JavaScript tasks from the command line: nothing else._

- In one sentence, what is Node?
- Is it fair to describe NPM as being "like Bundler and RubyGems thrown together"?
- How is a `package.json` similar to a Gemfile? How is it different?

##### Resources
- [`package.json` interactive browser](http://browsenpm.org/package.json)

### 4. Bower (vs. NPM) ([Tutorial](https://docs.angularjs.org/tutorial))
- What is Bower for?
- How is it different to NPM?

##### Resources
- [Video: Introduction to Bower](https://egghead.io/lessons/bower-introduction-and-setup)

### 5. Setting up Angular tests ([Tutorial](https://docs.angularjs.org/tutorial))
- How do you feature (end to end) test Angular?
- How do you unit test Angular?
- How do you run feature and unit tests?

### 6. Directory/Conceptual structure of Angular ([0](https://docs.angularjs.org/tutorial/step_00))
- What does `app.js` do?
- What does `controller.js` do?
- What do people do all day?
- What does `services.js` do? (Hint: see lines 9 - 10. What do you think they do?)

##### Resources
- [Book: What do People do All Day?](http://www.amazon.co.uk/What-Do-People-All-Day/dp/0007353693)

### 7. Templates/Mustache ([1](https://docs.angularjs.org/tutorial/step_01))
- What is an Angular Template?
- What is the difference between Views and Templates in Angular?
- How is Mustache used in Angular templates?

### 8. Controllers and `$scope` ([2](https://docs.angularjs.org/tutorial/step_02))
- What is an Angular controller?
- What is meant by `$scope` of an Angular controller? How does it relate to the concept of 'scope' you've already met?
- What is happening when you inject `$scope` into an Angular controller?

##### Resources
- [Blog: Introduction to Angular scopes](http://blog.carbonfive.com/2014/02/11/angularjs-scopes-an-introduction/)
- [Extension reading: 'controller as' syntax and scope](https://thinkster.io/egghead/experimental-controller-as-syntax)

### 9. Directives ([2](https://docs.angularjs.org/tutorial/step_02))
- What are some examples of Angular directives?
- What are they for?
- How is binding to events (such as 'click') different in Angular to jQuery?

##### Resources
- [Blog: jQuery event handling vs. Angular event handling](https://daveceddia.com/angular/handle-dom-events-the-angular-way-without-jquery/)

### 10. Expressions ([2](https://docs.angularjs.org/tutorial/step_02))
- How do expressions link together Angular Controllers and Views?

### 11. Injecting controllers in tests ([2](https://docs.angularjs.org/tutorial/step_02))
- How do you inject a controller into a Unit test?
- Why would you want to?

##### Resources

- [He cares, he shares, he's Nathan Le Claire](http://nathanleclaire.com/blog/2013/12/13/how-to-unit-test-controllers-in-angularjs-without-setting-your-hair-on-fire/)

### 12. Unit Testing with Karma ([2](https://docs.angularjs.org/tutorial/step_02))
- What is `karma.conf.js` for?
- How is Karma similar to RSpec?
- How is it different?

### 13. 2-way data binding ([4](https://docs.angularjs.org/tutorial/step_04))
- What is meant by 'Data Binding'?
- Why is '2-way' data binding considered a key feature of Angular?

##### Resources

- [Stack Overflow Post: What is two-way data providing?](http://stackoverflow.com/questions/13504906/what-is-two-way-binding)

### 14. Services/Factories/Providers ([5](https://docs.angularjs.org/tutorial/step_05))
- What are the similar uses of Services and Factories?
- What are the differences between them?
- Why might you use a Service instead of putting AJAX code in the Controller?

##### Resources

- [:pill: Pill: Angular Factories and Services](https://github.com/makersacademy/course/blob/master/pills/angular_factories_services.md)
- [Stack Overflow Post: Services vs Factories vs Providers](http://stackoverflow.com/questions/15666048/angularjs-service-vs-provider-vs-factory)

### 15. Promises and AJAX ([5](https://docs.angularjs.org/tutorial/step_05))
- What does it mean to say "the `$http` module use Promises to do AJAX"?

##### Resources

- [:pill: Pill: JavaScript Promises](https://github.com/makersacademy/course/blob/master/pills/js_promises.md)
