# Saving state
There is an issue with your thermometer interface!  If you close your browser and reopen it, it forgets what settings you had. It has no persistence. Over the last couple of weeks how have we managed persistence in our applications?

* Create a remote API that the thermostat can talk to. (hint: you can build your own web server to provide this API using Sinatra!).
* Update your UI so that the thermostat communicates changes to the API. For example, it could make a POST request to localhost:4567/temperature, with the new temperature.  On page refresh, the thermostat could make a GET request to localhost:4567/temperature to get the temperature.
* Save the selected city information using the API too.

#### Resources
See the video overview of Ajax for how to talk to a remote API with jQuery: https://www.youtube.com/watch?v=QDsrErWpizI
