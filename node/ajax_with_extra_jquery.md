More Ajax
---------


***Please note, as with all Makers Academy materials, there may be subtle errors in the following materials.  Please try to approach those as challenges on which to polish your debugging skills - pull requests always welcome.***

*Many thanks to [Alex Peattie](https://github.com/alexpeattie) for the design of this walkthrough*

So currently we are hard coded to loading a particular profile:

```javascript
      $(document).ready(function(){
        $.get('https://api.github.com/users/tansaku', function(user){
          var newProfile = Mustache.render($('#profile-template').html(), user);
          $('.profile-container').append(newProfile);
        })
      });
```

We want to fix that, but let's start off by extracting a method:

```javascript
      function addProfileFromUsername(username){
        $.get('https://api.github.com/users/'+ username, function(user){
          var newProfile = Mustache.render($('#profile-template').html(), user);
          $('.profile-container').append(newProfile);
        })
      }
      $(document).ready(function(){

      });
```

So now we want to have this function called when we fill in our 'add_profile' form.  How might we do this?

We could try an on('submit') event listener on the form, but one issue we'll have is that HTML forms have default actions that will refresh the page which we don't want in this case so we'll need to suppress that.  Let's see how we do that:

```javascript
      function addProfileFromUsername(username){
        $.get('https://api.github.com/users/'+ username, function(user){
          var newProfile = Mustache.render($('#profile-template').html(), user);
          $('.profile-container').append(newProfile);
        });
      }
      $(document).ready(function(){
        $('#add_profile').on('submit', function(event)){
          event.preventDefault();
          addProfileFromUsername($('#username').val());
        });
      });
```

This `event.preventDefault()` statement will prevent the page refresh from taking place, and the `$('#username').val()` will grab whatever the user has typed into the form.  We can also go ahead and add some animations like so:

 ```javascript
      function addProfileFromUsername(username){
        $.get('https://api.github.com/users/'+ username, function(user){
          var newProfile = Mustache.render($('#profile-template').html(), user);
          $(newProfile).appendTo('.profile-container').slideDown();
        });
      }
      $(document).ready(function(){
        $('#add_profile').on('submit', function(event)){
          event.preventDefault();
          addProfileFromUsername($('#username').val());
        });
      });
```

Note that currently if our user types in a username that does not match any Github user then they will see nothing.  If we look in the console we'll see a 404 (Not found) error being returned by Github, but the user won't know anything about it and may just think that our app is broken.  Ideally we should communicate what has happened to the user and we can do that my using a powerful feature of JavaScript which is the ability to attach multiple callbacks to an event handler.  In the code above we are specifying a callback for success.  We can also add a callback for errors like so:


 ```javascript
      function addProfileFromUsername(username){
        $.get('https://api.github.com/users/'+ username, function(user){
          var newProfile = Mustache.render($('#profile-template').html(), user);
          $(newProfile).appendTo('.profile-container').slideDown();
        }).error(function(){
          alert('No such user with the username: ' + username);
        });
      }
      $(document).ready(function(){
        $('#add_profile').on('submit', function(event)){
          event.preventDefault();
          addProfileFromUsername($('#username').val());
        });
      });
```

The code above now gives the user some indication about what happens.  Another thing that we might want to change in the current system is to reset the text box so that we don't have to clear out the old username in order to type a new one and we can do that using an 'always' method using the [Promises](https://github.com/makersacademy/course/blob/master/pills/js_promises.md) interface on jQuery [Deferred objects](http://api.jquery.com/category/deferred-object/):

 ```javascript
      function addProfileFromUsername(username){
        $.get('https://api.github.com/users/'+ username, function(user){
          var newProfile = Mustache.render($('#profile-template').html(), user);
          $(newProfile).appendTo('.profile-container').slideDown();
        }).error(function(){
          alert('No such user with the username: ' + username);
        }).always(function(){
          $('#username').val('');
        });
      }
      $(document).ready(function(){
        $('#add_profile').on('submit', function(event)){
          event.preventDefault();
          addProfileFromUsername($('#username').val());
        });
      });
```

Although one might argue that clearing it out might not be the best user experience. What do you think?

Also note that we could be doing network request on every 'keyDown' event, not just when the user clicks submit and this is the kind of thing that is happening on pages when you get suggested completions or conflicts from a very large dataset, such as Github telling us that a user name is taken.  If we open the network inspector when we do such a thing we can see the ajax requests taking place in the background.

Another bit of functionality that we might want is the ability to remove some of the profiles we've pulled down by clicking on a little x in the corner.  Let's add that to the HTML template:

```html
    <template id='profile-template'>
      <div class="profile">
        <div class="left">
          <img src="{{ avatar_url }}">
        </div>

        <div class="right">
          <h3>
            <a href="{{ html_url }}">
              {{ login }}
            </a>
          </h3>
          <h4>Repos: {{ public_repos }}</h4>
          <h4>Followers: {{ followers }}</h4>
        </div>
        <a class='close' href='#'>✖</a>
        <br clear="all">
      </div>
    </template>
```


We might well try to implement profile closing by adding another event listener like so:


 ```javascript
      $(document).ready(function(){
        $('#add_profile').on('submit', function(event)){
          event.preventDefault();
          addProfileFromUsername($('#username').val());
        });
        $('.close').on('click', function(){
          alert('Close button clicked');
        });
      });
```

Ironically this doesn't work.  Any ideas why?

Sensibly we could look at the console, however it doesn't show us any errors in this situation.  This is a more complicated issue to fix, which is that when we ran the `$('.close').on('click', …` operation none of the profile elements existed on the page.  One solution is that we could always run this each time that new profiles are loaded like so:

 ```javascript
      function addProfileFromUsername(username){
        $.get('https://api.github.com/users/'+ username, function(user){
          var newProfile = Mustache.render($('#profile-template').html(), user);
          $(newProfile).appendTo('.profile-container').slideDown();
          $('.close').on('click', function(){
            alert('Close button clicked');
          });
        }).error(function(){
          alert('No such user with the username: ' + username);
        }).always({
          $('#username').val('');
        })
      }
```

but that creates the problem that when we have loaded multiple profiles each click generates multiple events.  This is because that the `$('.close').on('click', …` operation adds an event handler callback to every .close element on the page, and if we re-run it then we add an extra event handler; so older elements end up with more and more callbacks.

The solution here is to set up some delegation - we need to identify a responsible parent, an element that is always going to be on the page.  We could use the body element, since that will always be there, but in this case we can perhaps use the profile-container element, since that seems like it will always be there and will create slightly more readable code:

```javascript
      $(document).ready(function(){
        $('#add_profile').on('submit', function(event)){
          event.preventDefault();
          addProfileFromUsername($('#username').val());
        });
        $('.profile-container').on('click', '.close', function(){
          alert('Close button clicked');
        });
      });
```

This now allows us to ensure there is a single event.  However at present the functionality is not complete - we need to actually remove the element.  We can use the inspector to check the parent child relationship (or inheritance chain) between the different elements, and note that the profile container is the parent of the hyperlink with class 'close', which allows us to determine what we should delete relative to the item that received the click event:

```javascript
      $(document).ready(function(){
        $('#add_profile').on('submit', function(event)){
          event.preventDefault();
          addProfileFromUsername($('#username').val());
        });
        $('.profile-container').on('click', '.close', function(){
          $(this).parent().remove();
        });
      });
```

and we can of course add the usual jQuery animation:

```javascript
      $(document).ready(function(){
        $('#add_profile').on('submit', function(event)){
          event.preventDefault();
          addProfileFromUsername($('#username').val());
        });
        $('.profile-container').on('click', '.close', function(){
          $(this).parent.slideUp(function(){
            $(this).remove();
          });
        });
      });
```

Note that if we now change the DOM inheritance hierarchy (e.g. placing the x hyperlink in a div) we now break our code, and one good practice way round this is to use the closest method and specify a selector:

```javascript
      $(document).ready(function(){
        $('#add_profile').on('submit', function(event)){
          event.preventDefault();
          addProfileFromUsername($('#username').val());
        });
        $('.profile-container').on('click', '.close', function(){
          $(this).closest('.profile').slideUp(function(){
            $(this).remove();
          });
        });
      });
```

This will now be robust to changes in the inheritance chain since `closest` will work back up through the chain looking for an element with the appropriate css selector.

Our github profile app is now pretty functional.  One thing we might like to add is to have some real time update of data.  Not so important for Github profiles perhaps, but if we were dealing with displaying train times or some other regularly changing data we might want to have these Ajax requests being sent with some interval.  JavaScript has the [setInterval function](https://developer.mozilla.org/en-US/docs/Web/API/WindowTimers.setInterval) that can be used here.  This does have the downside of repeatedly hitting the server, an issue that we'll see how to resolve with more recent technologies such as websockets.

In the meantime you should get really comfortable using the network element of the inspector to watch Ajax requests going back and forth.


Resources:
---------

* [Video of Sam on Ajax with Extra JQuery](https://www.youtube.com/watch?v=pp1b4FqcNGA)
