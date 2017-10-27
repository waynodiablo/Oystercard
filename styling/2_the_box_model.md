# 2: The Box Model

Here's a secret:

> Everything in HTML is a box. HTML is just boxes containing stuff.

So, in addition to remembering that [CSS is for typography](./1_css_for_typography.md), remember one more thing: CSS is for moving boxes around. The bad news is that there are a few ways to move boxes containing content around on a page. The good news is that once you know them, they behave consistently and, mostly, predictably.

The best introduction to the CSS Box Model is [CSS-Tricks](https://css-tricks.com/the-css-box-model/). It's a great resource for most things CSS.

## Exercise 1: Making a layout

- Take [this webpage](./webpages/2-1.html) and make it look like [this design](./designs/2-1.jpg).

> Top tip: in the first line of your CSS, add the following: `* { outline: 1px dotted #777; }`. Now you'll be able to see every HTML box on the page.

## Exercise 2: Centering with Flexbox

- Take [this webpage](./webpages/2-2.html) and make it look like [this design](./designs/2-2.jpg). _You can use another CSS-Tricks article, [The Complete Guide to Flexbox](https://css-tricks.com/snippets/css/a-guide-to-flexbox/), to help you._

> Top tip: set up [LiveReload](http://livereload.com/) to automatically reload your HTML pages when you change the CSS. Then set up your browser on one monitor and your text editor in another. Your productivity will skyrocket.

## Exercise 3: All the edge cases

- Take [this webpage](./webpages/2-3.html) and make it look like [this design](./designs/2-3-full.jpg). Also, when you resize the page, it should look like [this design](./designs/2-3-mobile.jpg). _This webpage deliberately contains a bunch of hard-to-figure-out edge cases for CSS. Oh, and you're **not allowed to change the HTML other than adding classes**._

> Top tip: try out small CSS changes using the Developer tools, in the 'Styles' panel of the 'Elements' pane. You can nudge items, and test things out live.
