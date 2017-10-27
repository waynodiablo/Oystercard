# 1: CSS for typography

In the 90s, web pages were pretty text-centric: 

![Yahoo in 1996: a basic webpage almost entirely made of text](images/yahoo-1996.png)

CSS was originally designed to style that text, and to position objects on the webpages. These exercises focus on working with text: positioning exercises are [here](https://github.com/makersacademy/course/blob/master/styling/2_the_box_model.md).

## Introduction

CSS was released in 1996, and it "aimed to describe the presentation of structured documents" – fonts, colours, and positioning – using "common desktop publishing terminology", which looked like this:

```css
body {
  font-size: 1em;
}
```

Why was CSS designed type-first? At the time, desktop publishing was all about digital typesetting. HTML derives from structure-defining languages used for earlier digital typesetting in the 70s. CSS – designed to style HTML – therefore focussed first on type, fonts, colours: the written word.

Even though CSS now works with loads of different things – animations, responsive interfaces, image filters – its roots are in typography. When surprised by a peculiar design choice in CSS, the root is often "it works like it works because CSS is principally designed to work with text".

Text is still a dominant internet medium, and poor typography is a barrier to readability. Getting good at working with it is a good introduction to using CSS.

## Exercises

### Exercise 1: typeset me

1. Fork the [Styling Exercises solutions repository](https://github.com/sjmog/styling_exercises). 
2. Clone it, and open `1_css_for_typography/index.html`. 
3. Use [26 Digital Typography Rules for Beginners](https://medium.com/product-design-ux-ui/26-digital-typography-rules-for-beginners-a04c6a5aaff3) to improve the typography of the page. Write CSS in the `1_css_for_typography/style.css` file to style the index file.

> Advanced mode: Use [Richard Rutter's](https://twitter.com/clagnut) popular work, [Web Typography](http://webtypography.net/) to really fine-tune your web typographic skills. There is a [more up-to-date eBook](http://book.webtypography.net/), too.

### Exercise 2: vertical rhythm

- Take your solution to Exercise 1, and use [4 Simple Steps to Vertical Rhythm](http://typecast.com/blog/4-simple-steps-to-vertical-rhythm) to establish a consistent vertical rhythm to the webpage.
