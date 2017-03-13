# Welcome to JavaScript

## What is JavaScript?

JavaScript is a fully-featured programming language.  It runs in the web browser.  It lets you write web apps that can update the page without a page refresh.

It's a great second language to learn, as it introduces many new language concepts not found in Ruby. It will also let you reinforce concepts you've already learned.

## Goals for the week

Ask yourself the same two questions:

* Are you having fun?

* Are you a better developer than you were yesterday?

By the end of the week, the goal is to be able to answer "yes" to the week's primary question:

* **Can you learn a new language and its patterns?**

### Check your understanding

To guide your learning, aim to be able to answer "yes" to the questions below.

Return to these questions each day to check your understanding.

#### JavaScript

* Can you read and write JavaScript syntax?

* Can you understand the rules that govern the behaviour of the `this` keyword?

* Can you follow the flow of an Ajax request and response?

* Can you follow the flow of control through code that uses callbacks?

#### Transferring your existing skills

* Can you encapsulate behaviour in JavaScript?

* Can you get visibility effectively in JavaScript?

* Can you TDD in JavaScript?

* Can you follow the flow of control over the whole web app cycle? e.g. the interface of a thermostat is displayed in HTML/CSS, the "increase temperature" button is clicked, a JavaScript click event fires, JavaScript code runs to handle the event, an Ajax request is made, a Sinatra controller POST action handler is run, a Thermostat Ruby model is updated, the new temperature is saved to a Postgres database, the new temperature is returned as JSON by the Ruby controller, JavaScript code runs to update the temperature in the web page.

## The Count project

The [Count](https://github.com/maryrosecook/count) project is a tiny, model full stack web app.  It exemplifies:

* Making Ajax requests.
* Testing frontend code.
* Separating frontend concerns into model, view and controller.

It's very worthwhile spending time investigating and playing with the code in this project to understand how it works.

## Challenges

### Rewrite fizz buzz and the airport challenge

You'll revisit some familiar exercises to map the knowledge you learnt in the first four weeks to JavaScript: the FizzBuzz kata, followed by translating the Airport challenge.

### Thermostat

You'll then build the business logic to model a simple thermostat, and learn to hook it up to a dynamic visual interface using jQuery - all within the browser. Finally, you'll use JavaScript to fetch data from external sources and display that on the page - again, all right from the page. Underpinning all this will be a new testing framework to help you test-drive your JavaScript code - Jasmine.

## Challenges

[JavaScript Basics](javascript_basics.md)
[Setting up Jasmine](setting_up_jasmine.md)
[FizzBuzz in JavaScript](fizzbuzz_in_javascript.md)
[Airport in JavaScript](airport_challenge_js.md)
[Thermostat: business logic](thermostat_logic.md)
[Thermostat: interface](interface.md)
[Thermostat: jQuery](jquery.md)
[Thermostat: APIs](apis.md)
[Thermostat: styling](styling.md)
[Thermostat: saving state](saving_state.md)
