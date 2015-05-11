#Makermix

##The brief

We would like you to build a pairing organiser for a cohort of Makers' students. We'll get you started with a few user stories:

```
As a bewildered maker  
I want to see a list of everyone in my cohort  
So that I know who these weird people are  

As a promiscuous maker  
I want to see a sorted list of people in my cohort that I have/have not paired with  
So that I can put more notches on my virtual bedpost  

As a shy maker  
I want a pair partner to be randomly assigned to me  
So that I don’t have to ask them  

As an unfriendly maker  
I want to have a blacklist of students I will never be paired with  
So that I never have to listen to them speak  
```

Think about how you would like to build this application. You will probably need a database hosted on a server. You could use Github API to get student and cohort information, however in the first instance you could also just seed the database yourself. Think about the responsibilities of various parts of your application - where will you put the business logic such as blacklists and filtered lists?

###Step 1

Write a feature test, and use this to drive the setup of your application. A good example is a Protractor test that looks for the title of your application, but if you are not using Angular, this could just as easily be in Cucumber or Rspec with Capybara, or Mocha with Webdriver.

###Step 2

Create scenarios for your first user story. Use these to build feature tests and then unit tests to drive you to the point that you need to pull information from your API. For the moment, you could consider stubbing out the API calls, and making a decision about how you want your JSON responses to look like.

###Step 3

At this point you need to think about how and if you are going to directly test your API. 

Rack::Test provides an excellent set of request methods such as get and post, that you can then test expectations upon with RSpec. You can use these to create a test layer between your front end and your back end. If you have already stubbed out your front end JavaScript tests, then your request tests should ensure your JSON is delivered with the required structure. Note that you should not test API responses with Capybara - it is designed for feature tests, testing the user interface.

There is an argument that you should simply rely upon your feature tests to test the user experience, as this will test that your API is functioning correctly - the correct feature tests should drive you to build unit tests on the back end. The advantage of this is that there is less code for you to maintain. The disadvantage is that if you are building an API for public consumption, then you would have nothing testing the requests. 

Both points are valid. Request specs have recently fallen out of favour to some degree, but there are times when they are essential. If you are splitting your front end and back end into seperate repos, then request specs are essential. If you have a single repo, then feature tests should cover it. [This](https://medium.com/@AlexanderJeuris/benefits-of-protractor-in-a-angular-rails-api-application-stack-c60dc44c39b1) blog post on medium.com discusses the issue.

###Step 4

Your request specs or feature tests should drive to you to create unit tests for a database and models.

###Step 5

Remember to push to Heroku early and often.
