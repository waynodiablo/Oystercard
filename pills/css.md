CSS
====

:construction: UNDER CONSTRUCTION :construction:

Key concepts for understanding CSS

1) Selectors

Through 'selectors', CSS provides a mechanism for specifying some subset of the HTML elements in a page.  There ar.e various types of selector, but the most common are those that specify id ('#id'), class ('.class') and tag ('tag').  These can be combined to specify more precise subsets of the tags in a page, e.g. the selector 'p.warning' would specify all the 'paragraph' tags with the class of 'warning', while 'section#example' would match all the 'section' tags with an id of 'example'

* attribute selectors
* nested? selectors

2) Box Model

CSS treats every HTML element as if it were a box with various types of spacing layered around it's internal content:

![box model](http://www.codeproject.com/KB/HTML/567385/boxmodel-image.png)

can adjust box sizing to force elements to fill box?

3) Layout

...

4) overriding/inheritance?

5) vendor prefixes

Give specific support in browsers for features that are not yet using the latest standard - note the bottom rule overrides others (CSS compiler can automatically add these).

```css
.shadow {
  -webkit-text-shadow: 2px 0px 5px rgba(3, 0, 91, 0.5);
  -moz-text-shadow: 2px 0px 5px rgba(3, 0, 91, 0.5);
  text-shadow: 2px 0px 5px rgba(3, 0, 91, 0.5);
}
```

6) font imports

grab Roi's codepen example ... add video from Roi's HTML/CSS intro talk

[TODO] Roi's breakout video

CSS compilers (LESS, SASS)

Resources
--------

* http://codepen.io
* http://shoptalkshow.com/
* http://alistapart.com/article/responsive-images-in-practice
* http://stackoverflow.com/questions/6887336/what-is-the-difference-between-normalize-css-and-reset-css --> normalize less aggressive than reset

* css tricks
* css reference (codrops)
* can I use
* a book apart books
