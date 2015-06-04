## Static files

Earlier we've linked to an external image in our HTML. This is fine but it would be so much nicer to have the image as a part of our project. This would be a **static asset**, let's see how Sinatra handles them.

Let's put our image into **public/images/kitten.png** file in our project. The **public** folder doesn't exist, so create it as well as the images folder inside it. Now our file structure looks like this.

![alt text](images/sinatra/sinatra_basic_10.png)

Please note that the only file in the views folder so far is _index.erb. Gemfile, Gemfile.lock_ and _hello.rb_ are in the top-level project directory.

Now let's update our image tag to refer to the image:

````html
<img src='http://localhost:4567/images/kitten.png'>
````

You'll still see the image of the kitten but now it's loaded from localhost and not a remote server.

You probably have noticed that the address includes **images** folder but not the **public** folder. This is by design: Sinatra treats everything that's located inside the **public** folder as available via URLs. That's why by just putting a file there we were able to access it from the browser. This only works for the folder called **public**. You can't get to the views folder in the same way. The name is customisable, though: you can choose a different name for the **public** folder if you wish.

Of course, you can put anything you want inside this folder: not only images but also text files, executable files, CSS files (we'll get to them in a second) and many more things.

Github and switch! :twisted_rightwards_arrows: Although we are pretty much done with coding in this Sinatra pill - there are a few more things to explain.  Once you've read to the end of the pill why not try restarting this as a pair and re-creating the kitten app from scratch referring to the pill as little as possible?  Ultimately you should be able to build the app from memory.  Note of course that we are just playing around here, spiking a little app without any tests.  Best practise would avoid putting these quick spikes into production where many users would access them.

## Absolute vs relative URLs

However, there's a big problem with this code:

```html
<img src='http://localhost:4567/images/kitten.png'>
```

It refers to an absolute URL, that is, a URL that includes everything: the protocol (http), server address and port (localhost:4567) and the path to the file. As you remember, localhost refers to the computer you're on, so this image tag would work if and only if there is a web-server running locally on port 4567 serving this file.

In other words, if a friend of yours open the kitten website you just created from another computer, she will get the HTML code but she won't see the kitten because localhost will refer to her computer and not yours.

Even if you're planning to make this website available later on my-lovely-kitten.com, it's a bad idea to use an absolute url because then you will need this website to be up and running while you're developing it (and you haven't finished building it yet). Catch 22. Finally, your website may be available on several different domains, e.g. my-lovely-kitten.com and my-lovely-kitten.co.uk. Which address to use in this case? The correct answer is to not use absolute URLs unless you have a good reason to.

So, how do we link to the image without mentioning the server address? Use a relative URL, like this:

```html
<img src='/images/kitten.png'>
```

This tells the browser to use the address of the current website to fetch the page. So, for example, if this HTML page is server on localhost:4567, your browser will request this image:

```
http://localhost:4567/images/kitten.png
```

But if you have deployed your site to production and it's now running on my-lovely-kitten.com, your browser will fetch the image from

```
http://my-lovely-kitten.com/images/kitten.png
```

This applies not only to files but to all URLs. Remember, when we created a form, we used a relative URL?

```
<form action="/hello">
```

We could have used an absolute URL but it would have worked only on the computer the website is being developed on.

##  Two kinds of relative urls

So far when we were discussing relative URLs we assumed they were relative to the domain. So, if a web page at http://locahost:4567/ has this HTML, the browser will interpret it as http://localhost:4567/images/kitten.png.

```html
<img src='/images/kitten.png'>
```

However, it's not always convenient. Sometimes you want your URL to be relative to the current path. Let's say you have this URL in your application:

```html
http://www.example.com/users/12345/galleries/4/kittens/index.html
```

This URL would show all photos in the kittens folder in gallery number 4 for the user number 12345. How do you reference an image in the kittens folder? One way would be to do it like this:

```html
<img src="/users/12345/galleries/4/kittens/1.png">
```

However, you're forced to specify the full path to the image. Another solution is

```html
<img src="1.png">
```

Note the lack of a slash in the beginning of the URL. This means that the path is relative to the current URL path: ```http://www.example.com/users/12345/galleries/4/kittens/```. So, the browser interprets '<img src="1.png">' as

```
http://www.example.com/users/12345/galleries/4/kittens/1.png
```

but only if this HTML is served by the page at

```
http://www.example.com/users/12345/galleries/4/kittens/index.html
```

If the same HTML were served by

```
http://www.example.com/users/index.html
```

it would have been interpreted as

```
http://www.example.com/users/1.png
```

A common beginner mistake is to forget to put the slash at the beginning of the relative URL, watch out for it.

Next up, some exercises!

[Go to exercises](sinatra_exercises.md)

Resources
--------

* [Sinatra Main Site](http://www.sinatrarb.com/)
* [Sinatra Main Intro Documentation](http://www.sinatrarb.com/intro.html)
* [Talk Slides on Sinatra Chat Server](http://obfusk.org/achatwithsinatra/#1)
* [Detailed Talk Slides on Sinatra](http://www.slideshare.net/BobNadlerJr/sinatra-flatiron)
* [Sinatra Up and Running (Book)](http://shop.oreilly.com/product/0636920019664.do)
* [Jump Start Sinatra (Book)](http://www.sitepoint.com/store/jump-start-sinatra/)
