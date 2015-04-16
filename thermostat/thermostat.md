# JavaScript: Thermostat interface

This week we're looking at JavaScript, a very important language, since it is the only language that runs natively in client browsers.  It can also run on the server side, but as the de-facto client language it is hugely important.  Designed in 10 days in the 1990's by Brendan Eich since "if I didn't design it in less than 10 days, something much worse than JavaScript would have happened", JavaScript is a somewhat querky language that combines various elements from different existing languages, and has both great power and some dangerous pitfalls.

Do check out the [Learning Objectives for this week](learning_objectives.md)

To get started learning JavaScript please work through the [JavaScript & Jasmine Pill](../pills/javascript&JasminePill.md).

The project this week is to create a simple interface for a digital thermostat, using JavaScript, jQuery and Jasmine.  

![Thermostat](../images/thermostat.png)

Use the specifications below (hint: this could help you plan your Jasmine expectations).

### Specifications

- Thermostat starts at 20 degrees
- You can increase the temp with the up button
- You can decrease the temp with the down button
- The minimum temperature is 10 degrees
- If power saving mode is on, the maximum temperature is 25 degrees
- If power saving mode is off, the maximum temperature is 32 degrees
- Power saving mode is on by default
- You can reset the temperature to 20 by hitting  the reset button
- The thermostat should color the display based on energy usage - < 18 is green, < 25 is yellow, otherwise red
- After every temperature change, the thermostat makes a POST request to localhost:4567/temperature_change, with the new temperature

## Stage 1

Split the specifications into those that are specific to the thermostat "engine" and those that are specific to the web interface and those that require interaction with the server.  You can start with either the engine or the interface, but stage 1 is to get the engine and interface working

**Make sure you make some feature tests**

See: https://github.com/tansaku/ThermostatBDD  and note you may need to use an older version of jQuery to have the tests play well with the document.ready operation: load jquery fro this CDN rather than locally --> https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js (good catch James Miller!)

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
