CSS 2: the philosophy of CSS
====

CSS is an odd child. Like Ruby, JavaScript, Scala, Haskell, C#, and so on, it has its own syntax. In that respect, CSS can be considered to be a 'language'. It's a very simple one: it consists of the following structure:

```css
selector {
  property: value;
}
```

That's pretty much all the CSS language gives you. As a result, it has a reputation for being 'easy' - once you master that syntax, you're good to write any kind of CSS you like. Of course, you can go deeper - you need to know the different selectors (`.`, `#`, `element` and `[]`), and you need to know what certain properties (like `color`, `position`, `box-shadow`, and so on) _do_. There's not much consistency in the way properties work, and some of them have weird names (like `font-variant: small-caps;`) that don't fit well with an overall architecture. So that's hard: you need to know a lot of individual properties. But that's not _too_ hard: after all, you learned a bunch of Ruby and JavaScript methods by heart, and there are reference guides for all the rest. Finally, you've got to understand Specificity, Inheritance, the dreaded Box Model, and Typography. There are weird things, too, like cross-browser compatibility and a the patchwork quilt of vendor prefixes. So there's a _lot of stuff_ to learn, but none of it is particularly conceptually challenging.

But this is where CSS falls down. The conceptual challenges of other languages come from their best practices and their frameworks: RubyGems and Sinatra in Ruby, doing great Object-Oriented Design using `Prototype` in JavaScript, and so on. These conceptual challenges are designed to keep your code organised, flexible, and extensible. Because CSS lacks these provided challenges, it's immensely hard to write.

## Going further

CSS is fairly easy to pick up, but extremely hard to master. To make matters worse, the field is constantly changing. Some fundamental things any front-end developer _must_ know include:

- CSS [Specificity](https://developer.mozilla.org/en-US/docs/Web/CSS/Specificity)
- CSS [Inheritance](http://reference.sitepoint.com/css/inheritance)
- The CSS [Box Model](https://developer.mozilla.org/en-US/docs/Web/CSS/box_model)
- CSS [Positioning](http://learnlayout.com/position.html)
- CSS [Vendor Prefixes](http://webdesign.about.com/od/css/a/css-vendor-prefixes.htm) and [how to deal with them](https://css-tricks.com/how-to-deal-with-vendor-prefixes/)
- CSS [Typography and Font Imports using `@font-face`](http://learn.shayhowe.com/html-css/working-with-typography/)
- CSS [Resets](http://stackoverflow.com/questions/6887336/what-is-the-difference-between-normalize-css-and-reset-css --> normalize less aggressive than reset)

Some things that are _very handy_ to know include:

- CSS [Preprocessors](http://www.sitepoint.com/6-current-options-css-preprocessors/)
- CSS [Design Patterns](http://www.sitepoint.com/css-architectures-scalable-and-modular-approaches/)


![Tracking pixel](https://githubanalytics.herokuapp.com/course/pills/css_2.md)
