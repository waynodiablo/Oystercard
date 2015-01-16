# Responsive Web Design

Mobile browsers are rapidly overtaking desktop and laptop browsers in terms of share of time spent online. This means that we need to be ever more conscious of the layout of the websites we build, no matter the size or shape of the screen. To ensure the greatest experience for our stakeholders, we should endeavour to design our sites to respond to the dimensions of the browser. This is Responsive Web Design (RWD).

There are three main tools that we can use to ensure our websites are scalable and responsive:

## Fluid Grids

When arranging the elements of your website on the page, using relative measurements allows each element to grow and shrink within parameters that you set. 

Consider using % in your css instead of px. If your browser is 1028px wide, and you wrap the contents of your site in a 'wrapper' div that is 980px wide, that is 980/1028 = 95.33%. If you write your CSS using % rather than px, you ensure that you always have the proportional amount of whitespace around your wrapper.

