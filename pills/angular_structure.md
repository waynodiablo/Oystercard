#Structure of dataflow in an MVVM Angular application

![angular_structure](https://github.com/makersacademy/course/blob/master/images/mvvc_structure.png)

##1 - Database
One of the main advantages of this system is the independence from a certain server setup. Any database is fine. As long as...

##2 - Server
... your server can serve a RESTful API. Rails is a superb tool to query data from the database and deliver it through an API.

##3 - API
A [RESTful API](http://www.restapitutorial.com/lessons/httpmethods.html) is built on the internet protocol HTTP. Among others the protocol offers the following actions:
  - Post - create
  - Get - read
  - Update - update
  - Delete - delete

It looks like a limited set of actions. But actually it's enough to perform most actions a modern web app needs: Create, read, update and delete things (CRUD).  If a user needs to register for example a new registration gets created. When he logs in, a new sessions gets created, when he logs out the session gets deleted. JSON (Java Script Object Notation) is the format in which this information gets transferred between the server and the user's browser (client).

##4 - Angular: Model
Angular runs in the browser. This is why it needs to be included with a ```<script></script>``` in the HTML-page. The favored structure for Angular apps keeps the logic in models. If you think about Bowling challenge, your BowlingGame and BowlingFrame classes would be models in an Angular app. There are three [types of models in Angular](http://iffycan.blogspot.co.uk/2013/05/angular-service-or-factory.html). There is much confusion about Providers, Factories and services. But actually they are all very similar. Providers are the simplest form. Factories and Services are more complex. You usually can change the word factory into service and your app won't stop working. The word service is used for both. Factories are preferred though when you need to get an object back. In the bowling app you could for example create a factory that "produces" a new game. You inject the factory into your controller and instead of writing new Game, new Frame... into your controller you just call the setupGame factory.

Communication between the server and the client usually happens in the model layer (factories or services) using one of the built in Angular services [$http](https://docs.angularjs.org/api/ng/service/$http) or [$resource](https://docs.angularjs.org/api/ngResource/service/$resource). Like jQuery's AJAX $http and $resource can interact with APIs using GET, POST, DELETE and UPDATE.

##5 - External APIs
Angular is very good if you want to query content from different external APIs to mash it up in your app. You would usually create a factory that gets data from an external API and hands over well formatted content to your controller.

##6 - ngController
The controller connects the models to the page the user interacts with. It has access to both. When you start writing your app the control naturally grows rapidly. It shouldn´t though. Besides from aesthetics the reason is that models are much easier to test on their own than a big controller would be. If you install angular mocks (```npm install angular-mocks --save-dev```) you can [inject your service into your test](https://docs.angularjs.org/guide/services#unit-testing) and test it's functions.

##7 - View Models
One of the biggest advantages of Angular is it's ability to synchronize changes in model and view. There are two ways of doing this: $scope and ```this```. $scope is very handy. You can define functions and properties (variables) on scope which are instantly available in the view. In your controller: ```$scope.myValue = 'hello World'``` in your view ```{{myValue}}``` will show 'hello World' on the page. ```this``` is a bit trickier to use but considered to be cleaner:
In your controller: ```this.myValue``` in your view you use your controller as a variable ```ng-Controller="myController as ctrl"``` to display myValue: ```ctrl.myValue``` will show 'hello World'. In simple cases like this ```this``` nice to use. But if 'myValue' is manipulated in a function it is a bit more complicated since ```this``` within the function isn't the same this...

##8 - Directives
Showing variables in the view isn't that exciting. But have a look at ngRepeat and all the other [useful directives](https://docs.angularjs.org/api/ng/directive/). For example those few additions to the HTML would loop through a list (that has to be defined in the controller).

```HTML
<ul ng-repeat="listitem in list">
  <li>{{listitem.content}}</li>
</ul>
```

##9 Views
This is what the user sees and interacts with. The user experience of Angular pages can be very special though. Since data gets synchronized between models and the view instantly there are no reloads required. The page magically updates it's contents when an API-call has succeeded or a filter button has been clicked.


![Tracking pixel](https://githubanalytics.herokuapp.com/course/pills/angular_structure.md)
