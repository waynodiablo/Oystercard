# Protractor

Protractor is an end to end testing framework for Angular. As useful as it is, the documentation is not always the clearest, so this pill aims to act as a cheatsheet for common things you may want to do with Protractor.

## Running protractor

To run Protractor you'll need three terminal windows:

1. The first should run Webdriver `webdriver-manager start`
1. The second should run your angular app, if you're using http-server just make sure you're in the right folder and run `http-server`
1. The final window will be for running your tests, normally using the command `protractor test/protractor.conf.js`

## Protractor selectors

> A lot of these examples are taken from [this blog](http://luxiyalu.com/protractor-locators-selectors/) with the mistakes corrected

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


## Further Resources
  Protractor](https://github.com/angular/protractor/blob/master/docs/debugging.md)
