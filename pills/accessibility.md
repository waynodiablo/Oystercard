# Accessibility

## Workshop 1: the web for screen readers

The web is a visual medium, right?

> Wrong.

A [Google study](http://www.interactiveaccessibility.com/accessibility-statistics) found that there are _more visually-impaired internet users than there are Italian internet users_. As much as **3.5% of all web traffic** uses a _screen reader_ (a device that reads the structure of a web page aloud).

What does this feel like? The most popular screen reader is [JAWS](https://store.freedomscientific.com/collections/software-products/products/jaws-pro-screenreader) (which costs over $1,000), but you can trial the world's second most popular for free: VoiceOver.

### Exercise 1: Empathy with screen-reading users

- [Turn on VoiceOver](https://help.apple.com/voiceover/info/guide/10.12/#/vo2682) using Command-Fn-5.
- Visit an accessible site, like bbc.co.uk, and browse around using VoiceOver. Click any story, read the story, and then go back to the homepage.
- Visit [an inaccessible site, like this W3C example](https://www.w3.org/WAI/demos/bad/before/news.html), and try to do the same thing.

> For hard mode, try using VoiceOver at 1,000% speed (not uncommon for expert users).

The difference is clear: websites built without regard to screen readers are a slap in the face to visually-impaired users. Even if, for some reason, you're a soulless husk that doesn't care about users accessing your website, the bottom line might persuade you: in 2012, [the Royal National Institute for the Blind successfully sued low-cost airline Bmibaby](http://www.rnib.org.uk/press-releases-2012) for failing to provide access to their blind and partially-sighted members.

So how do we fix this?

### Exercise 2: Quick fix – Semantic HTML

Using Semantic HTML (literally 'meaningful HTML') will make your site more understandable to screen readers.

- Try [this non-semantic HTML](https://github.com/sjmog/inaccessible_sites/blob/master/non-semantic-html.html) in a screen reader. Now convert it to semantic HTML, and try it again. _You could use [this cheat sheet](https://learn-the-web.algonquindesign.ca/topics/html-semantics-cheat-sheet/) to help out._

> Tip: when working with HTML, periodically turn off styling (through the browser web developer tools). If your page doesn't make sense any more, it's probably not going to make sense to a screen reader.

### Exercise 3: Quick fix – form labels

A common design pattern is to avoid using labels on forms, because minimalism I guess:

![inaccessible form: a visually-attractive form that lacks labels on the inputs](https://cdn.dribbble.com/users/545046/screenshots/3873928/login.png)

On a screen reader, this kind of form is hard to decipher. The solution is to ensure that all form fields are labelled.

- Label the fields on [this inaccessible form](https://github.com/sjmog/inaccessible_sites/blob/master/inaccessible-form.html). _You could use [this guide](https://developer.mozilla.org/en-US/docs/Learn/HTML/Forms/How_to_structure_an_HTML_form#The_%3Clabel%3E_element) to help you._

### Exercise 4: Quick fix – text alternatives for images

Images convey meaning to sighted users: they should do the same for those using screen readers. To do this, set the `alt` attribute on `<img>` elements to a description of the image. Make it as interesting as the image!

- Take [this inaccessible photo album](https://github.com/sjmog/inaccessible_sites/blob/master/images.html) and add useful `alt` attributes to images.

> Tip: 'interesting' doesn't just mean a statement of what the image is. Visually-impaired users will appreciate an entertaining description. `<img alt="people holding hands" />` is less fun than `<img alt="Two people holding hands. They are standing on a beach and watching the sea. Both people are wearing red and they are smiling." />`.

![Tracking pixel](https://githubanalytics.herokuapp.com/course/pills/accessibility.md)
