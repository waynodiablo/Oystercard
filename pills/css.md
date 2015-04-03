CSS
====

'CSS' stands for 'Cascading Style Sheets'. It is a language used to change the way [HTML](html.md) appears across different devices. HTML and CSS should always be maintained within separate files, a philosophy referred to as 'the separation of structure and presentation'.

- _Cascading_: CSS is designed to declare high-level rules for often-used HTML elements, like `<div>` and `<a>`, and become more granular by applying more specific styles by using _selectors_. In this way, styles declared at higher levels 'cascade' down to more specific elements.
- _Style_: CSS is used to make HTML look good. Where HTML defines the **structure** of a page, CSS defines the **style** applied to that structure. CSS can therefore be thought of as the 'paint' applied to the structural HTML scaffold.
- _Sheets_: CSS styles should always be separate from HTML structure, and CSS files should always be **imported into** HTML files. HTML uses the `<link>` tag to do this, usually (but not necessarily) within the `<head>` element.

## Including CSS in HTML

Before CSS, it was common to declare how HTML elements should look by using HTML attributes:

```html
<img width="120px" height="80px" />
```

This raises many problems. As HTML files grew in size, their structure was littered with, and strongly coupled to, ways of presenting that structure. As a result:

1. HTML files were very difficult to read
2. Serving the same content styled differently for different devices meant building HTML files specific to those devices
3. Changing HTML styles meant changing every element that used that style one-by-one.

CSS proposed splitting the presentation layer from the HTML structure. Nowadays, we include a separate CSS file - exclusively for presentation information - within HTML pages via a `<link>` tag:

```html
<head>
   <link rel="stylesheet" src="stylesheets/desktop_styles.css" />
</head>
```
> What does 'rel' stand for? Why is it used here? Can it be used anywhere else in HTML?

This means that:

1. HTML files are not littered with presentation attributes
2. The same content can be served to different devices simply by changing the CSS file referenced in the `<link>` tag, and 
3. Multiple HTML elements can be styled at the same time.

> You can still use HTML attributes like `width` and `height`, and you can also 'inline' CSS styles using the HTML `style` attribute. Both of these practices are frowned upon. Why?

## Using CSS to style HTML

CSS uses _selectors_ to target groups of HTML elements. The three main selectors are:

- _Element_ selectors, which target HTML elements at a high-level. For example, `div` or `img`.
- _Class_ selectors, which target HTML elements with specific values of the `class` attribute. For example, `.full-page`.
- _ID_ selectors, which target HTML elements with specific values of the `id` attribute. For example, `#article_3`.

#### Element selectors

You can target all HTML elements that use the same HTML tag by using _element selectors_:

```css
/* styling an img tag */
img {
  width: 120px;
  height: 80px;
}
```

Element selectors are written without the `<` `>` braces you see in HTML.

#### Class selectors

You can target HTML elements with particular classes by using _class selectors_:

```css
/* styling an HTML element with class="full-page" attribute */
/* for example, <div class="full-page"></div> */
.full-page {
  display: block;
  width: 100%;
}
```

Class selectors use a `.` (period) before the class name.

#### ID selectors

The vast majority of CSS uses a combination of element and class selectors to target elements. Where a very particular element needs styling, you can use the _ID selector_ to target it within a CSS file:

```css
/* styling an HTML element with id="article_3" attribute */
/* for example, <div id="article_3"></div> */
#article_3 {
  border: 1px solid grey;
  height: 240px;
}
```

ID selectors use a `#` (hashtag) before the ID name.

> There are other selectors available too, such as attribute selectors (like `[data-role="carousel"]`) and pseudoselectors (like `:nth-child`).

####Combining selectors

You can use selectors together to _cascade_ your styles to more specific elements. For example, you might want to make all images on your site square:

```css
img {
  height: 200px;
  width: 200px;
}
```

But only certain images should have red borders:

```css
img.red-bordered {
  border: 2px solid red;
}
```

Now you can do the following in your HTML:

```html
<!-- a square image -->
<img src="kitten.jpg" />

<!-- a square image with a red border -->
<img class="red-bordered" src="kitten.jpg" />

<!-- the below div does *not* receive a red border, as our CSS selector applies to only img tags -->
<div class="red-bordered" />
```

> You can use increasingly specific selector 'chains' to target increasingly specific parts of your HTML. To use this effectively, styles should be planned in advance. Some approaches to this include 'Object-Oriented' CSS (OOCSS) and a 'component-based' CSS model.

## The CSS language

CSS blocks are structured like this:

```css
selector {
	property: value;
	another_property: another_value;
}
```

The main CSS properties include: `display`, `position`, `height`, `width`, and `color`. There are [many hundreds of CSS properties](https://developer.mozilla.org/en-US/docs/Web/CSS), and this number is [increasing all the time](http://hakim.se/experiments). Keeping up with the latest trends is a large part of a front-end developer's job: sites like [CSS Tricks](http://css-tricks.com), [A List Apart](http://alistapart.com), [Codrops](http://tympanus.net/codrops/) and [CodePen](http://codepen.io) exist to make this more manageable.

> While the [W3C](http://w3c.org) is responsible for establishing what is and is not 'standard' in CSS, most CSS properties 'fall in to use' as they are adopted by browsers. This means that many newer CSS properties are not understood by older browsers. You can see which CSS properties are supported by different browsers at [Can I Use?](http://caniuse.com/). How does this affect a CSS workflow? Are there any ways your site can 'teach' newer CSS properties to older browsers?

## Going further

CSS is fairly easy to pick up, but extremely hard to master. To make matters worse, the field is constantly changing. Some fundamental things any front-end developer _must_ know include:

- The CSS [Box Model](https://developer.mozilla.org/en-US/docs/Web/CSS/box_model)
- CSS [Positioning](http://learnlayout.com/position.html)
- CSS [Vendor Prefixes](http://webdesign.about.com/od/css/a/css-vendor-prefixes.htm) and [how to deal with them](https://css-tricks.com/how-to-deal-with-vendor-prefixes/)
- CSS [Typography and Font Imports using `@font-face`](http://learn.shayhowe.com/html-css/working-with-typography/)
- CSS [Resets](http://stackoverflow.com/questions/6887336/what-is-the-difference-between-normalize-css-and-reset-css --> normalize less aggressive than reset)

Some things that are _very handy_ to know include:

- CSS [Preprocessors](http://www.sitepoint.com/6-current-options-css-preprocessors/)
- CSS [Design Patterns](http://www.sitepoint.com/css-architectures-scalable-and-modular-approaches/)
