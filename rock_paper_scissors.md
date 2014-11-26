Rock Paper Scissors Lizard Spock in JavaScript on Heroku
======================================================

This project involves implementing the Rock Paper Scissors Lizard Spock game in client side JavaScript and deploying it to Heroku so that anyone in the world can play it.

[Please note, as with all Makers Academy materials, there may be subtle errors in the following materials.  Please try to approach those as challenges on which to polish your debugging skills - pull requests always welcome.] 

## Version 1 - Ruby -> JavaScript

For the initial version of Rock-Paper-Scissors, take our existing Ruby code and Jasmine specs and implement RPS in JavaScript. Some gotchas to watch out for:

* There's no concept of **symbols** in JavaScript (everything is a string)
* **Blocks, methods and classes** are replaced with the :pill: [function keyword](https://github.com/makersacademy/course/blob/master/pills/js_functions.md).
* We define methods outside of the 'class' using the :pill: [prototype](https://github.com/makersacademy/course/blob/master/pills/js_functions.md#function-to-define-methods).
* There are **no constants, or private methods** in JavaScript - so instead we should use :pill: [helpful conventions](https://github.com/makersacademy/course/blob/master/pills/js_conventions.md).

## Version 2 - Rock-Paper-Scissors-Lizard-Spock

![Rock-Paper-Scissors-Lizard-Spock](https://github.com/makersacademy/course/raw/master/images/rpsls.jpg)

For the next iteration, add two new options into the mix: **Lizard** and **Spock**. You can see in the above diagram how these new choices fare against existing matchups, for more info see:

http://en.wikipedia.org/wiki/Rock-paper-scissors-lizard-Spock

Write new Jasmine specs for these new choices. Try and avoid a bunch of long, complicated `if` statements in your implementation. Knowledge of :pill: [arrays in JavaScript](https://github.com/makersacademy/course/blob/master/pills/js_arrays.md) might come in handy.

### Version 2.5 - Victory messages

 Write a new method (with specs) in your Game class, that returns a string with the winning player's name, the winning player's pick, the losing player's name and pick, joined with an appropriate verb. E.g.

> **Alex's rock crushes Tony's scissors**

## Version 3 - Web interface

![RPS interface](https://github.com/makersacademy/course/raw/master/images/rps_interface.png)

Build a simple web interface using HTML and CSS for your Rock-Paper-Scissors game. Using :pill: [jQuery event handlers](https://github.com/makersacademy/course/blob/master/pills/jquery_events.md) to select the player choice when one of the buttons on the page are clicked. Use [data attributes](https://developer.mozilla.org/en-US/docs/Web/Guide/HTML/Using_data_attributes) to tie a particular button to a particular choice.

For the initial version, the computer opponent can always choose the same thing - e.g. always picks rock.

Once the player has picked something, the result ("Alex's rock crushes Tony's scissors") should be appended as a HTML snippet to the bottom of the page. Additionally, try using jQuery animations or [CSS transitions](https://developer.mozilla.org/en-US/docs/Web/Guide/CSS/Using_CSS_transitions) to animate the message appearing.

Some previous students' apps, to inspire you:

* http://rpslsbk.herokuapp.com/
* http://salty-brushlands-7914.herokuapp.com/

### Version 3.5 - Randomness and clearing messages

There are a couple of small improvements we can make. First, we can make the game more interesting by having the computer pick their choice at random. To implement this JavaScript's `Math.random()` method will come in handy.

Additionally, the messages will continue to build up infinitely. Enhance the app so that only the results from the most recent 5 games are displayed. Ideally, old messages should be removed from the DOM (HTML document) as well as being visually hidden.

## Version 4 - Deploy to Heroku

Finally, let's push the application to Heroku. Until now we've been dealing with static HTML/CSS/JS files, but to run this on Heroku's platform, we'll need a very simple server to serve the site. We'll use a minimal Sinatra app to make this deployable.

Our HTML file (e.g. `index.html`) should be given a `.erb` extension and moved to the views directory (e.g. `views/index.erb`). Our CSS and JS files should be moved into the `public` directory.

We'll need a Gemfile to load in Sinatra:

~~~ruby
source 'https://rubygems.org'

gem 'sinatra'
~~~

A very simple Sinatra app.rb:

~~~ruby
require 'sinatra'

get '/' do
  erb :index
end
~~~

And finally a `config.ru` -

~~~ruby
require_relative './app'

Sinatra::Application.run!
~~~

Finally we can create our Heroku app and deploy it:

~~~
heroku create myrpsapp
git push heroku master
~~~

## Related Walkthroughs

* Part 1: JavaScript and Jasmine
  * [JavaScript Intro](https://github.com/makersacademy/Walkthroughs/blob/master/javascript_intro.md)
  * [More JavaScript](https://github.com/makersacademy/Walkthroughs/blob/master/more_javascript.md)
* Part 2: JQuery
  * [jQuery Intro](https://github.com/makersacademy/Walkthroughs/blob/master/jquery_intro.md) 
  * [jQuery animations](https://github.com/makersacademy/Walkthroughs/blob/master/jquery_animations.md) 
* Part 3: JS Templating

## Related Pills

* :pill: [JavaScript & Jasmine](https://github.com/makersacademy/course/blob/master/pills/javascript%26JasminePill.md)
* :pill: [jQuery Events](https://github.com/makersacademy/course/blob/master/pills/jquery_events.md)
* :pill: [JavaScript arrays](https://github.com/makersacademy/course/blob/master/pills/js_arrays.md)
* :pill: [JavaScript conventions](https://github.com/makersacademy/course/blob/master/pills/js_conventions.md)
* :pill: [JavaScript functions](https://github.com/makersacademy/course/blob/master/pills/js_functions.md)

## Resources

### JavaScript

#### MDN

This should be your new bible :smile:. It has exhaustive reference of every function of Javascript, and some good articles to get you started:

* https://developer.mozilla.org/en-US/docs/Web/JavaScript/A_re-introduction_to_JavaScript
* https://developer.mozilla.org/en-US/docs/Web/JavaScript/Introduction_to_Object-Oriented_JavaScript

#### Eloquent JS

A free online book. I wouldn't recommend reading cover-to-cover, just skim through the useful bits (a lot of stuff you'll already know thanks to Ruby):

* http://eloquentjavascript.net/contents.html

#### Douglas Crockford Lectures on JavaScript

These are starting to be a little dated, but they are awesome!  And they contain a lot of computer science history that you really should know.  They are not a great 'introduction' for novices, but once you've spent a few days coding in JavaScript they might make good sense.  Crockford also created the [JSLint JavaScript style checker](http://www.jslint.com/) which can be good for code review.

* [Crockford on JavaScript](http://yuiblog.com/crockford/)
* [JSLint](http://www.jslint.com/)

### Jasmine

* http://jasmine.github.io/2.0/introduction.html
* http://evanhahn.com/how-do-i-jasmine/

### jQuery

* http://learn.jquery.com/about-jquery/how-jquery-works/
* http://learn.jquery.com/events/introduction-to-events/
* http://learn.jquery.com/using-jquery-core/selecting-elements/
* [jQuery fundamentals](http://jqfundamentals.com/) - free interactive book

### CSS transitions

* https://developer.mozilla.org/en-US/docs/Web/Guide/CSS/Using_CSS_transitions
