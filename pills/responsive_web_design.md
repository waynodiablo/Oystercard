# Responsive Web Design

Mobile browsers are rapidly overtaking desktop and laptop browsers in terms of share of time spent online. This means that we need to be ever more conscious of the layout of the websites we build, no matter the size or shape of the screen. To ensure the greatest experience for our stakeholders, we should endeavour to design our sites to respond to the dimensions of the browser. This is Responsive Web Design (RWD).

## RWD Tools

Here are some of the main tools that we can use to ensure our websites are scalable and responsive:

### Fluid Grids

When arranging the elements of your website on the page, using relative measurements allows each element to grow and shrink within parameters that you set. 

Consider using % in your css instead of px. If your browser is 1028px wide, and you wrap the contents of your site in a 'wrapper' div that is 980px wide, that is 980/1028 = 95.33%. If you write your CSS using % rather than px, you ensure that you always have the proportional amount of whitespace around your wrapper.

### Fluid Images

Images provide an interesting problem for responsive websites. Depending on the function and contents of the image you may want them to scale, cover a specific area, maintain (or not) their aspect ratios and so on.

The simplest way of scaling your image is to place it inside a container, and set the CSS attribute ```max-width:100%``` of that container. You can then apply styles to the container div to ensure that the image behaves as expected. This is simple and is therefore a go-to method in many cases. 

Sometimes you will come across an image where the positioning and framing of the image does not allow you to use the 100% width method. In this case, setting the image as a background for its container div allows access to ``background-position:fixed`` or ```background-position:cover``` CSS attributes, allowing for greater control over the scaling of the image.

### Media Queries

Scaling the size of various elements on the page can only go so far in terms of responsive design. As it increases in size, there will come a point where your perfect iPhone page will look vast and empty unless you restructure it. This is called a breakpoint, and can be set in your CSS using a media query. 
```
@media screen and (min-width: 640px) and (max-width: 1025px)
```
Any CSS that is written underneath this @media tag will only be executed when the screen is at between 320px and 600px wide inclusive. CSS Tricks have a fantastic guide for how to make good use of this function - see the external resources at the end of this document. Typically, breakpoints are set between each of phone / tablet / laptop / desktop or 40em(640px) ; 64em(1025px) ; 90em(1441px).

## Mobile First

When developing a responsive site, it is good practice build your mobile site first and then scale it up. There are many good reasons for this: 

* A small screen has no room for clutter
* Touch screens cannot rely on ‘hover’ or ‘mouseover’
* Much easier to scale up than shrink down - streamlined mobile pages become streamlined desktop pages, whereas scaled down desktop pages become cluttered and hard to read.

## Know your customer!

Hugely important to develop the right application for your customer. Which version of IE do you need to code for? What browsers are most common? It is important that you are able to answer these questions before building your responsive site. 

Having said that don't fall into a common trap - if you don't build a mobile site because you don't have much mobile traffic... you will never have mobile traffic because you are not catering for that demographic. 

## External resources
* [CSS Tricks - Media Queries](http://css-tricks.com/css-media-queries/)
* [CSS Tricks - Fluid Grids](http://css-tricks.com/dont-overthink-it-grids/)
* [Fluid Images](http://demosthenes.info/blog/586/CSS-Fluid-Image-Techniques-for-Responsive-Site-Design)
* [RWD Bookmarklet](http://responsive.victorcoulon.fr/ - RWD bookmarklet)
* [This Is Responsive](http://bradfrost.github.io/this-is-responsive/)
* [mediaqueri.es](http://mediaqueri.es/)


![Tracking pixel](https://githubanalytics.herokuapp.com/course/pills/responsive_web_design.md)
