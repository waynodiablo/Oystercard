Heroku
=========

Having a website on your local computer is great but you really want it to be available to everyone on the Internet. Heroku is a service that can host your website for free.  Using Heroku tools you can deploy your code to a remote server, so that you could access it from any computer.


### Register with Heroku

[Heroku](http://heroku.com) is a US company providing free hosting for small websites. The process of putting your website online used to be convoluted but now thanks to Heroku and similar companies it's actually really simple.

Go to [Heroku](http://heroku.com) and register for a new account. Note your email and password, you'll need it in a second.

Once you have the username and password from the website, go to the terminal and run this command to check that [Heroku Toolbelt ](https://toolbelt.heroku.com/)is installed correctly.

````
heroku --version
````

You should see something like

````
heroku-gem/2.35.0 (x86_64-darwin12.3.0) ruby/2.0.0
````

If you get "command not found" message, you will need to install [Heroku Toolbelt ](https://toolbelt.heroku.com/).

You should also check that you have a program called git that is necessary to send your website to Heroku. Run this in the terminal.

````
git --version
````

You should see something like

````
git version 1.7.12.4 (Apple Git-37)
````

Once you have verified that you have heroku and git locally, we need to start preparing for deployment.

### Prepare the project for deployment

Taking a Sinatra app as an example, here's a few things we need to ensure to deploy to Heroku. 

First up we must have a Gemfile to specify the dependencies our project requires. Ensure that it has at least the following:

````ruby
source "https://www.rubygems.org"
gem "sinatra"
````

And ensure that you have installed all dependencies via:

````
bundle install
````

If you get the message "bundle: command not found", then we need to install this utility first. Run this:

````
gem install bundler
````

Then, retry running

````
bundle install
````

This will create a Gemfile.lock file that locks downs the versions of your gems (libraries) that will be installed on the remote server. 

The second file we'll need will tell Heroku how to start our website. Create a file called config.ru (all lowercase) and put the following two lines inside:

````ruby
require './app'
run Sinatra::Application
````

This means that to launch this website we need to run a Sinatra application located in `app.rb`.  If your Sinatra app is in a different location you'll need to change this require statement appropriately

If your project files are not in a git repository we will need to prepare them for deployment. To do this, execute the following commands **while being in the project directory in the Terminal**. T

````
git init
git add .
git commit -m 'first version'
````

### Going live!

Now our files are all bundled together and are almost ready to be sent to Heroku. Now we need to login to Heroku from the terminal. Type

````
heroku login
````

Heroku then will ask you for your username and password (the one that you've set when you registered on the website). It will also ask you if you want to generate a public key (say that you do). After you enter the username and password, you'll be able to create your new website at Heroku. Type this

````
heroku create 
````

Finally, we're ready to deploy. Type this command into the terminal. At this point your website will actually be sent to the web server and become live.

````
git push heroku master
````

You should see something like this as an output.

````
Counting objects: 13, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (7/7), done.
Writing objects: 100% (7/7), 675 bytes, done.
Total 7 (delta 4), reused 0 (delta 0)

-----> Ruby/Rack app detected
-----> Using Ruby version: ruby-2.0.0
-----> Installing dependencies using Bundler version 1.3.2
       Running: bundle install --without development:test --path vendor/bundle --binstubs vendor/bundle/bin --deployment
       Using rack (1.5.2)
       Using rack-protection (1.5.0)
       Using shotgun (0.9)
       Using tilt (1.4.1)
       Using sinatra (1.4.3)
       Using bundler (1.3.2)
       Your bundle is complete! It was installed into ./vendor/bundle
       Cleaning up the bundler cache.
-----> Discovering process types
       Procfile declares types     -> (none)
       Default types for Ruby/Rack -> console, rake, web

-----> Compiled slug size: 25.1MB
-----> Launching... done, v7
       http://tech-bikers-demo.herokuapp.com deployed to Heroku

To git@heroku.com:tech-bikers-demo.git
   fc4d30c..8bdc99d  master -> master
````

If you see it, it means that the deployment went successfully. If you see an error, you're going to have to start Googling the error you get and spending some time on Stack Overflow. Until you see an output like the one shown above, it hasn't worked. Keep trying and don't give up.

Finally, once you've got the confirmation that the app has deployed to Heroku (as per line 25 above), you can type:

````
heroku open
````

into the Command Line and it will be launched in the browser! It should look exactly the same as on your local machine but this time it will have a public URL that you'll be able to use from any computer.