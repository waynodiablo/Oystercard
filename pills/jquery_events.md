# jQuery - Handling events

jQuery is a useful tool when we want to handle **events** happening on our page. Events usually relate to some kind of user interaction - clicking a button, filling in a form, scrolling the page are all examples of events.

Let's start off with some simple HTML:

```html
<ul class='items'>
    <li>Item 1</li>
    <li>Item 2</li>
    <li>Item 3</li>
</ul>
<button id='add'>Click Me</button>
```

We can select the button, using its ID (`add`). We'll hide the button to check we're grabbing it correctly:

```javascript
$(document).ready(function(){
  $('#add').hide();
});
```

Our button has disappeared. See in in action here: http://jsfiddle.net/2FQr4/

Now let's actually try to react to an event - in this case, let's do something when the button is clicked.

To set up an event handler we'll use a jQuery method called `on`. We'll usually pass one argument to `on` the name of the event we want to react to - in this case we're reacting to a `click`. We'll also pass an anonymous function (i.e. the equivalent of a block), to our page to know what action to take when the event occurs - 

```javascript```
$('#add').on('click', function() {
  alert('Hello');
});
```

See it action here: http://jsfiddle.net/ZRSd7/

### Using `this`

Sometimes we'll want to do something based on the thing that the user interacted with (e.g. the button the user just clicked). We can use the `this` keyword to grab the element relevant to the event -

$('#add').on('click', function() {
  alert($(this).text());
});

Now when we click the button, our browser will pop-up the button's text (i.e. "Click Me"). See it action here - http://jsfiddle.net/PDcGQ/

### Creating elements

jQuery is also a great help when we want to dynamically add elements to the page. Let's add a new list item whenever the user clicks our button.

```javascript
$('#add').on('click', function() {
  var $newItem = $('<li>New item</li>')
  $newItem.appendTo('.items');
});
```

See it action here - http://jsfiddle.net/A7F5M/

On line 2 we create a new `<li>` element, but initially it will just exist in memory - and won't appear on the page. It's not until line 3, when we append the element that it will appear (inside the `<ul>` with the class `items`). We could also use `prependTo` if we wanted the item added to the beginning of the list.

Let's add one last piece of functionality - the ability to click on a list item to remove it from the list.

### Removing elements

Let's add a new click handler for the `<li>` elements:

```javascript
$('li').on('click', function() {
  alert('You clicked an item in the list!');
});
```

Now, instead of the alert, let's destroy the element, using jQuery's `remove` method:

```javascript
$('li').on('click', function() {
  $(this).remove();
});
```

Notice how we use `$(this)` to target the item we just clicked on.

See the code in action here - http://jsfiddle.net/wzRRS/. But look out, there's a problem with the functionality. See if you can spot it...

### Adding event handlers to dynamically created elements

The problem is that while our original list items have the correct behaviour (they're removed when the user clicks them), the ones we dynamically create by clicking the button don't. That's because our 'click handler', runs once when the document is ready, grabs all the `<li>` elements that currently exist, and adds the behaviour:

```javascript
// Only targets the <li>s on the page when this code runs
$('li').on('click', function() {
  $(this).remove();
});
```

So when we add new `<li>` elements, they don't know to behave in the same way.

There's a way around this. Any time we need to add behaviour to elements that are dynamically created, we need to nominate a responsible parent. A responsible parent is an object further up the DOM tree (in other words a container of the element we care about), that we know isn't going to come and go.

Every element lives inside our `<body>` tag, so we can always use body as our responsible parent. But if there's a closer parent element, which makes more sense, use that - in our case we can use our `<ul>` (with the class `items`) as our responsible parent.

Instead of calling the `on` method on our `<li>` elements, we'll instead call it on `.items`:

```javascript
$('.items').on
```

Then, we'll pass our `li` selector as a second argument -

```javascript
$('.items').on('click', 'li', function() {
```

This is telling our `ul.items` to watch out for any clicks on any of its children `<li>`s - whether dynamically created or not. Our final code looks like this:

```javascript
$(document).ready(function() {
    $('#add').on('click', function() {
      var $newItem = $('<li>New item</li>')
      $newItem.appendTo('.items');
    });
    
    $('.items').on('click', 'li', function() {
      $(this).remove();
    });
});
```

See it in action here - http://jsfiddle.net/2yySD/

## Resources

* [jQuery events](http://jqfundamentals.com/chapter/events) - Chapter from jQuery fundamentals
* [`.on` method](http://api.jquery.com/on/) - jQuery official docs
* [Comparison between jQuery and simple JavaScript](http://youmightnotneedjquery.com/)


![Tracking pixel](https://githubanalytics.herokuapp.com/course/pills/jquery_events.md)
