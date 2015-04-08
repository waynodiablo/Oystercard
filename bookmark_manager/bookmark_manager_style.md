
## Styling the website

Right now our Bookmark Manager is very basic. Let's make it a bit more beautiful. We could have user powerful frameworks like Twitter Bootstrap that would have made our task easier but for the sake of practicing working with raw HTML/CSS, let's not use them.

Normally, as a developer, you'd get wireframes from a designer or take an off-the-shelf theme but our objective in this lesson is to learn how to write HTML&CSS from scratch.

In this section I will sometimes omit non-essential CSS&HTML examples focusing on more interesting aspects of front-end technologies instead.

As with Ruby code, you're strongly encouraged to use the code provided only as a reference to understand how it works. Write your own HTML and CSS code by hand, googling every new HTML tag and CSS property you encounter.

This is our starting point. There is no styling except the background colour.

![alt text](https://dchtm6r471mui.cloudfront.net/hackpad.com_HrmLraJclly_p.52567_1380200452467_Screen%20Shot%202013-09-26%20at%2014.00.29.png 'styling')

First, add a css reset file to your project. You can get one from www.cssreset.com. The goal of this file is to define the look of the elements that we didn't write CSS for. The reason CSS reset is necessary is that every browser uses its own defaults, so if you don't specify some property, your CSS may look slightly different in different browsers.

After we add Eric Meyer's CSS reset, our page looks very different.

![alt text](https://dchtm6r471mui.cloudfront.net/hackpad.com_HrmLraJclly_p.52567_1380201547369_Screen%20Shot%202013-09-26%20at%2014.18.53.png 'styling')

## Front page

Let's start by creating a black header line that will have the logo and the sign-in / sign-up / sign-out buttons. We're will be giving most elements an id or class to refer to the in the CSS file. The welcome message is a span because it doesn't need the dimensions, so we can use an inline element.

```ruby
<header>
  <div id='logo'>Bookmark Manager</div>
  <div id='user-links'>
    <% if current_user %>
      <span id='welcome-message'>
        Welcome, <%= current_user.email %>
      </span>

      <form id='sign-out' method='post' action='/sessions'>
        <input type='hidden' name='_method' value='delete'>
        <input type='submit' value='Sign out'>
      </form>
  </div>
</header>
```
![alt text](https://dchtm6r471mui.cloudfront.net/hackpad.com_HrmLraJclly_p.52567_1380201890089_Screen%20Shot%202013-09-26%20at%2014.24.45.png)

github
https://github.com/makersacademy/bookmark_manager/tree/8dde272fc5957bff09d196d6ec56d1278aa0c7c9

Let's now add sign up and sign in buttons.

![alt text](https://dchtm6r471mui.cloudfront.net/hackpad.com_HrmLraJclly_p.52567_1380203189272_Screen%20Shot%202013-09-26%20at%2014.46.12.png)

github
https://github.com/makersacademy/bookmark_manager/tree/c61d9bb8c2516207c1bd16c26c2d4ca367135bfe

Let's add some subtle texture to the background. The Extra Clean Paper on Subtle Patterns looks nice.

![alt text](https://dchtm6r471mui.cloudfront.net/hackpad.com_HrmLraJclly_p.52567_1380204212191_Screen%20Shot%202013-09-26%20at%2015.03.27.png)

github
https://github.com/makersacademy/bookmark_manager/tree/94ff132a390afb6bc9e3bfffeb118f737bb64da9

Let's now extract the form to add a link to its own page. To do this we need to create a new view, /links/new.erb, a new route in links.rb and update the tests that were expecting the form to be on the frontpage.

![alt text](https://dchtm6r471mui.cloudfront.net/hackpad.com_HrmLraJclly_p.52567_1380204564552_Screen%20Shot%202013-09-26%20at%2015.09.19.png)


![alt text](https://dchtm6r471mui.cloudfront.net/hackpad.com_HrmLraJclly_p.52567_1380204584565_Screen%20Shot%202013-09-26%20at%2015.09.39.png)

github
https://github.com/makersacademy/bookmark_manager/tree/3f393ebd1c36c290cc545f7d1c55012aba307c6d

The logo of the website is usually a link to the frontpage. Let's make it a link by wrapping the text in the anchor element. We'll need to update our css to specify that all links in the header are white and have no text-decoration (by default, links are underlined).

It's also a good time to get rid of the 'Welcome to the bookmark manager' message.

Let's now add a button to submit a new link to the header. We already have a route for it, /links/new, so it will simply be a link between #logo and #user-links.

```html
<a href='/links/new' class='button highlighted'>Add link</a>
```

This link has two classes, though. It's a button because we want it to look like a button but we give it a different class to override background colour.

```css
/* a link that has both classes. Overrides the previous declaration*/
a.button.highlighted {
  background-color: #b77843;
}
```

Now we have a button that's slightly different from the default button. The space between the logo and the button is explained by the margin-right on the logo.

![alt text](https://dchtm6r471mui.cloudfront.net/hackpad.com_HrmLraJclly_p.52567_1380205383837_Screen%20Shot%202013-09-26%20at%2015.22.58.png)

The colour was chosen using Colorhexa. It can generate colour schemes: sets of colours that arguably go together. If you're can't tell what colours go together (I'm like this), use colour scheme generators.

Note that I added a couple more links to the database.

github
https://github.com/makersacademy/bookmark_manager/tree/7baae00b00b55846c4a4618c337c202523315879

Let's now style the links list. First, let's put them into a container and move the link itself into a partial (remember partials from BattleShip – web version?). This will allow us to style the container itself.
```html
<div id='links-container'>
  <ul id='links'>
    <% @links.each do |link| %>
      <%= partial :link, locals: {link: link}  %>
    <% end %>
  </ul>
</div>
```

Just the white background, margins, padding and a hint of a shadow and it already looks better.

![alt text](https://dchtm6r471mui.cloudfront.net/hackpad.com_HrmLraJclly_p.52567_1380206873619_Screen%20Shot%202013-09-26%20at%2015.47.45.png)

Now let's make the links look better. First, let's create the elements we want to see in the link partial: title, description, time and author. We don't have most of the information yet, so let's use placeholders for now.

```html
<li class='link'>
  <a class='title' href='<%= link.url %>'><%= link.title %></a>
  <div class='description'>
    Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
  </div>
  <span class='source'>
    added yesterday by
    <a href='#'>evgeny@makersacademy.com</a>
  </span>
</li>
```

Note that we only use classes in this partial. Since this partial is going to be repeated several times on the page, we can't use any ids because every id is meant to be unique on the page.

Most of the css for this partial is here.

```css
.link {
  background-color: #EEE; /* same as #EEEEEE */
  box-shadow: 0 0 5px rgba(0,0,0,0.4);
  /* 10px for top and bottom, inherit from parent */
  /* for left and right */
  margin: 10px inherit;
  padding: 15px 10px;
}

  .link a.title {
    /* to make it slightly more prominent */
    letter-spacing: 1px;
  }

  .link .description {
    margin: 10px inherit;
  }

  .link .source {
    /* http://learnlayout.com/float.html and the next 4 sections */
    float: right;
    font-size: 12px;
  }
```

Now our frontpage looks much better.

![alt text](https://dchtm6r471mui.cloudfront.net/hackpad.com_HrmLraJclly_p.52567_1380208869701_Screen%20Shot%202013-09-26%20at%2016.21.03.png)

Note how the use of shadows gives the page depth.

github
https://github.com/makersacademy/bookmark_manager/tree/2aac0e5a09c8a1f2bbaad5eecf774eb0c9494211

Now let's add a footer to the page to give it completeness (and include a reference to Makers Academy in case this bookmark manager becomes really popular).

```html
<footer>
  <div id='makersacademy-logo'>
    <a href='http://www.makersacademy.com/'>
      <img src='http://www.makersacademy.com/images/logo.png'>
    </a>
  </div>
  <div id='technologies'>
    <p>
      I built this page at
      <a href='http://www.makersacademy.com'>Makers Academy,
      a highly selective 12 week coding course in London</a>.
    </p>
    <p>
      This website is built using Ruby, Sinatra,
      RSpec, Capybara, HTML and CSS.
    </p>
  </div>
</footer>
```

Let's style it using display='flex', as we've done in the header.
```css
footer {
  display: flex;
  background-color: rgba(0,0,0,0.2);
}

  footer > * {
    margin: auto inherit;
  }

  footer img {
    /* http://stackoverflow.com/questions/10658475/3px-extra-height-on-a-div-with-an-image-inside-it */
    vertical-align: top;
  }

  footer #technologies {
    -webkit-flex: 1;
    flex: 1;
  }

  footer p {
    padding: 5px 25px;
  }
  ```


This produces the following effect.

![alt text](https://dchtm6r471mui.cloudfront.net/hackpad.com_HrmLraJclly_p.52567_1380216944437_Screen%20Shot%202013-09-26%20at%2018.33.15.png)

The footer is not 'sticky', that is, if the window is larger than the content available, then the footer will not be at the bottom of the page.

![alt text](https://dchtm6r471mui.cloudfront.net/hackpad.com_HrmLraJclly_p.52567_1380217103005_Screen%20Shot%202013-09-26%20at%2018.38.15.png)

There are various techniques of making the footer 'sticky'. Feel free to try this one.

github
https://github.com/makersacademy/bookmark_manager/tree/27a54fced01e6c140d9040340c11e12709c57635

Let's now get back to the header and write some CSS for the case when the user is logged in because right now it's not very pretty.

![alt text](https://dchtm6r471mui.cloudfront.net/hackpad.com_HrmLraJclly_p.52567_1380217495035_Screen%20Shot%202013-09-26%20at%2018.44.07.png)

The first step would be to give all children of #user-links the display: inline-block property. The second step would be to replace the default button with a beautiful button. Just add the class 'button' and update the CSS because right now all relevant CSS declarations only apply to links with the class button, whereas we have an input element in the form. Also, we'll need to explicitely set font-size: 16px for the 'button' class.

However, we've just got an unexpected problem. Because the box model for a link and an input element differ, setting the width of 80px for the button class produces different results. A good solution would be to set the same box model rules for all elements, as we discussed in HTML & CSS. We should have done it at the very beginning but it's not too late to change the rules. Let's set it now:

```css
* {
  box-sizing: border-box;
}
```

Now the same box model is used for all elements. Since now the width property takes into account borders and padding, we'll need to increase it for the button class.

```css
width: 110px;
```

This finally produces a nice result: the input element looks exactly like a button.

![alt text](https://dchtm6r471mui.cloudfront.net/hackpad.com_HrmLraJclly_p.52567_1380218599377_Screen%20Shot%202013-09-26%20at%2019.02.51.png)

One last change to the header, though. When you hover over links, the cursor looks like a hand, whereas if you hover over an input element, it looks like an arrow. It's easy to fix by forcing the cursor we need for the button class.

```css
cursor: pointer; /* pointer looks like a hand */
```

github
https://github.com/makersacademy/bookmark_manager/tree/9c854827b174fa962a5c06df70bf8234c2bc81d3

Finally, let's style the flash message. At the moment it's not styled at all, it just appears as text:


![alt text](https://dchtm6r471mui.cloudfront.net/hackpad.com_HrmLraJclly_p.52567_1380219002454_Screen%20Shot%202013-09-26%20at%2019.09.57.png)

Let's make it beatiful. A few trivial changes produce a better flash notice.

```css
#notice {
  text-align: center;
  margin: 5px;
  padding: 5px;
  background-color: rgba(67,183,120,0.75);
  border-radius: 4px;
  box-shadow: 0 0 3px rgba(0,0,0,0.4);
  color: white;
}
```

![alt text](https://dchtm6r471mui.cloudfront.net/hackpad.com_HrmLraJclly_p.52567_1380219458030_Screen%20Shot%202013-09-26%20at%2019.17.30.png)

Now our frontpage looks slightly more sophisticated than when we started (even though a professional designer would not be particularly impressed by what we've done).

github
https://github.com/makersacademy/bookmark_manager/tree/83af49077d34aa9e1d39673df689ab1daef2d73d

Let's style other pages in the same way. The process is mostly mechanical, so let's highlight only the most interesting points.

Firstly, let's make the #links-container element part of the layout, so that it was the basis of every page. Since it's not a links container anymore, we'll rename it as well. This change will not lead to any change in the way the frontpage looks, so no screenshot here.

github
https://github.com/makersacademy/bookmark_manager/tree/cc1cbffa1314f36021293376e6eae5404ec1dc8e

Now let's make the /links/new view look better. Note that we're using placeholders (text inside the input that disappears on focus) instead of labels.
```html
<input type='text' name='url' placeholder='Url'>
```

![alt text](https://dchtm6r471mui.cloudfront.net/hackpad.com_HrmLraJclly_p.52567_1380271885168_Screen%20Shot%202013-09-27%20at%2009.51.17.png)

github
https://github.com/makersacademy/bookmark_manager/tree/eb68cf41e0bc204365a142fa3520141574a241a2

Let's do the same to the sign up and sign in forms, not forgetting the flash for the form. Since we can potentially show more than one error or notice, let's switch to using classes instead of ids.

```html
<% if flash[:notice] %>
  <div class='flash notice'>
    <%= flash[:notice] %>
  </div>
<% end %>
<% if flash[:errors] && !flash[:errors].empty? %>
  <ul>
    <% flash[:errors].each do |error| %>
      <li class='flash error'><%= error %></li>
    <% end %>
  </ul>
<% end %>
```

![alt text](https://dchtm6r471mui.cloudfront.net/hackpad.com_HrmLraJclly_p.52567_1380275191987_Screen%20Shot%202013-09-27%20at%2010.36.20.png)

![alt text](https://dchtm6r471mui.cloudfront.net/hackpad.com_HrmLraJclly_p.52567_1380275196397_Screen%20Shot%202013-09-27%20at%2010.46.17.png)

github
https://github.com/makersacademy/bookmark_manager/tree/0a78ed38cc17b197fc91ee999ab14a4a72090045

Now let's make the footer sticky using the technique described by Ryan Fait. One aspect of this technique is that it requires the footer to have a fixed height, so let's fix it at 70px (the height of the image and reduce the font-size to 12px. This will produce a weird side-effect on narrow screens (try resizing the window) but let's learn how to deal with it later, when we'll be discussing responsive design.

By applying Ryan's CSS directly, we achieve the desired effect with minimal changes to our layout.

```html
<body>
  <div class='wrapper'>
    <%= partial :header %>
    <%= partial :flash %>
    <div id='container'>
      <%= yield %>
    </div>
    <div class='push'></div>
  </div>
  <div class='footer'>
    <%= partial :footer %>
  </div>
</body>
```

![alt text](https://dchtm6r471mui.cloudfront.net/hackpad.com_HrmLraJclly_p.52567_1380276377318_Screen%20Shot%202013-09-27%20at%2011.06.12.png)

github
https://github.com/makersacademy/bookmark_manager/tree/10f47e97815b73dc0d75dcbb4eb9a79686f9576f

We will add more advanced functionality using Javascript and more advanced HTML&CSS techniques next week. If you haven't done so yet, it's a good time to deploy your website to [Heroku](../pills/heroku.md).
