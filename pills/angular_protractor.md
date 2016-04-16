# Protractor

Protractor is an end to end testing framework for Angular. As useful as it is, the documentation is not always the clearest, so this pill aims to act as a cheatsheet for common things you may want to do with Protractor.

## Running protractor

To run Protractor you'll need three terminal windows:

1. The first should run Webdriver `webdriver-manager start`
1. The second should run your angular app, if you're using http-server just make sure you're in the right folder and run `http-server`
1. The final window will be for running your tests, normally using the command `protractor test/protractor.conf.js`

## Protractor selectors

The most common selectors are

```js
element(by.css('#some-id')) // For finding one element
element.all(by.css('.some-class')) // For finding multiple elements
```

This is quite verbose, fortunately the two can be shortened to:

```js
$('#some-id') // For finding one element
$$(by.css('.some-class')) // For finding multiple elements
```
> Note $ is not a jQuery command, just a shortcut for `element(by.css('#some-id'))`

### Other selectors

> A lot of these examples are taken from [this blog](http://luxiyalu.com/protractor-locators-selectors/) with the mistakes corrected

```js
$('#some-id')                // element(by.id('#some-id'))
$('.some-class')             // element(by.className('.some-class'))
$('tag-name')               // element(by.tagName('tag-name'))
$('[ng-message=required]')   // remember to leave out the double quotes around the value of attribute
$('#parent #child')          // select one child inside parent
$$('ul li')                   // select all children inside parent - note the two $$ symbols, equivalent of `element.all`
$$('ul li').first()           // select first of children
$$('ul li').last()            // select last of children
$$('ul li').get(index)        // select index-th of children
```

## Protractor Commands

> A lot of these examples are taken from [this cheatsheet](https://gist.github.com/javierarques/0c4c817d6c77b0877fda) 

```js
browser.get('yoururl'); // Load address, can also use '#yourpage'
browser.navigate().back();
browser.navigate().forward();
browser.sleep(10000); // if your test is outrunning the browser
browser.waitForAngular(); // if your test is outrunning the browser
browser.getLocationAbsUrl() // get the current address
browser.ignoreSynchronization = true; // If true, Protractor will not attempt to synchronize with the page before performing actions
```

Here's a trick how to wait for something to become present/visible:

```javascript

browser.wait(function() {
   return $('#create').isPresent();
}, 5000);
   
$('create').click();
```

## Further Resources

- [Debugging Protractor](https://github.com/angular/protractor/blob/master/docs/debugging.md)
- [Protractor Docs](https://angular.github.io/protractor/#/)
