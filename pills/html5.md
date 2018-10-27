# Semantic HTML

***THIS ARTICLE IS UNDER CONSTRUCTION***

***Please note, as with all Makers Academy materials, there may be subtle errors in the following materials.  Please try to approach those as challenges on which to polish your debugging skills - pull requests always welcome.***

HTML (or HyperText Markup Language) is one of the most underappreciated technologies we teach here at Makers, and it's easy to understand why. At first glance, it's rather simplistic, easy to learn and seemingly needs CSS and/or Javascript to do anything remotely exciting.

But in actual fact, HTML is the backbone of the web. It's the cradle that keeps your content organised and accessible - and if it weren't for those angle-brackets, the web would be a very dark place indeed.


### Doctype

Ironically, the first thing in a HTML document is not even a html tag. The ```<!DOCTYPE>``` tag is an instruction to the browser, telling it which version of HTML the following document is composed in.

Previous versions of HTML have had some fairly intimidating looking doctypes - see this one for HTML 4.01 Transitional:

```html
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
```

But thankfully, the doctype for HTML5 is super compact:

```html
<!DOCTYPE html>
```

Isn't that lovely? And the great thing about it, is this actually triggers something called ['Standards Mode'](https://developer.mozilla.org/en-US/docs/Quirks_Mode_and_Standards_Mode) in the browser.


![Tracking pixel](https://githubanalytics.herokuapp.com/course/pills/html5.md)
