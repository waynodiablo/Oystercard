# Walkthrough - Thermostat: APIs

[Back to the Challenge](../apis.md)

Let's start by experimenting in the console.  You'll need to register for an API key - follow the instructions on the page to obtain one.

According to the documentation, we need to make a call to `http://api.openweathermap.org/data/2.5/weather?q=London,uk&appid=YOURAPIKEY` to get the weather for London. Let's see what that returns in the console, using a basic `$.get` request:

```javascript
// console
$.get('http://api.openweathermap.org/data/2.5/weather?q=London,uk&appid=a3d9eb01d4de82b9b8d0849ef604dbed', function(data) {
  console.log(data);
})
```

If you've read the jQuery docs, you'll see that `$.get()` is shorthand for `$.ajax()`, which in turn is a wrapper around JavaScript's inbuilt `XMLHttp` library. It's unlikely you'll need to write the latter two by hand, but it's good to be aware of what's actually going on under the hood.

Click around the object, and find the temperature - it should be under `main`. However, the temperature seems to be above 270, which doesn't seem right. On further inspection of the API documentation, you can pass an additional parameter to the request to make sure our request returns a metric unit, in this case Celcius:

```javascript
// console
$.get('http://api.openweathermap.org/data/2.5/weather?q=London,uk&appid=a3d9eb01d4de82b9b8d0849ef604dbed&units=metric', function(data) {
  console.log(data.main.temp);
})
```

Now that you have the information that you need, you can put it on the page. Add some HTML to hold the result:

```html
<section>
  <h1>Current temperature: <span id="current-temperature"></span></h1>
</section>
```

And display it on page load:

```javascript
// interface.js, within the $(document).ready(function() { })
$.get('http://api.openweathermap.org/data/2.5/weather?q=London&appid=a3d9eb01d4de82b9b8d0849ef604dbed&units=metric', function(data) {
  $('#current-temperature').text(data.main.temp);
})
```

You now want to load this dynamically, based on the user's selection. One way you can do this is to have a selector with pre-defined cities, and some JavaScript to detect the change:

```html
<section>
  <h1>Current temperature: <span id="current-temperature">20</span></h1>
  <select id="current-city">
    <option value="london">London</option>
    <option value="newyork">New York</option>
    <option value="paris">Paris</option>
    <option value="tokyo">Tokyo</option>
  </select>
</section>
```

```javascript
// interface.js
$('#current-city').change(function() {
  var city = $('#current-city').val();
  $.get('http://api.openweathermap.org/data/2.5/weather?q=' + city + '&appid=a3d9eb01d4de82b9b8d0849ef604dbed&units=metric', function(data) {
    $('#current-temperature').text(data.main.temp)
  })
})
```

Or, you can let the user type in whatever city they want:

```html
<section>
  <h1>Current temperature: <span id="current-temperature">20</span></h1>
  <form id="select-city">
    <input id="current-city" type="text" placeholder="Enter a city"></input>
    <input type="submit"></input>
  </form>
</section>
```

```javascript
// interface.js
$('#select-city').submit(function(event) {
  event.preventDefault();
  var city = $('#current-city').val();
  $.get('http://api.openweathermap.org/data/2.5/weather?q=' + city + '&appid=a3d9eb01d4de82b9b8d0849ef604dbed&units=metric', function(data) {
    $('#current-temperature').text(data.main.temp);
  })
})
```

Either way, that `$.get()` function is looking a bit messy - you can extract it to a function that's a bit clearer:

```javascript
// interface.js
function displayWeather(city) {
 var url = 'http://api.openweathermap.org/data/2.5/weather?q=' + city;
 var token = '&appid=a3d9eb01d4de82b9b8d0849ef604dbed';
 var units = '&units=metric';
 $.get(url + token + units, function(data) {
   $('#current-temperature').text(data.main.temp);
 })
```

And refactor the existing code:

```javascript
// interface.js

displayWeather('London');

$('#select-city').submit(function(event) {
  event.preventDefault();
  var city = $('#current-city').val();
  displayWeather(city);
})

```

[Forward to the Challenge Map](../README.md)
