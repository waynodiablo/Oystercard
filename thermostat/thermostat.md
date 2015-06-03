# JavaScript: Thermostat interface

This week we're looking at JavaScript, a very important language, since it is the only language that runs natively in client browsers.  It can also run on the server side, but as the de-facto client language it is hugely important.  Designed in 10 days in the 1990's by Brendan Eich since "if I didn't design it in less than 10 days, something much worse than JavaScript would have happened", JavaScript is a somewhat querky language that combines various elements from different existing languages, and has both great power and some dangerous pitfalls.

Please check out the [Learning Objectives for this week](learning_objectives.md) and refer to these throughout the week.

The project this week is to create a simple digital thermostat, using JavaScript, test-driven with Jasmine and using JQuery to interact with the HTML page.  As with Battleships Web, there are 2 parts to this project:

* The first is to build a thermostat model, which encapsulates the business logic.
* The second is to create a user interface (UI) in HTML to interact with the thermostat and provide buttons and a display similar to the following:


![Thermostat](../images/thermostat.png)

Use the specification below to plan your code.  Think about the separation of concerns (SOC) principle.  Which parts of your code should handle the different requirements?

### Specification

- Thermostat starts at 20 degrees
- You can increase the temp with the up button
- You can decrease the temp with the down button
- The minimum temperature is 10 degrees
- If power saving mode is on, the maximum temperature is 25 degrees
- If power saving mode is off, the maximum temperature is 32 degrees
- Power saving mode is on by default
- You can reset the temperature to 20 by hitting  the reset button
- The thermostat should colour the display based on energy usage - < 18 is green, < 25 is yellow, otherwise red


## This week's talks
Here's an overview of the schedule for talks this week:

* Monday
  * Introduction to JavaScript (Stages 1-3)
  * Using Node or Chrome console to play.
  * Javascript functions and Scope.- (tjo - day 1 or 2.?)
* Tuesday
  * HTML and CSS
* Wednesday
  * Introduction to jQuery (Stage 4)
* Thursday
  * API's, AJAX, Asynchronous transactions (Stage 5)
* Friday
  * Weekend Challenge release
  * Retrospective


## Stage 1 - Introduction to JavaScript

To get started learning test-driven JavaScript please work through the [Javascript & Jasmine Pill](../pills/javascript&JasminePill.md).

