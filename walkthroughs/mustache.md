Mustache
=======

[Video of Session](https://www.youtube.com/watch?v=-Jgx_DllzQg)

***Please note, as with all Makers Academy materials, there may be subtle errors in the following materials.  Please try to approach those as challenges on which to polish your debugging skills - pull requests always welcome.***

At the moment the code from the RPSLS is pretty simple, but we are mixing up html strings and javascript code which is a design smell that we should stamp out.  Exactly the same is true for our erb views in ruby.  They can have little snippets referring to instance variables, but they should not include extensive control flow with multiple method calls.  Any extensive programming activity should be pulled out of views and into models and services.  This is true generally.  Of course for getting a little something working you can bend that rule, but the longer you are out of line with the practice the harder things will get.  Let's take a look at JavaScript templating; the equivalent of Ruby ERBs to see how we can remove this design smell from the RPSLS app.

At the moment the code looks like this:

```javascript
      $(document).ready(function(){
        var sam = new Player('Sam');
        var henry = new Player('Henry');
        var game = new Game(sam, henry);

        $('.choices img').on('click',function(){
          sam.picks($(this).data('pick'));
          henry.picks('lizard');
          $('<li>' + game.winningMessage()+'</li>').prependTo('#results').slideDown();
          $('li:nth-child(5)').fadeOut(3000,function(){
            $(this).remove();
          }); 
        }); 

      });
````

Notice how we are creating an HTML element on the fly out of this string:  `'<li>' + game.winningMessage()+'</li>'`.  It's not too bad now, but it could get out of hand - let's take a look at how we can use a template to clean this up.  We'll use the Mustache templating system:

http://mustache.github.io/

As usual in order to start using a remote library we'll need to add a script tag:


```html
<script src='http://cdnjs.cloudflare.com/ajax/libs/mustache.js/0.8.1/mustache.min.js'></script>
```

Now let's add a template to our html:

```html
    <template id='list-item-template'>
      <li>{{ message }}</li>
    </template>
```

And let's change the code to use the Mustache render operation to merge some data with the template


The final version of our code looks like this:

```javascript
      $(document).ready(function(){
        var sam = new Player('Sam');
        var henry = new Player('Henry');
        var game = new Game(sam, henry);

        $('.choices img').on('click',function(){
          sam.picks($(this).data('pick'));
          henry.picks('lizard');
          var rendered = Mustache.render($('#list-item-template').html(),{message: game.winningMessage()});
          $(rendered).prependTo('#results').slideDown();
          $('li:nth-child(5)').fadeOut(3000,function(){
            $(this).remove();
          }); 
        }); 

      });
```

it's getting a bit long so we can also consider some refactoring

```javascript
      $(document).ready(function(){
        var remove = function(){
          $(this).remove();
        };
        var render = function(game){
          var html = $('#list-item-template').html();
          var data = {message: game.winningMessage()}
          return Mustache.render(html,data);
        };
        var sam = new Player('Sam');
        var henry = new Player('Henry');
        var game = new Game(sam, henry);

        $('.choices img').on('click',function(){
          sam.picks($(this).data('pick'));
          henry.picks('lizard');
          $(render(game)).prependTo('#results').slideDown();
          $('li:nth-child(5)').fadeOut(3000,remove); 
        }); 

      });
```

Exercises:
---------

* Get moustache templating working in your RPSLS project
* Try refactoring your code to use named functions


Footnote:
---------

To ensure that templates are not displayed in browsers like Safari we can use the following css

```css
template {
  display: none:
}
```


![Tracking pixel](https://githubanalytics.herokuapp.com/course/walkthroughs/mustache.md)
