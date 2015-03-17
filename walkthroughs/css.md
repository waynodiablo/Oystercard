CSS
====

:construction: UNDER CONSTRUCTION :construction:

[TODO: SUMMARY OF KEY CONCEPTS AT BEGINNING AND END OF ALL WALKTHROUGHS/PILLS]
[TODO: MORE IMAGES/VIDEOS FOR THIS WALKTHROUGH]

[Video of Session](https://www.youtube.com/watch?v=TgdlgJeHRv8)

***Please note, as with all Makers Academy materials, there may be subtle errors in the following materials.  Please try to approach those as challenges on which to polish your debugging skills - pull requests always welcome.***

*Many thanks to [Alex Peattie](https://github.com/alexpeattie) for the design of this walkthrough*


Let's try and recreate the Github home page with CSS styles:

![Github Landing Page](https://www.dropbox.com/s/0qwcl6zfnr2sbw7/Screenshot%202014-12-02%2016.47.31.png?dl=1)

We're not going to worry about functionality, but let's make it responsive and add some nice features like expanding input fields.  Let's start with an empty shell like this:

```html
<!doctype>
<html>
  <head>
    <title>Github Landing Page</title>
    <style>
    </style>
  </head>
  <body>

  </body>
</html>
```

To start with we should focus on getting some sort of overall feel for the site, perhaps staring with the top component.  In the ideal world the HTML is pure content and all the style is in CSS, and so that can be changed out for different styles.  Perfect separation can be difficult to achieve, but let's do our best.  So starting with the top it seems like we could use a header element:

```html
<!doctype>
<html>
  <head>
    <title>Github Landing Page</title>
    <style>
    </style>
  </head>
  <body>
    <header>
      <img class='github-logo'>
      <form class='search'>
        <input type='text' class='query'>
      </form>
   </header>

  </body>
</html>
```

alex tends to use classes rather than ids for flexibility.  Let's go on and add a nav bar and a sign in button:

```html
  <body>
    <header>
      <img class='github-logo'>
      <form class='search'>
        <input type='text' class='query'>
      </form>
      <nav>
        <a href='#'>Explore</a>
        <a href='#'>Features</a>
        <a href='#'>Enterprise</a>
        <a href='#'>Blog</a>
      </nav>

      <button>Sign in</button>
   </header>
  </body>
```

What about the big black area below?  We could use a div tag, but perhaps section is more semantic:

```html
  <body>
    <header>
      <img class='github-logo'>
      <form class='search'>
        <input type='text' class='query'>
      </form>
      <nav>
        <a href='#'>Explore</a>
        <a href='#'>Features</a>
        <a href='#'>Enterprise</a>
        <a href='#'>Blog</a>
      </nav>

      <button>Sign in</button>
   </header>

   <section class='intro'>
     <article class='blurb'>
       <h1>Build software better, together.</h1>
       <p>Powerful collaboration, code review and code management for open source and private projects.  Need private repositories?</p>
       <a href='#'>
         Upgraded plans start at $7/mo.
       </a>
     </article>
   </section>
  </body>
```

Purely thinking about HTML at the moment, not thinking about styling at all.  Now we could add a signup area on the right hand side:

```html
  <body>
    <header>
      <img class='github-logo'>
      <form class='search'>
        <input type='text' class='query'>
      </form>
      <nav>
        <a href='#'>Explore</a>
        <a href='#'>Features</a>
        <a href='#'>Enterprise</a>
        <a href='#'>Blog</a>
      </nav>

      <button>Sign in</button>
   </header>

   <section class='intro'>
     <article class='blurb'>
       <h1>Build software better, together.</h1>
       <p>Powerful collaboration, code review and code management for open source and private projects.  Need private repositories?</p>
       <a href='#'>
         Upgraded plans start at $7/mo.
       </a>
     </article>

     <article class='sign-up'>
       <form>
         <input type='text' name='username'>
         <input type='text' name='email'>
         <input type='text' name='password'>
        
         <p>Use at least one lowercase letter, one numeral, and seven characters.</p>

         <button type='submit'>Sign up for Github</button>

         <p>By clicking "Sign up for Github", you agree to our terms of service and privacy policy.</p>
       </form>
     </article>
   </section>
  </body>
```

So now we can take a look at our basic site and compare it to the Github landing page.  Can you spot the difference? :-)

Now let's start blocking out some different part of the page; the header seems like a good place to start.

```html
<!doctype>
<html>
  <head>
    <title>Github Landing Page</title>
    <style>
      header {
        background: yellow;
      }
    </style>
  </head>
  <body>

  </body>
</html>
```

This allows us to pick out the header and see some initial issues related to the browser default styles - in the inspector we can quickly see that there is a default margin of 8 on the body:

![default margin](https://www.dropbox.com/s/jkb0roosab7pvry/Screenshot%202014-12-02%2017.04.51.png?dl=1)

which prevents our header from being flush with the edge of the browser.  We can override these defaults like so:

```html
<!doctype>
<html>
  <head>
    <title>Github Landing Page</title>
    <style>
      body {
        margin: 0;
      }
      header {
        background: yellow;
      }
    </style>
  </head>
  <body>

  </body>
</html>
```

There are some browser reset techniques but we can also just override things on a case by case basis.

One of the trickiest things in CSS is getting things to be next to each other. Here we want a form on the left logo on the right and search on the XXX.  For the moment let's throw things in to give some left and right styles, although we should usually avoid that.



```html
  <head>
    <title>Github Landing Page</title>
    <style>
      body {
        margin: 0;
      }
      header {
        background: yellow;
      }

      .left {
        float: left;
      }

      .right {
        float: right;
      }
    </style>
  </head>
  <body>
    <header>
      <article class='left'>
        <img class='github-logo'>
        <form class='search'>
          <input type='text' class='query'>
        </form>
      </article>

      <article class='right'>
        <nav>
          <a href='#'>Explore</a>
          <a href='#'>Features</a>
          <a href='#'>Enterprise</a>
          <a href='#'>Blog</a>
        </nav>

        <button>Sign in</button>
      </article>
   </header>

   <section class='intro'>
     <article class='blurb'>
       <h1>Build software better, together.</h1>
       <p>Powerful collaboration, code review and code management for open source and private projects.  Need private repositories?</p>
       <a href='#'>
         Upgraded plans start at $7/mo.
       </a>
     </article>

     <article class='sign-up'>
       <form>
         <input type='text' name='username'>
         <input type='text' name='email'>
         <input type='text' name='password'>
        
         <p>Use at least one lowercase letter, one numeral, and seven characters.</p>

         <button type='submit'>Sign up for Github</button>

         <p>By clicking "Sign up for Github", you agree to our terms of service and privacy policy.</p>
       </form>
     </article>
   </section>
  </body>
```

and this sort of works-ish:

![floating images](https://www.dropbox.com/s/6mfy76bhfuvwziv/Screenshot%202014-12-03%2006.32.56.png?dl=1)

The form is now on the left and the sign in stuff is on the right.  However weird things have happened as well - we can't see the yellow of the header any more, and that's because the height of the header has gone down to zero, which we can confirm if we mouse over the header:

![zero pixel header](https://www.dropbox.com/s/4ihyqv3xhvq3prk/Screenshot%202014-12-03%2006.36.46.png?dl=1)

This is because as soon as we start floating things CSS goes into the mode of wanting to stick everything next to each other.  It goes from the default everything underneath each other to everything next to each other which is why our header text is next to the search bar now.  In order to break things out of the float mode we need to use the `<br clear='all'>` tag.  Let's put that at the end of the header:

```html
    <header>
      <article class='left'>
        <img class='github-logo'>
        <form class='search'>
          <input type='text' class='query'>
        </form>
      </article>

      <article class='right'>
        <nav>
          <a href='#'>Explore</a>
          <a href='#'>Features</a>
          <a href='#'>Enterprise</a>
          <a href='#'>Blog</a>
        </nav>

        <button>Sign in</button>
      </article>
      <br clear='all'>
   </header>
```

This should get us back to things being stacked vertically, rather than horizontally, and it will calculate the height of the things floated so far for vertical stacking.  Adding that in allows us to see the yellow of the header again.  It's not ideal that we're adjusting our styling through HTML elements.  A preferred solution is that we could give our left and right elements widths and set their display to inline-block


```css
      body {
        margin: 0;
      }
      header {
        background: yellow;
      }

      .left {
        display: inline-block;
      }

      .right {
        display: inline-block;
      }
```

and then we can remove the `<br clear='all'>` and still see the header.  Inline block is halfway between block and inline.  Inline elements are things like words in a sentence in that they don't need any extra space or push other things away whereas blocks will take up a whole row unto themselves.  An inline-block will take up the minimum amount of space necessary and still do things like have a margin and padding and so on.  So they still act like normal divs, but don't take up so much space so we can put them in a row together.

[show turning inline-block on and off in the browser inspector]

What's more difficult is getting elements to stick to the other side of the window using inline block. We can push them across by increasing the width of the inline-block item, but the new preferred way of doing this kind of thing is using flex-box, which is a new technology:

http://css-tricks.com/snippets/css/a-guide-to-flexbox

The article above is a good summary of the different properties of flex-box and how it works.  It's about getting elements to go side by side simply and easily.  Let's see how we might use it.


```css
      body {
        margin: 0;
      }
      header {
        display: flex;
        background: yellow;
      }

      .left {
        flex: 1 65%;
      }

      .right {
        flex: 1 35%;
      }
```

This display type of flex is expecting that we'll have flexibility of how things sit in rows and columns.  Flex is not supported by all browsers yet, but that should change.  The flex CSS above gives us a nice solution to have groups of items on one side or the other of a row.

It is quite widely supported, with lots of nice features and it's very flexible.

The '1's are dictating the behaviour around elements growing.  The 1 means that the element will grow to fill up any available space.  It can either be a 0 or 1 and 1 is greedy and 0 is shy about taking up any available space not specified in the percentages.  This gets round the common problem in CSS is that it's difficult to get rid of space that is hanging around.  Flexbox deals with this and thus has a big advantage over simple floating or inline-blocks.

This should allow the whole page to scale more responsively.

Moving on we'd like the sign in button to be nestled up to the  ...



```css
      body {
        margin: 0;
      }
      header {
        display: flex;
        background: yellow;
      }

      .left {
        flex: 1 65%;
      }

      .right {
        flex: 1 35%;
      }

      .right nav, .right button{
        flex: auto;
      }
```

Putting auto in here will automatically spread out the nav and button items.  We don't currently care about special widths for these items - just keep your normal widths, but stay in a row with each other.  

Our page layout is now starting to look a bit more like the Github landing page, but to move on one critical thing we will need is a logo.  Let's grab that logo image and download that so we can use that.


```html
    <header>
      <article class='left'>
        <img class='github-logo' src='http://github.com/logo'>
        <form class='search'>
          <input type='text' class='query'>
        </form>
      </article>

      <article class='right'>
        <nav>
          <a href='#'>Explore</a>
          <a href='#'>Features</a>
          <a href='#'>Enterprise</a>
          <a href='#'>Blog</a>
        </nav>

        <button>Sign in</button>
      </article>
      <br clear='all'>
   </header>
```

and let's add some styling on the github logo to fix it's width [can inspect element on original landing page to see what size things should be]:


```css
      body {
        margin: 0;
      }
      header {
        display: flex;
        background: yellow;
      }

      .github-logo {
        width: 90px;
      }

      .left {
        flex: 1 65%;
      }

      .right {
        flex: 1 35%;
      }

      .right nav, .right button{
        flex: auto;
      }
```

The height of the header is just dictated by the height of the largest element, which can be overridden.  Let's get the search form inline with the the logo:

```css
      body {
        margin: 0;
      }
      header {
        display: flex;
        background: yellow;
      }

      .github-logo {
        width: 90px;
      }

      .search {
        display: inline;
      }

      .left {
        flex: 1 65%;
      }

      .right {
        flex: 1 35%;
      }

      .right nav, .right button{
        flex: auto;
      }
```

This is starting to a look a more like the Github nav bar - clearly there are more tweaks to be made but we're just blocking out the overall layout at the moment so let's move on to the 'intro' area.  Let's give that a red background so we can see where it is.

```css
      .intro {
        background: red;
      }
```

Checking in it seems like we need a flexible layout and some styling on the blurb:

```css
      .intro {
        background: red;
        display: flex;
      }

      .blurb {
        flex: 60%;
      }

      .sign-up {
        flex: 40%;
      }
```

Would like the text inputs on the right hand side to be greedy and take up the whole width of the block.  Let's make that display block and have them take up 100%

```css
    .sign-up input[type=text] {
      display: block;
      width: 100%;
    }
```

So this isn't perfect but it's starting to look like something we want.  Trying to move forward let's set the height of this header to 68pixels as we can see it is from inspecting the real Github landing page.

```css
  header {
    display: flex;
    background: yellow;
    height: 68px;
  }
```

[flip back and forth between original and our copy to see how the comparison is coming along]

We can inspect and see the precise margin, particularly using the 'computed' view.  We might add some margin, but then we end up with the wrong height - we can use math to fix this, but an alternative is to adjust the box-sizing like so:

```css
* {
  box-sizing:border-box 
}
```

which makes things more intuitive - definitely check out the article by Paul Irish on box sizing border box, and he recommends doing this everywhere, so that heights are respected margins included.  Let's add a bit of padding to the sides as well:

```css
  header {
    display: flex;
    background: yellow;
    height: 68px;
    padding: 15px 15px;
  }
```

You might think that as we increase the padding that we would need to adjust the font size to cope, but usually the browser will ensure that the content is displayed. In this situation the content is said to be overflowing the div.  We can set the overflow to be hidden, but we want to try and avoid overflow if we can.

We're getting closer now, but we still might need to be tweaking here and there to get pixel perfection e.g. margin-top: 2px; here or there - using the chrome inspector to play with spacing.  Note we can hit up or down cursors when we've highlighted pixel numbers to shift things around; and by holding down shift or alt we can increment in units of 10 or 0.1 respectively.

[Alex using sub-pixel rendering for animation on his website]

Note we can use the RGB numbers to control the colours of items so we can get a red 'f00', a green '0f0' and a blue '00f' or we can mix all three to get black 'fff' or none of all three to get white (?) or middling to get grey 'ccc'

Margin controls space around the element and padding controls space inside the element.

```css
.query {
  margin-left: 25px;
  padding: 10px;
  border-radius: 5px;
  border: solid 1px #ddd;
  width: 200px;
  font-size: 13px;
}
```


We also need a placeholder:

```html
<input type='text' class='query' placeholder='Search or type a command'>
```

and let's use the same font as Github uses.  We can use the computed tab in the inspector again in order to work out the precise font - the computed tab has all the properties in alphabetical order so w can find the Github font easily:

```css
  body {
    margin: 0;
    font-family: 'Helvetica, arial, free sans, clean, sans-serif'
  }
```

so we'd like to have a different styling when our cursor is inside the text box.  We could use 'hover' for that:

```css
  .query:hover {
    width: 400px;
  }
```

This sort of works, but it's not actually expanding when the cursor is inside the box, it's when we move over it, so to get the effect that Github is using we should use a different action which is 'focus':

```css
  .query:focus {
    width: 400px;
  }
```

which is more like the effect we want, but it's not very smooth, so we can use a transition to help there:


```css
.query {
  margin-left: 25px;
  padding: 10px;
  border-radius: 5px;
  border: solid 1px #ddd;
  width: 200px;
  font-size: 13px;
  transition: all 1s ease;
}
```

To follow best practices here we should set this transition to operate only on the width:

```css
.query {
  margin-left: 25px;
  padding: 10px;
  border-radius: 5px;
  border: solid 1px #ddd;
  width: 200px;
  font-size: 13px;
  transition: width 0.5s ease;
}
```

This animation now matches the Github site reasonably well.  Now let's adjust the nav bar a bit


Note the Chrome allows us to write new rule to affect whatever we like.  The '+' button will create a blank style for us to insert, e.g. 

```css
nav a {
  margin: 5px
}
```

which we can then play with to adjust the relative positions of all the navbar links. Once we've got things looking how we want them we can copy and paste the style from the inspector into our CSS file:

```css
nav a {
  margin: 5px
  font-family: Helvetica;
  font-size: 13px;
  font-weight: bold;
  text-decoration: none;
  color: #000;
}
```

Note that we have to work hard to ensure that our CSS file will stay organised by grouping styles appropriately, using comments, and splitting things into multiple files.  A common issue with many programming related tasks.

However what we'd really like here is to mirror the effect from the Github landing page where these nav links disappear when the user places their cursor in the search field.  This will probably require some javascript:

```html
<script src='http://code.jquery.com/jquery-2.1.1.min.js'></script>
<script>
  $(document).ready(function(){
    $('.query').on('focus', function(){
      $('nav').fadeOut();
    });
    $('.query').on('blur', function(){
      $('nav').fadeIn();
    });
  })
</script>
```

So this works, but notice that the sign in button now increases to fill the remaining space.  We don't really want the nav links to be completely removed; we'd rather have them be there, but be invisible, and to achieve that we can switch to animating their opacity.


```javascript
  $(document).ready(function(){
    $('.query').on('focus', function(){
      $('nav').animate({opacity: 0;});
    });
    $('.query').on('blur', function(){
      $('nav').animate({opacity: 1;});
    });
  })
```

Note the links are still clickable even though they are hidden and this is the same in the Github landing page.  We might wonder if we can just look up how the same technique has been achieved on the Github site by going through their JavaScript.  This is made somewhat difficult since most sites will minify their JavaScript in order to improve browser performance, but we can sometimes work these things out.  For example on the Github site, if we watch the style changes in the inspector while we move the cursor in and out of the search field we can see that the style 'command-bar-focus' is being added and removed and if we search Github's minified JavaScript we can find references to that style, e.g.

```javascript
  … $(this).closest('.command-bar').removeClass('command-bar-focus') …
```

which can help us understand some of the techniques involved in a particular effect.  We could of course have chosen to add and remove styles rather than just setting the opacity directly in our JavaScript above, and that's probably better practice to ensure we have a clean separation between the coding logic and the style specifications.

So finally let's get the sign in button styled by grabbing a few styles from the the Github site itself.  We'll give the sign in button a 'sign-in-btn' class:

```css
.sign-in-btn{
  padding: 7px 12px;
  font-size: 13px;
  font-weight: bold;
  color: #333;
  text-shadow: 0 1px 0 rgba(255,255,255,0.9);
  white-space: nowrap;
  background-color: #eeeeee;
  background-image: -moz-linear-gradient(#fcfcfc, #eee);
  background-image: -webkit-linear-gradient(#fcfcfc, #eee);
  background-image: linear-gradiet(#fcfcfc, #eee);
  background-repeat: repeat-x;
  border-radius: 3px;
}
```

Having copied and pasted those few styles over, let's get back in the inspector and add a few more to finish things off:


```css
.sign-in-btn{
  padding: 7px 12px;
  font-size: 13px;
  font-weight: bold;
  color: #333;
  text-shadow: 0 1px 0 rgba(255,255,255,0.9);
  white-space: nowrap;
  background-color: #eeeeee;
  background-image: -moz-linear-gradient(#fcfcfc, #eee);
  background-image: -webkit-linear-gradient(#fcfcfc, #eee);
  background-image: linear-gradiet(#fcfcfc, #eee);
  background-repeat: repeat-x;
  border-radius: 3px;
  border: solid 1px #ccc;
  font-family: Helvetica Neue;
  width: 40px;
}
```

And we can use flex to help sort out our aligning:

```css
.left{
  flex: 65%;
  align-items: centre;
}

.right {
  flex: 35%;
  display: flex;
  align-items: centre;
}
```

If we now switch the background on the header to white we can compare the two side by side and see that we've gotten pretty close to replicating the look and feel of the header on the Github landing page.  One thing that is missing is the little question mark icon that Github has in their search bar.  If we inspect the Github site we can see that they have a little span in there:

```html
<span class='help tool tipped tooltipped-s' aria-label='Show command bar help'>
```

but that's as far as we'll go in this walkthrough.


Tips:
----

* get really comfortable with using the chrome inspector
* take advantage of flex box wherever you can
* start with your HTML to block out

Resources:

* [CSS tricks a guide to flex box](http://css-tricks.com/snippets/css/a-guide-to-flexbox/)
* [Can I Use](http://caniuse.com)
