# Walkthrough – Sinatra: Returning HTML

[Back to the Challenge](../sinatra_returning_html.md)

"hello" is a boring thing to send to our users. We can do better!

Behind the scenes, Sinatra was actually sending "hello" as an [HTML](html.md) file. Now we know that, we can just substitute our "hello" string for some cool HTML:

````ruby
require 'sinatra'

get '/cat' do
  "<div>
    <img src='http://bit.ly/1eze8aE'>
   </div>"
end
````

Now go to the webpage at the `localhost` address and check out the fruits of your labour. If the page isn't showing as you expect - are you using Shotgun?

A good time to commit your code, push it to Github (:pill: [Version Control with Git](https://github.com/makersacademy/course/blob/master/pills/git.md)), and switch Driver/Navigator Roles&nbsp;:twisted_rightwards_arrows:

So, we just have a cat image. As lovely as it is, is a bit dull. Real web pages have something else in them that makes them look good: CSS.

CSS stands for Cascading Style Sheets. It's a language that describes what HTML elements should look like when they are rendered by the browser. For example, let's add some CSS code to create a border around the **div** that contains our image.

````ruby
require 'sinatra'
get '/cat' do
  "<div style='border: 3px dashed red'>
     <img src='http://bit.ly/1eze8aE'>
   </div>"
end
````

Now our web page looks like this:

![alt text](../images/sinatra_cat_route.png)

To achieve this effect we added an **attribute** called **style** to the **div** element. Its **value** is "border: 3px dashed red". It defines what style is applied to the element, in this case a border, 3 pixels wide, dashed (as opposed to solid, for example), and red in colour.

By combining HTML and CSS we can achieve sophisticated visual effects in our web applications. We'll explore the basics of how HTML and CSS work in more details later this week and we'll discuss advanced HTML and CSS features in weeks 7 and 8.

Before we move on let's commit our code, push it to Github and switch Driver/Navigator Roles again&nbsp;:twisted_rightwards_arrows:

Next up, we'll see if we can modularize some of our code into a _view_.

[Forward to the Challenge Map](../README.md)


![Tracking pixel](https://githubanalytics.herokuapp.com/course/intro_to_the_web/walkthroughs/sinatra_returning_html.md)
