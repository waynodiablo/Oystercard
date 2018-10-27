#Makermix

##The brief

We would like you to build a pairing organiser for a cohort of Makers' students. We'll get you started with a few user stories:

```
As a maker
I want to be paired with someone
So that I can learn faster

As a bewildered maker
I want to see a list of everyone in my cohort
So that I know who these weird people are

As a promiscuous maker
I want to see a sorted list of people in my cohort that I have/have not paired with
So that I can keep pairing with more people

As an odd maker in an odd-numbered cohort
I want to work in a three
So that I am not forever alone

As a shy maker  
I want a pair partner to be randomly assigned to me  
So that I don’t have to ask them  

As an unfriendly maker  
I want to have a blacklist of students I will never be paired with  
So that I never have to listen to them speak  
```

**Optional** (more difficult, and potentially more than a few days' work)

```
As a security-conscious maker
I want to be able to log in with a password
So that nobody can see my lists

As a lazy security-conscious maker
I want to sign in through github
So that I don't have to remember another password

As a curious maker
I want to see other students' github commit history
So that I can compare my progress to theirs

As a maker with many commits
I want to be preferentially paired with someone who has fewer commits
So that I can accelerate our learning by pairing together
```

Think about how you would like to build this application. You will probably need a database hosted on a server. Think about the responsibilities of various parts of your application - where will you put the business logic such as blacklists and filtered lists?

###Step 1

Write a set-up test, and use this to drive the setup of your application. For example, you can write a Protractor test that looks for the title of your application, but if you are not using Angular, this could just as easily be in Cucumber, RSpec w/Capybara, or Mocha. Typically, to get this first test to pass, you will need to get your application to a point where you are serving an HTML page and loading the minimum necessary JavaScript dependencies. Once everything is working, delete this test.

###Step 2

Create scenarios for your first user story. Use these to build feature tests and then unit tests to drive you to the point that you need to pull information from your API. For the moment, you could consider stubbing out the API calls, and making a decision about how you want your JSON responses to look like.

###Step 3

At this point you need to think about how and if you are going to directly test your API. 

Rack::Test provides an excellent set of request methods such as GET and POST, that you can then test expectations upon with RSpec. You can use these to create a test layer between your front end and your back end. If you have already stubbed out your front end JavaScript tests, then your request tests should ensure your JSON is delivered with the required structure. Note that you should not test API responses with Capybara - it is designed for feature tests, testing the user interface.

###Step 4

Your request specs or feature tests should drive the creation of unit tests for a database and models.

###Step 5

Remember to deploy to Heroku early and often.


![Tracking pixel](https://githubanalytics.herokuapp.com/course/makermix/makermix.md)