Spend some time practicing more with the JavaScript syntax.  Use Node or the Google Chrome console as a [REPL](http://en.wikipedia.org/wiki/Read%E2%80%93eval%E2%80%93print_loop) to create some objects and give them functions.  There are lots of 'learn JavaScript' resources out there, but the best way is to start writing your own code rather than just stepping through endless tutorials.


## Stage 2 - Using Javascript to build the thermostat

* Analyse the specification for the thermostat given above and identify the business logic.  We will focus on that first.
* Use the specification to help you plan your Jasmine expectations.
* Using the knowledge learnt in Stage 1, use Jasmine to TDD a set of functions which allow you to create an instance of a thermometer and interact with it.
* Once built, try out your thermostat using the Chrome Console (hint: when you open `SpecRunner.html`, your JavaScript code should be loaded automatically and available in the console).

Resources
---------
* http://jasmine.github.io/


## Stage 3 - Building the interface
* Build a static [HTML](https://github.com/makersacademy/course/blob/master/pills/html.md) page as the user interface for your thermometer (hint: is there a static HTML page already in your project that you could use that as a template?).
* Add JavaScript (and optionally JQuery) to enable your HTML page to interact with your thermostat object.  Think again about separation of concerns.  Where should this new JavaScript/ JQuery code go?

Resources
---------
* https://jquery.com/
* https://learn.jquery.com/
***

## Stage 4 - Using jQuery - write less, do more!
JQuery is a JavaScript framework used extensively for:
  * manipulating the [DOM](https://developer.mozilla.org/en-US/docs/Web/API/Document_Object_Model)
  * handling events. eg. button presses, page loads.
  * making AJAX calls. (more about that later)
All of these tasks can be written in native Javascript, but JQuery makes it much simpler by handling browser compatibility issues and providing a standardized interface.  As the jQuery strapline says: write less, do more!

* Lets amend our HTML page to utilize the power of jQuery.
  * Let's get an [introduction to jQuery] (tjo - new pill? - or include a short list of resources)
  * To use jQuery you either need to download a local copy of jQuery or you need a jQuery CDN in the HTML file. We should use a jQuery CDN. You'll find this on the internet.
  * Create a separate file in your project called `custom.js`- the HTML will need to know about this file in the similar way to it knows about the CDN.
  * Amend your functions written in native javascript to do the same thing but utilising jQuery, the jQuery should be written in the `custom.js` file

See: https://github.com/tansaku/ThermostatBDD for a working example of using both JasmineJQuery fixtures and JQuery's document.ready in combination.

  * Test driven development of the front end? (tjo - not sure of instructions to do this?)

Resources
---------
  * https://github.com/velesin/jasmine-jquery

***

## Stage 5 - Connecting to an existing API
Wouldn't it be good if before setting your thermometer's temperature, you knew what the weather was like outside and then you could set the thermometers interface appropriately?

Additional Specification - add a display to the HTML to display the weather in the current city.

Luckily there are some API's which can provide us with this information. Such as: Open Weather Map: http://openweathermap.org/api

* Use a jQuery AJAX call to get the weather information from this page and display it to the user.
* You may wish to add further functionality to the screen so that the user can enter there current city and the weather provided is for that specific city.

***

## Stage 6 - You got style
* Style your thermostat using [CSS](https://github.com/makersacademy/course/blob/master/pills/css.md).  Go to town and make it look beautiful! - (tjo - Is this learning important at this stage?)

***

## Stage 7
There is an issue with your thermometer interface, if you close your browser and reopen it, it forgets what settings you had. It has no persistency. Over the last couple of weeks how have we managed to retain persistency in our applications with Sinatra?

Storing the thermostat settings allows us to ensure that user commands are not lost and getting the current temperature allows us to display that information to the user and to decide whether to turn the heating on

* Create a remote API that the thermostat can talk to. (hint: you can build your own server to provide a temperature API) (tjo - not sure of sentence here?)
* To store the temperature more permanently, you should set up a Sinatra server to act as an API, then use it to store the current temperature, and retrieve it on page refresh. For example, after every change, the thermostat could make a POST request to localhost:4567/temperature_change, with the new temperature.  On page refresh, the thermostat could make a JQuery getJSON request to localhost:4567/temperature_get to find the remembered status.

Resources
---------
See the video overview of Ajax for how to talk to a remote API with JQuery: https://www.youtube.com/watch?v=QDsrErWpizI










* Split the specifications into those that are specific to the thermostat "engine" and those that are specific to the web interface and those that require interaction with the server.  You can start with either the engine or the interface, but stage 1 is to get the engine and interface working

**Make sure you make some feature tests**

See: https://github.com/tansaku/ThermostatBDD for a working example of using both JasmineJQuery fixtures and JQuery's document.ready in combination.

## Stage 2

* In order to support recording user changes to the thermostat persistently, and to get the current temperature, create a remote API that the thermostat can talk to. Storing the thermostat settings allows us to ensure that user commands are not lost, and getting the current temperature allows us to display that information to the user and to decide whether to turn the heating on (hint, you can build your own server to provide a temperature API) - see the video overview of Ajax for how to talk to a remote API with JQuery: https://www.youtube.com/watch?v=QDsrErWpizI

## Stage 3

* Style your thermostat using CSS.  Go to town and make it look beautiful!

## Stage 4

* Display the weather and temperature for cities around the world (http://weather-api.herokuapp.com/)


Resources
---------

* https://jquery.com/
* https://learn.jquery.com/
* http://jasmine.github.io/
* https://github.com/velesin/jasmine-jquery
