GitHub profiles (AngularJS 1.3 Introduction)
==========================

Many thanks to [Tony](http://github.com/antonydenyer) and [Leo](http://github.com/pitchinvasion) for the original design of this component

[Video of session](https://www.youtube.com/watch?v=72KRFITGGts)

***Please note, as with all Makers Academy materials, there may be subtle errors in the following materials.  Please try to approach those as challenges on which to polish your debugging skills - pull requests always welcome.***

(Note also that the initial code for this walkthrough is available in https://github.com/makersacademy/angularjs-intro)

## What is Angular?

In case you missed it earlier:  
:pill: [angularjs](https://github.com/makersacademy/course/blob/master/pills/angularjs.md)

## Single Page Applications (SPAs)
Angular is a framework that helps you build single page applications, the goal being that you have a web application that fits on a single page so that you can provide an experience more akin to a desktop application (think Gmail). Note that we're not going to be covering SPAs in this walkthrough - one step at a time young Padawan!

## Objective
To get started using Angular, we are going to build a simple Github user search.  
To do this we're going to be using [Github's API](https://developer.github.com/v3/search/#search-users).
Be careful when using this endpoint, [it's heavily rate limited](https://developer.github.com/v3/search/#rate-limit). It is recommended that you [register](https://github.com/settings/applications) a new github application to avoid the rate limit.

Also in this walkthrough we're going to build a simple Angular application that demonstrates a few simple concepts:

* [Two-way data-binding](https://docs.angularjs.org/guide/databinding)
* [Dependency injection](https://docs.angularjs.org/guide/di)

In addition we're going to be introducing [bower](http://bower.io/), a package manager for the web.

So let's get started. Make sure you have node and bower installed:

```shell
node -v
bower -v
```

Make sure they both return a version number. Otherwise you will need to install them:

```shell
brew install node
npm install -g bower
```


Now lets get some boilerplate working. Make a new directory, `cd` into it then run:

```shell
bower init
```
Choose the defaults (keep hitting return) and you're all good. Now let's install some packages:

```shell
bower install jquery --save
bower install bootstrap --save
bower install angular --save
bower install angular-resource --save
```
The `--save` will add the package into your `bower.json` file as dependencies. Then when you clone your repo again you can do a `bower install` in exactly the same way as you `bundle install` with Ruby.

Most package managers don't work the same way as Ruby gems. Package managers normally download packages into your local folder. Go ahead and do an `ls` and see what has been downloaded. Now we don't really want to add `bower_components` into our repository - most people consider it bad practice but not all.

Because we don't want to commit those dependencies we need to add `bower_components` to our `.gitignore` file.

Right then - maybe now would be a good time to commit your work.

[Git Diff](https://github.com/makersacademy/angularjs-intro/commit/6c6ded23e91066f1972c60e08e9de4a963c7dbae)

### Let's sketch out some HTML

We're going to need somewhere to get the user search term and somewhere to display the results. Let's knock together a form with a button, a text box, and an unordered list for our results.  

Also note we're pulling in our AngularJS dependencies at the top of the code.

Go ahead and add the following code into **index.html**:

```html
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Github user search</title>
    <link rel="stylesheet" href="bower_components/bootstrap/dist/css/bootstrap.css">
    <script src="bower_components/jquery/dist/jquery.js"></script>
    <script src="bower_components/angular/angular.js"></script>
    <script src="bower_components/angular-resource/angular-resource.js"></script>
  </head>

  <body>
    <div>
      <form class="form-horizontal">
        <input type="text" >
        <button class="btn">Search</button>
      </form>
      <ul class="list-group">
        <li class="list-group-item">
          <img src="https://avatars.githubusercontent.com/u/469160?v=3&s=50">
          <a href="https://github.com/antonydenyer">antonydenyer</a>
        </li>
        <li class="list-group-item">
          <img src="https://avatars.githubusercontent.com/u/30216?v=3&s=50">
          <a href="https://github.com/tansaku">tansaku</a>
        </li>
      </ul>
    </div>
  </body>
</html>
```

What we're doing here is stubbing out what we want the page to look like with some results. It'll help us get a feel for the visual design.

Go ahead and `open index.html`. Have a play and get it looking how you want.

[Git Diff](https://github.com/makersacademy/angularjs-intro/commit/a68c6fb0773778375c6c26cf115e2ec512f18160)

### Creating the Angular module

Now we need to create our Angular module (not to be confused with Ruby modules!).

Create a new file called **js/app.js** and put in the following.

```js
var githubUserSearch = angular.module('GitUserSearch', ['ngResource']);
```

Now lets reference the script from our HTML.  
```html
<script src="js/app.js"></script>
```

What is all this? We're doing a couple of things: first we're creating our application called 'GitUserSearch' and then we're also pulling in the [ngResource](https://docs.angularjs.org/api/ngResource) module as an external dependency. What scope is the variable `githubUserSearch` in? Refresh `index.html` and use your console to find out. Do you think this is the right place for this to be?

Now that we've created an app we need to wire it up to the HTML. Place `ng-app="GitUserSearch"` inside the `html` tag so it looks like this:

```html
<html lang="en" ng-app="GitUserSearch">
```

Notice that Angular uses the **string** to wire up the app and not the **variable**; it's `'GitUserSearch'` and not `githubUserSearch`.

[Git Diff](https://github.com/makersacademy/angularjs-intro/commit/f236ebbda39f9d06a2a764c3f5e68c0dc2b1170c)

### Setting up our test environment

Before going any further we need to setup our test environment - since we want to be practising TDD we'll need to write some tests before we write any more Angular code. Fortunately as we'll see Angular provides plenty of options for testing your code, but first we need to get our environment set up with some boilerplate.

```shell
bower install angular-mocks --save-dev
bower install angular-route --save-dev
```

(`save-dev` saves these dependencies in the `bower.json` file, but as development only dependencies. That's because we won't be needing these libraries in production.)

Angular comes with tools to help you test your applications, but we'll need something to run these tests for us. A common test runner is [Karma](http://karma-runner.github.io), which we'll be using for this walkthrough.

To get cracking you need to install some packages, which we'll do via npm. Npm is a bit like bower but for node modules, and has a **package.json** file which stores our node dependencies (a bit like a Gemfile in Ruby). To generate this file run the following command, pressing return for every argument like you did when setting up bower:

```shell
npm init
```
> Don't forget to add `node_modules` to your .gitignore to prevent all of your node modules being added to git.

Now let's install our node packages:

```shell
npm install karma --save-dev
npm install karma-jasmine karma-chrome-launcher karma-phantomjs-launcher --save-dev
npm install -g karma-cli
```

Then you need to set up your karma config. This can be done with the command `karma init`, which takes you through a series of questions about your project to create the files. However in this case just create a folder called **test** and place inside it a file called **karma.conf.js** with the following code. This will be our Karma config file.

```js
// Karma configuration
// Generated on Thu Nov 27 2014 10:43:21 GMT+0000 (GMT)

module.exports = function(config) {
  config.set({

    // base path that will be used to resolve all patterns (eg. files, exclude)
    basePath: '../',


    // frameworks to use
    // available frameworks: https://npmjs.org/browse/keyword/karma-adapter
    frameworks: ['jasmine'],


    // list of files / patterns to load in the browser
    files: [
      'bower_components/angular/angular.js',
      'bower_components/angular-route/angular-route.js',
      'bower_components/angular-resource/angular-resource.js',
      'bower_components/angular-mocks/angular-mocks.js',
      'js/**/*.js',
      'test/**/*.spec.js'
    ],


    // list of files to exclude
    exclude: [],


    // preprocess matching files before serving them to the browser
    // available preprocessors: https://npmjs.org/browse/keyword/karma-preprocessor
    preprocessors: {},


    // test results reporter to use
    // possible values: 'dots', 'progress'
    // available reporters: https://npmjs.org/browse/keyword/karma-reporter
    reporters: ['progress'],


    // web server port
    port: 9876,


    // enable / disable colors in the output (reporters and logs)
    colors: true,


    // level of logging
    // possible values: config.LOG_DISABLE || config.LOG_ERROR || config.LOG_WARN || config.LOG_INFO || config.LOG_DEBUG
    logLevel: config.LOG_INFO,


    // enable / disable watching file and executing tests whenever any file changes
    autoWatch: true,


    // start these browsers
    // available browser launchers: https://npmjs.org/browse/keyword/karma-launcher
    browsers: ['PhantomJS'],


    // Continuous Integration mode
    // if true, Karma captures browsers, runs the tests and exits
    singleRun: false
  });
};
```

Now you can run fire up your test runner and watch your tests pass and fail.

```bash
karma start test/karma.conf.js
```

Notice that this will throw an error since we haven't got any tests!

[Git Diff](https://github.com/makersacademy/angularjs-intro/commit/5987e7e327639a37ddc98669d2bf9d21010c71ee)

### Adding a controller

Angular uses **controllers** to orchestrate what's happening in our view. We're going to create a GitUserSearchController to handle our searches.

But first let's write a unit test. Don't worry if this test doesn't entirely make sense, it will become clearer what we're doing as we go on. For the moment just create a file in your **test** folder called **gitUserSearchController.spec.js** and enter the following code - does any of it look familiar from Rspec?

```js
describe('GitUserSearchController', function() {
  beforeEach(module('GitUserSearch'));

  var ctrl;

  beforeEach(inject(function($controller) {
    ctrl = $controller('GitUserSearchController');
  }));
});
```

This just sets up our test - the interesting things to look at here are the `beforeEach` and `inject`. `beforeEach` is running before each test. `inject` is a built-in Angular function that allows us to access the Angular app and our controller from inside our tests.

Now let's add a test - place this below the beforeEach with the describe callback.

```js
it('initialises with an empty search result and term', function() {
  expect(ctrl.searchResult).toBeUndefined();
  expect(ctrl.searchTerm).toBeUndefined();
});
```

Restart karma by running `karma start test/karma.conf.js`. You should be getting a failed test now, this is because we need to define a controller. Create a file named **gitUserSearchController.js** and define a controller inside the file:

```js
githubUserSearch.controller('GitUserSearchController', [function() {

}]);
```

In the view we're going to need to tell Angular that this is the controller we want to use. This can also be achieved using routing, but we're not going to cover that here.

Go ahead and reference the controller inside the opening `body` tag.
```html
<body ng-controller="GitUserSearchController as searchCtrl">
```
We're indicating that everything inside the `body` tag is handled by the `GitUserSearchController`, and we are setting an alias `searchCtrl` that will be used in the view to refer to this controller.

We've forgotten to do something, try and figure it out - and careful as it won't be picked up in our tests.

[Git Diff](https://github.com/makersacademy/angularjs-intro/commit/a1c7ab0221d575e7a76a540042facf104a3c26b8)

> Make sure your tests are now passing before moving on with the walkthrough!

###Data binding

Let's now spec out the next bit of our code:

```js
describe('when searching for a user', function() {

  var items = [
    {
      "login": "tansaku",
      "avatar_url": "https://avatars.githubusercontent.com/u/30216?v=3",
      "html_url": "https://github.com/tansaku"
    }, 
    {
      "login": "stephenlloyd",
      "avatar_url": "https://avatars.githubusercontent.com/u/196474?v=3",
      "html_url": "https://github.com/stephenlloyd"
    }
  ];

  it('displays search results', function() {
    expect(ctrl.searchResult.items).toEqual(items);
  });
});
```
Here we've set up some dummy results that mock the kind of results we expect to get back from the API. If you run Karma again you should see that this test is now failing.

Now in your controller let's add this mock data as our search results:

```js
var self = this;

self.searchResult = {
  "items": [
    {
      "login": "tansaku",
      "avatar_url": "https://avatars.githubusercontent.com/u/30216?v=3",
      "html_url": "https://github.com/tansaku"
    }, 
    {
      "login": "stephenlloyd",
      "avatar_url": "https://avatars.githubusercontent.com/u/196474?v=3",
      "html_url": "https://github.com/stephenlloyd"
    }
  ]
};
```

What we're doing here is creating a property `searchResult` in our controller with a hash containing our dummy search results. Setting this hash to `self.searchResult` allows us to use `searchCtrl.searchResult` in our views, as we'll see later. Why do you think we are declaring the variable `var self = this;` ?

Check your tests again. This time the second test is passing but the original one is failing - this is because `ctrl.searchResult` is no longer undefined when we first initialise the app. We will fix this in the next section!

[Git Diff](https://github.com/makersacademy/angularjs-intro/commit/938c5273d7037a3a44ad455cca7eb6057ba3f492)

To get the data we've just added to our controller into your view, amend your `index.html`, replacing the `ul.list-group` with the following:

```html
<ul class="list-group">
  <li ng-repeat="user in searchCtrl.searchResult.items">
    <img ng-src="{{user.avatar_url}}&s=50">
    <a ng-href="{{user.html_url}}">{{user.login}}</a>
  </li>
</ul>
```

Look upon my works, ye Mighty, and despair! We've polluted our html with a load of Angular [cruft](http://en.wikipedia.org/wiki/Cruft). This is one of the downsides of using a framework like Angular. Let's look at some of the details:

* Mustache `{{your_variable_here}}` - you need to use a mustache to get access to the [scope](https://docs.angularjs.org/guide/scope). In our example we are using `{{user.login}}` to access the `login` property on the `user` object. However notice inside `ng-repeat="user in searchCtrl.searchResult.items"` we don't use them.
* [ng-repeat](https://docs.angularjs.org/api/ng/directive/ngRepeat) is an Angular directive that behaves like a for loop. Basically we're going to iterate for every user in the items array. Notice that we've called the variable `user`.
* [ng-src](https://docs.angularjs.org/api/ng/directive/ngSrc) just sets the `src` attribute on the `img` after everything has loaded. If we didn't do this and set `src="{{user.avatar_url}}"` (as opposed to `ng-src`) then the page would show a broken image link. This is because it takes a short while after the page has loaded for Angular to replace strings like `{{user.avatar_url}}` with the dynamically generated value.  
* [ng-href](https://docs.angularjs.org/api/ng/directive/ngHref) similarly just sets the `href` once Angular has replaced any markup.  

When do I need to use Mustaches and when don't I? Well it depends on the directive: `ng-repeat` takes an expression whereas `ng-src` takes a template as an argument. In short you need to [read the docs](https://docs.angularjs.org/guide).

Let's open up the **index.html** file and see how things look:

```shell
open index.html
```

Looks good, but our tests are still failing. This is because our search results are magically appearing when we visit the page, before we've even done a search. This was fine for us testing that the styling and markup works as expected, but now we want Angular to dynamically render our search results.

To do this we need to wire up the button to do something. We want to perform a search when the user clicks on it. To do this we're going to use the [ng-click](https://docs.angularjs.org/api/ng/directive/ngClick) directive.
First we need to define a function in the controller so that when we click the button we actually do something.

In your controller add the following code:

```js
self.doSearch = function() {
  console.log("Hello World");
};
```

Now in your view code you can wire up the button using `ng-click` like this:

```html
<button class="btn" ng-click="searchCtrl.doSearch()">Search</button>
```
Open up your browser console and make sure "Hello World," is being output when you click on the search button.

Now we can see that `doSearch()` is being triggered when we click on the search button, we can replace the `console.log` statement with the code that assigns our dummy data hash to `self.searchResult`:

```js
self.doSearch = function (){
  self.searchResult = {
    items: [
      {
        "login": "tansaku",
        "avatar_url": "https://avatars.githubusercontent.com/u/30216?v=3",
        "html_url": "https://github.com/tansaku"
      }, 
      {
        "login": "stephenlloyd",
        "avatar_url": "https://avatars.githubusercontent.com/u/196474?v=3",
        "html_url": "https://github.com/stephenlloyd"
      }
    ]
  };
};
```

Now we need to update our tests so that they call our `doSearch()` method before we check for the dummy data:

```javascript
it('displays search results', function() {
  ctrl.searchTerm = 'hello';
  ctrl.doSearch();
  expect(ctrl.searchResult.items).toEqual(items);
});
```

Finally our tests are passing again!

[Git Diff](https://github.com/makersacademy/angularjs-intro/commit/f211d830e06d56a89287f7904e32927dca97c27d)

### Data Binding (Again)

How are we going to get the input that was entered into the text box?

We're going to use data binding again. Yes, we've already done some data binding! When we wired up the search button to our controller we bound the click action to the function `doSearch`.

This time we're going to bind the input text box to our controller using `ng-model`. This means any  value entered into that input will be immediately assigned to the `self.searchTerm` variable.

So on your text box you need to add:
```html
<input type="text" ng-model="searchCtrl.searchTerm">
```

Inside the controller you can now access the input value using `self.searchTerm`. Try doing a `console.log(self.searchTerm);` inside the `doSearch` function.

> Ideally we'd test this rather than just use a console.log, but for that we'd need to use [Protractor](https://github.com/angular/protractor) - Angular's answer to Capybara. Unfortunately that's outside the scope of this walkthrough, so [we've added a bonus subwalkthrough](/further_javascript/protractor.md).

[Git Diff](https://github.com/makersacademy/angularjs-intro/commit/058b57c1071bc51d4ba9669dd338b28fe096c701)

Delete the `console.log()`, once you're done testing. It's always a good idea to tidy up your code as you go along! Note that we are leaving searchCtrl.searchTerm in our html, but we have not yet declared that in our controller. We will proceed to wire that up to the controller in the next section.

### Github API

Now all we have to do is wire up the GitHub API to return the results. To do this we're going to use [ng-resource](https://docs.angularjs.org/api/ngResource/service/$resource) this is a factory that  makes interactions with a [RESTful](http://en.wikipedia.org/wiki/Representational_state_transfer) API a lot easier.

First we need to inject `$resource` into our controller so that we can make use of it. Simply add the `$resource` to the list of arguments in your controller function.

```js
githubUserSearch.controller('GitUserSearchController', ['$resource', function($resource) {
```

This concept is called [Dependency Injection](http://c2.com/cgi/wiki?DependencyInjection). Essentially Angular is looking up what the controller needs by looking at the parameters and their names. It then calls the function with these parameters and the arguments it requires already instantiated. The injector will compare the name of each dependency in the strings to the variables called in the function's arguments - if you have more than one dependency these must be in the same order within the array and the function.  You don't need to worry too much about this at this stage but just know that it's there and that it works.

To use the GitHub API we can hit `https://api.github.com/search/users` with a query parameter `q` and a value. For example `https://api.github.com/search/users?q=antony`.

So now all we need to do put it all together. Let's create a `searchResource` at the top of our controller.

**If you haven't already created a Github Application, you are probably blowing through the limit of calls to the GitHub API at this point (especially as everyone in the room is doing a similar thing). Try generating a [personal access token](https://github.com/settings/applications#personal-access-tokens) for the app on your GitHub profile, and then add it to the API call using the URL parameter `access_token`. This should remove the GitHub limiting of your API requests.**

```js
var searchResource = $resource('https://api.github.com/search/users');
```

and then inside our `doSearch` function replace the dummy data we set to:

```js
self.searchResult = searchResource.get(
  { q: self.searchTerm }
);
```

The `get` method takes an object and uses the key-value pairs as the URI parameter string - hence `q`. How would you add your access token to the request?

If we run our tests we will see them now failing.

We included when setting up our tests a module called `angular-mocks` which stops us making HTTP requests in our unit tests. This is particularly useful in this case because Github imposes a limit on API requests which we could quickly go over if we are constantly running our tests.

So how do we stub out our request? Well first we need to set up our `httpBackend` stub in a beforeEach block (this goes in the part of the test where we `describe` "when searching for a user").

Stubs allow us to mock the return value we get back from a method, this allows us to once again use dummy data in our tests:

```js
var httpBackend;
beforeEach(inject(function($httpBackend) {
  httpBackend = $httpBackend
  httpBackend
    .when("GET", "https://api.github.com/search/users?q=hello")
    .respond(
      { items: items }
    );
}));
```

See if you can figure out what's going on - notice where we've set our expected response to `items` which is the dummy data we defined earlier in the walkthrough.

If we run our test again what do we get? Still no dice!

```shell
Expected undefined to equal [...].
```

This is because you need to call `flush()` on `httpBackend` after you have called the `doSearch()` method - this just ensures the stubbed results is returned in our test.

```js
describe('GitUserSearchController', function() {
  beforeEach(module('GitUserSearch'));

  var ctrl;

  beforeEach(inject(function($controller) {
    ctrl = $controller('GitUserSearchController');
  }));

  it('initialises with an empty search result and term', function() {
    expect(ctrl.searchResult).toBeUndefined();
    expect(ctrl.searchTerm).toBeUndefined();
  });

  describe('when searching for a user', function() {

    var httpBackend;
    beforeEach(inject(function($httpBackend) {
      httpBackend = $httpBackend
      httpBackend
        .when("GET", "https://api.github.com/search/users?q=hello")
        .respond(
        { items: items }
      );
    }));

    var items = [
      {
        "login": "tansaku",
        "avatar_url": "https://avatars.githubusercontent.com/u/30216?v=3",
        "html_url": "https://github.com/tansaku"
      }, 
      {
        "login": "stephenlloyd",
        "avatar_url": "https://avatars.githubusercontent.com/u/196474?v=3",
        "html_url": "https://github.com/stephenlloyd"
      }
    ];

    it('displays search results', function() {
      ctrl.searchTerm = 'hello';
      ctrl.doSearch();
      httpBackend.flush();
      expect(ctrl.searchResult.items).toEqual(items);
    });
  });
});
```

Try changing the search term. What happens to your tests?

[Git Diff](https://github.com/makersacademy/angularjs-intro/commit/91909c9d580dce3d9c3fa4d4ef295e7c8e953eb8)

### Auto-Search

Now what we'd like to do is search when the user types something in. There are two parts to this: [ng-change](https://docs.angularjs.org/api/ng/directive/ngChange) and [ng-model-options](https://docs.angularjs.org/api/ng/directive/ngModelOptions). The first part  `ng-change` defines what you want to do when the element you've bound it to changes. But the question remains - when to fire the change event? On every key press? On `blur`? This is where `ng-model-options` comes in.

The first part is simple: we just need to bind `ng-change` to our `doSearch` function inside our text value. There is a deliberate mistake in the code below - can you figure out what is wrong?

```html
<input type="text" ng-model="searchTerm" ng-change="doSearch()">
```

The second part needs a bit more thought. On our text box we want to fire the change event after 500ms of no activity so Angular waits for someone to stop typing before performing a search.

```js
ng-model-options="{ updateOn: 'default blur', debounce: {'default': 500, 'blur': 0} }"
```

[Git Diff](https://github.com/makersacademy/angularjs-intro/commit/90df9da42204112d8c2edb4efc4c120aa3e92cef)

### Adding a service.

So we now have a functioning application that can query the Github API and return results in a useable format. Let's think about making our code more maintainable.

:pill: [Factories, services (and providers)](https://github.com/makersacademy/course/blob/master/pills/angular_factories_services.md)

Looking at our code, we are currently performing an http request directly from our controller. Bearing in mind that the controller's responsibility is to provide an interface between the view and the view-model, it seems that making a request to an external API does not fall within that single responsibility. So let's look at refactoring that functionality into a type of service called a factory.

As always, let's start with the tests. We're planning to extract the http request into a separate service, so let's start by ensuring that `$httpBackend` is testing that a get request would be sent. Change the following code in test/gitUserSearchController.spec.js:

``` javascript
  beforeEach(inject(function($httpBackend) {
      httpBackend = $httpBackend
      httpBackend
        .expectGET("https://api.github.com/search/users?q=hello&access_token=yourtoken")
        .respond(
          { items: items }
        );
  }));
```
This is simply setting an expectation that a GET request will be sent. Don't worry, `$httpBackend` will automatically stub that request before it is sent to Github. Let's just make absolutely sure that these expectations will be met, by adding the following code into the same `describe` block:

```javascript
  afterEach(function() {
    httpBackend.verifyNoOutstandingExpectation();
    httpBackend.verifyNoOutstandingRequest();
   });
```
This will check after every test that the expected requests have been made, and that no extra requests have been made. At this stage, your tests should still pass. Now let's create a test for our new factory, in a new file `test/searchfactory.spec.js`:

```javascript
describe('factory: Search', function() {

  var search;

  beforeEach(module('GitUserSearch'));

  beforeEach(inject(function(Search) {
    search = Search;
  }));

  it('responds to query', function() {
    expect(search.query).toBeDefined();
  });

});
```

So what is going on here?

We are describing a new factory called 'Search'. We are instantiating a new angular module before every test. Then we are instantiating a new instance of the Search factory for each test and injecting it in. By instantiating a new Angular module and a new factory before every test, we ensure that no state is maintained between each test - so each test runs in isolation.

If you run your tests now, you should see something like:

```
PhantomJS 1.9.8 (Mac OS X) factory: Search responds to query FAILED
  Error: [$injector:unpr] Unknown provider: SearchProvider <- Search
```
So, our tests are now driving us to create a new service called Search. Make a file `js/searchFactory.js` and add the following code:

``` javascript
githubUserSearch.factory('Search', ['$http', function($http) {

}]);
```

If we run our tests, we now see ``` Error: [$injector:undef] Provider 'Search' must return a value from $get factory method. ```.

This is prompting us to return a response to the method 'query'. Factories expose their API by returning an object or a function to provides the interface. To add the smallest possible amount of code to pass the test, add something like this to our factory:

```javascript
  return {
    query: 'foo'
  }
```

All we are doing here is returning an object, thus defining `.query` as a message that can be called on the factory. The tests should now pass, but we still haven't got any functionality!

So, let's start moving http functionality over from the controller to the service. Start by injecting the `$httpBackend` service into our tests in a `beforeEach` function, exactly as we did for the controller:

```
beforeEach(inject(function($httpBackend) {
    httpBackend = $httpBackend
    httpBackend
      .when("GET", "https://api.github.com/search/users?q=hello")
      .respond(
        { items: items }
      );
  }));
```

We will also need to define items in our new test - however, this creates some duplication, remember to refactor this later. The next step is to test the promise that is returned by our http request:

```javascript
it('returns search results', function() {
  search.query('hello')
    .then(function(response) {
      expect(response.data.items).toEqual(items)
    })
  httpBackend.flush();  
})
```
So what is all this? HTTP requests in Angular return a promise. This means you have to wait for the request to be fulfilled in order for that promise to contain the data you need. The `.then` method will wait for a promise to be completed before executing the code - in this case, our expectation. Watch the test fail, then let's fix the code:

```javascript
githubUserSearch.factory('Search', ['$http', function($http) {
  var queryUrl = 'https://api.github.com/search/users';
  return {
    query: function(searchTerm) {
      return $http({
        url: queryUrl,
        method: 'GET',
        params: {
          'q': searchTerm
        }
      }); 
    }
  }
}]);
```
Now we are using the `$http` service to make an http request. The details of the request are in a config block. Where do you think we might add our Github access token?

We should now have 4 passing tests, but we still haven't wired up our factory to our controller:

```javascript
githubUserSearch.controller('GitUserSearchController', ['Search', function(Search) {
  var self = this;
 
  self.doSearch = function() {
    Search.query(self.searchTerm)
      .then(function(response) {
        self.searchResult = response.data;
      })
  };
}]);
```
This basically collects the promise from the factory, and when the request completes, it updates the viewmodel. 

Our tests should still all pass.

There's a couple of things to clean up:

* Although our tests pass, the website doesn't work. Why might that be?
* We have some duplications in the tests, as we are now testing the same thing (calling out to an API) in two places - how could we refactor that? Should we start mocking more things?
* Notice how when you clear the text box you're still trying to search.
* Add a label to let the user know what they have just searched for.
* Do you have a bug where some of the avatars are blown up really huge?
