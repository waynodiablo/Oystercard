Spinners & Modals
=================


***Please note, as with all Makers Academy materials, there may be subtle errors in the following materials.  Please try to approach those as challenges on which to polish your debugging skills - pull requests always welcome.***

*Many thanks to [Alex Peattie](https://github.com/alexpeattie) and [Tansaku](https://github.com/tansaku) for the design of this walkthrough*

Let's adjust the simple profile application to ensure that it gives a good user experience even under poor network connectivity, and let's the user know when searches for users have failed or the network connection has timed out.

Here's an example of a message indicating we can't find a particular user:

![user not found](https://www.dropbox.com/s/r4gamssxfj3hgog/Screenshot%202014-12-02%2008.39.45.png?dl=1)

And here's an example of an animated spinner that can be shown to indicate that the network connection is in progress:

![spinner](http://traindaze.com/assets/images/loader.gif)

So we might worry about the user experience when the network connection is slow.  On mac we have a handy tool to simulate that situation.  Open Xcode --> Open developer tools --> More developer tools; there is a package available from Apple called "Hardware IO Tools for Xcode".  We're interested in the network link conditioner.  Let's try the github profile app with a high latency network connection - the user is left hanging.

Let's give the user some indication that the app is still working.  First we'll need a spinner gif; can grab that off Google - then we'll want to drop that into our html like so:

```html
<div class='profile-container'>
  <img src='spinner.gif'>
</div>
```

Let's check that appears.  Now we want that to be hidden by default:

```html
<div class='profile-container'>
  <img src='spinner.gif' class='spinner'>
</div>
```

```css
.spinner {
  display: none;
}
```

Now in our javascript we'll adjust it to that when we start to fetch user information we'll show the spinner:

```javascript
  function addProfileFromUsername(username) {
    $('.spinner').show();
```

and whether or not our network connection has been successful we'll then hide that spinner in the always promise:

```javascript
  .always(function(){
    $('#username').val('');
    $('.spinner').hide();
  })
```

Note that jQuery has these show and hide functions that are directly manipulating the CSS.  We could alternatively use the longer winded:

```javascript
  function addProfileFromUsername(username) {
    $('.spinner').css({display: 'block'});
```

```javascript
  .always(function(){
    $('#username').val('');
    $('.spinner').css({display: 'none'};
  })
```

Can see that these are completely identical by playing with the document elements in the browser console.  Also note that in this case it doesn't matter if we put `$('.spinner').show();` before or after our ajax call because?  … it's an asynchronous call.  Although probably easier for readability to have it first.

A final issue with the basic github profiles is that the current user not found message is in a clunky alert box.  Let's improve on that with a modal error message.  Let's create a div to house that in:

```html
<div class='modal'>
  <h2>User not found!</h2>
  <p>Could not find that User :-(</p>
</div>
```

with some styling

```css
.modal {
  position: absolute;
  width: 300px;
  height: 200px;
  border-radius: 20px;
  border: solid 1px #ccc;
  background: #fff;
}
```

Let's see how that looks …

![first draft](https://www.dropbox.com/s/rao9r7fl7z6opoh/Screenshot%202014-12-03%2014.14.32.png?dl=1)

could use some improvement:

```css
.modal {
  position: absolute;
  width: 300px;
  height: 200px;
  border-radius: 20px;
  border: solid 1px #ccc;
  background: #fff;
  text-align: center;
  top: 40%;
  left: 40%;
}
```

That's a bit better.

![2nd draft](https://www.dropbox.com/s/nkd9uebgrzbirc7/Screenshot%202014-12-03%2014.15.28.png?dl=1)

However we should probably go dynamic for the width and height too so some more tweaking gives us:

```css
.modal {
  position: absolute;
  width: 40%;
  height: 40%;
  border-radius: 20px;
  border: solid 1px #ccc;
  background: #fff;
  text-align: center;
  top: 30%;
  left: 30%;
}
```

which is more responsive to the browser size, but maybe let's change the font too:


```css
.modal {
  position: absolute;
  width: 40%;
  height: 40%;
  height: 200px;
  border-radius: 20px;
  border: solid 1px #ccc;
  background: #eee;
  text-align: center;
  top: 30%;
  left: 30%;
  font-family: Helvetica Neue;
}
```

let's use some css transitions that will make any change that we make look nice and hide it away till we need it:

```css
.modal {
  position: absolute;
  width: 40%;
  height: 40%;
  height: 200px;
  border-radius: 20px;
  border: solid 1px #ccc;
  background: #eee;
  text-align: center;
  top: 30%;
  left: 30%;
  font-family: Helvetica Neue;

  transition: all 1s ease;
  opacity: 0;
  -webkit-transform: scale(0.75);

}
```

Note that the leading hyphen means that this -webkit-transform will only work with newer chrome and safari browsers.  Let's also have another class for the modal when it is displayed:

```css
.modal.shown {
  display: block;
  opacity: 1;
  -webkit-transform: scale(1);
}
```

We can use the inspector to ensure that the additional class has the effect that we hoped, and then we can use jQuery to display the modal when an error occurs:

```javascript
.error(function(){
  $('.modal').addClass('shown');
})
```

Can also then add a close button and some javascript to remove it:


```javascript
$('.modal .close').on('click',function(){
  $('.modal').removeClass('shown');
})
```

Note that the modal will appear over other profiles and we can adjust that using the `z-index` css property.


Exercises:
------

* Get your Github Profile app ready for poor network conditions
* Get a nice modal error message
* Change the profile to display information relevant to Makers Academy such as commits on projects and challenges

Footnotes:
------

* Could be setting a default image in the method if we wanted
* Could turn off the autocomplete on the form we could just of that in html with `autocomplete='off'`.

Resources:
------

* [Video Sam on Spinners and Modals](https://www.youtube.com/watch?v=xE2K-Tlzqi8)


![Tracking pixel](https://githubanalytics.herokuapp.com/course/further_javascript/deprecated/ajax/ajax_jquery_spinners.md)
