JQuery Animations
================

[Video of session](https://www.youtube.com/watch?v=SJe72uTUuII)

***Please note, as with all Makers Academy materials, there may be subtle errors in the following materials.  Please try to approach those as challenges on which to polish your debugging skills - pull requests always welcome.***

*Many thanks to [Alex Peattie](https://github.com/alexpeattie) for the design of these walkthroughs*

So we want to add some more fun animations to our RPSLS game.  Let's start off by making the results list items invisible to start with:

```css
    #results li {
      background: #999;
      color: #fff;
      font-size: 24px;
      border-radius: 8px;
      padding: 5px;
      width: 80%;
      margin-bottom: 10px;
      display:none;
    }
```

Then let's use some jQuery animations to get things to appear.  We could try the following:

```javascript
        $('.choices img').on('click',function(){
          sam.picks($(this).data('pick'));
          henry.picks('lizard');
          $('#results').prepend('<li>'+game.winningMessage()+'</li>').fadeIn();
        }); 
```

but unfortunately that won't work - can you work out why? [fadeIn](http://api.jquery.com/fadeIn/) is a valid jQuery method. However it won't do anything in the current location …

The problem is that this way round our fadeIn is being called on the `$('#results')` element, not on the list item that we want it called on.  In order to fix that we need to switch things around (note that there is a subtle error in the following code segment - can you guess what it is?):


```javascript
        $('.choices img').on('click',function(){
          sam.picks($(this).data('pick'));
          henry.picks('lizard');
          $('<li>'+game.winningMessage()+'</li>').prependTo('#results').fadeIn();
        }); 
```

We can in fact use any of a number of [effects from the jQuery api](http://api.jquery.com/category/effects/); such as:

* [slideDown](http://api.jquery.com/slideDown/)
* [slideUp](http://api.jquery.com/slideUp/)
* [fadeOut](http://api.jquery.com/fadeOut/)

Let's also start removing some of the older entries.  Are there some CSS selectors that we can use to grab a particular element from a list?  

There is [nth-child](https://developer.mozilla.org/en-US/docs/Web/CSS/:nth-child), which allows us to do something like this:

```javascript
$('li:nth-child(5)').fadeOut();
```

Be careful, to get the above code to work it will need to be inside the callback of your click event handler :-)  This looks nice but it has a problem which we will see if we look at the console, which is that the list items are being hidden, but they are not disappearing so our HTML document is getting longer and longer.  We can fix this by adding the 'remove' method.

```javascript
$('li:nth-child(5)').fadeOut().remove();
```

This gets rid of the extraneous list items, but unfortunately our animations stop working as well.  This is due to a fundamental difference between Ruby and JavaScript in that when we call methods in Ruby they block until completion.  In JavaScript they run immediately, so we need to use callbacks to ensure that everything that we want to happen, happens.  We achieve that like this:

```javascript
$('li:nth-child(5)').fadeOut(function(){
  $(this).remove();
})
```

So with this we should see in the inspector that the list items are being correctly deleted, and also that the animation is working.  We can also exaggerate the fadeOut like so:

```javascript
$('li:nth-child(5)').fadeOut(3000,function(){
  $(this).remove();
})
```

Another interesting thing to consider is what happens if we put a console.log statement in the following place:

```javascript
      $(document).ready(function(){
        var sam = new Player('Sam');
        var henry = new Player('Henry');
        var game = new Game(sam, henry);

        $('.choices img').on('click',function(){
          sam.picks($(this).data('pick'));
          henry.picks('lizard');
          $('<li>'+game.winningMessage()+'</li>').prependTo('#results').slideDown();
          $('li:nth-child(5)').fadeOut(3000, function(){
            $(this).remove();
          })
          console.log('Hello world')
        }); 

      });
```

This will work, but at what point will see these console messages?  The interesting difference here with Ruby is that the console log operation will run before the remove statement.  This makes dealing with JavaScript more complex to deal with.  You need to write it in such a way that when things are ready they just run.  This makes sense if we think about how things work on complex websites like Facebook where different elements of the site will get started and run independently. 


Exercises
--------

* Use some of these animations in your RPSLS application


Resources
--------

* [underscore.js](http://underscorejs.org/)


![Tracking pixel](https://githubanalytics.herokuapp.com/course/walkthroughs/jquery_animations.md)
