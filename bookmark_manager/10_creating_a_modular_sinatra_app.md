## Creating a modular Sinatra app.

[Back to the Challenge Map](00_challenge_map.md)

At this point you should have a valid Link model and a failing test for visiting the links page. We need a web application to allow us to display a link to the links page.

In this challenge you will use Sinatra to set up a web application and tell Capybara which application it is testing.

## Learning Objectives covered

* Laying out Sinatra in the modular style
* Week 3 learning objectives also covered

## To complete this challenge, you will need to

- [ ] Create a file `/app/app.rb`
- [ ] Lay out Sinatra in the modular style within app.rb
- [ ] Tell Capybara which app you are testing in the `spec_helper`
- [ ] Require your link model in `app.rb`
- [ ] Ensure you require your server file in spec_helper
- [ ] Create a `\links` path and associated `erb` view
- [ ] Ensure that the feature test passes

## Resources

* [Sinatra Documentation - Modular Style](http://www.sinatrarb.com/intro.html#Sinatra::Base%20-%20Middleware,%20Libraries,%20and%20Modular%20Apps)
* [Sinatra Best Practices](http://blog.carbonfive.com/2013/06/24/sinatra-best-practices-part-one/)

## [Solution](solutions/10.md)
