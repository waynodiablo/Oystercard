# First day? Let's do something just for fun!

Welcome to Makers Academy! Are you ready for the ride?

Today we are going to take things slow, we want you to have some fun before we start working through the material of this course and begin our journey; we want to give you a glimpse of what it will feel like to be a software developer!

We'll build a website that allows you to create a motivational poster using an image and text that the user inputs.

![twain](https://github.com/makersacademy/course/raw/master/images/twain.png)

This is what the website will look like when you build it.

![motivational](https://github.com/makersacademy/course/raw/master/images/motivational_sample.png)

You're strongly encouraged to type in all code instead of copy-pasting it. This will really help your understanding of how everything works.

We can't stress this enough. Copy and Paste is the DEVIL!! Even though at times you will be copying chunks of code, the simple process of typing it yourself will help you learn. Trust us. You can't cut corners.

## What you'll need

- [Google Chrome browser](http://www.google.co.uk/chrome/). It's very well suited to web development ( _Safari; bundled with your Mac will do fine as well though_ ).
- [SublimeText editor](http://www.sublimetext.com). This is a very convenient text editor that we'll be using.
- Make sure you know how to run Terminal (it's already installed on every Mac). Find it in your Applications (in the Utilities folder) and launch it. ![finder](https://github.com/makersacademy/course/raw/master/images/finder.png)
- XCode command line tools. Go to https://developer.apple.com/xcode/, click "View downloads" under Xcode 5 section, enter your Apple ID (you use it to get content from AppStore or iTunes), create one if you don't have it, select "Command Line tools for OS X Mountain Lion XCode5", download and follow the installation instructions.![finder](https://github.com/makersacademy/course/raw/master/images/command_line_tools.png)
- Once you have installed XCode, install Heroku Toolbelt from https://toolbelt.heroku.com/ 
- Install RVM. 
Type this in the Terminal window.

```
curl -L https://get.rvm.io | bash -s stable --ruby=2.0.0
```

## Version 0: Create a walking skeleton

Create a new directory on your desktop called "motivational-posters" (note the hyphen). Launch Sublime Text editor that you installed before and open this directory by choosing File->Open. 

You should see a window like this.

![subl](https://github.com/makersacademy/course/raw/master/images/day_one/subl.png)

This is the directory where all our files for our web page will be stored. Let's begin by creating a file called app.rb. The .rb extension means that this is going to be a Ruby file. Ruby is a programming language that many websites are built with. Today we'll be using a tiny bit of Ruby but our website will be built using mostly Javascript – another programming language.

Right click the folder name and create a new file.

![new_file](https://github.com/makersacademy/course/raw/master/images/day_one/new_file.png)

Sublime Text will create an untitled file first. Press `Cmd-S` to save it as app.rb.

Let's create the most basic web page first. It will show the text `"Hello, world!"`. Put this into the app.rb.

```` ruby
require 'sinatra'

get '/' do
    "Hello, world"
end
````

We'll get back to what this means in a second. Let's see if it works first.

Open the Terminal. It will look like this.

![term](https://github.com/makersacademy/course/raw/master/images/day_one/term.png)

The Terminal is a text-based interface for interacting with your computer. It's also called the command line, the shell or the CLI (command-line interface). It's used by all web developers on a daily basis. It may seem strange to use a text-based interface at first (after all, we've got beautiful graphical interface on a Mac) but it's actually very convenient once you get used to it.

In the Terminal you're always in some directory, just like you're always viewing contents of some directory in Finder. Let's open the directory we need in the Terminal. Type this command:

`cd ~/Desktop/motivational-posters`

Note that there's a space after cd. The cd commands stands for "change directory". After the command is the address of the directory that we just created a few minutes ago. The "~/Desktop" is your Desktop (yes, it's just a normal directory) and "motivational-posters" is what we have created for our project.

Now that we're in the motivational-posters directory, let's install some more software that we'll need. First, type ruby -v to make sure you've got Ruby installed. The Terminal should look like this.

![term_ruby](https://github.com/makersacademy/course/raw/master/images/day_one/term_ruby.png)

In this case, the version of Ruby is 2.0.0.p0. If yours is different, for example, 1.9.3 or 1.8.6 it isn't a problem. If you don't see the version number, it means you haven't got Ruby installed and you need to go back to the installation instructions.

Now let's install the software that we'll need. To build a website, we'll need something called a framework. This is a piece of software that acts as a bridge between your code and the browser. It will read the app.rb file and make sure it's available in the browser. Let's install it. Type this in the Terminal to install a framework called Sinatra.

`gem install sinatra`

You should see something like this (it may take a minute).

![sinatra_gem](https://github.com/makersacademy/course/raw/master/images/day_one/sinatra_gem.png)

Now that you've got Sinatra, let's launch our "Hello, world" website. Type this in the Terminal to run the app.rb file.

`ruby app.rb`

Now you're telling your Ruby to execute the file that we've created earlier.  You should see this in the Terminal (the previous lines that we typed were cleared because they are no longer relevant).

![sinatra](https://github.com/makersacademy/course/raw/master/images/day_one/sinatra.png)

This message means that your website is up and running at the address `localhost:4567` (note the last line). This is a special address that is used for running websites locally. (If your website starts on the address `localhost:3000`, it's ok as well, just use that address). Now open a new browser window and type this address in. You should see "Hello, world".

![localhost](https://github.com/makersacademy/course/raw/master/images/day_one/localhost.png)

If you see this, you've just made your first step towards developing your first website! This doesn't look like a website yet but it's actually a fully functioning website that we'll be extending and improving until we are happy with the result.

Let's get back to the contents of the app.rb file. Here's what it looks like.

````ruby
require 'sinatra'

get '/' do
  "Hello, world"
end
````

As we mentioned above, this is a Ruby file, that is, a programme written in a programming language called Ruby. It's very simple. On the first line we tell Ruby to use the Sinatra framework that we've installed previously. Then, on line 3 we're telling it that when we go to the index page of the website (the last "/" in "localhost:4567/"), it should display "Hello, world" on this page. This is exactly what we're seeing in the browser.

Let's practice changing this page. Go back to the terminal and stop your server by pressing Ctrl-C. You should see "Sinatra has ended his set" message.

![sinatra_stop](https://github.com/makersacademy/course/raw/master/images/day_one/sinatra_stop.png)

Now go back to app.rb in Sublime Text and change the text to "Motivational Posters". Pay attention to the quotes around the text, they are important and they must be the same, that is, either single or double quotes but both of the same type.

````ruby
require 'sinatra'

get '/' do
  "Motivational Posters"
end
````

Now go back to the terminal and start your website again.

`ruby app.rb`

Refresh the page in the browser and you should see the new text.

![motivational](https://github.com/makersacademy/course/raw/master/images/day_one/motivational.png)

**That was all for our first version, great job!**

## Version 1: Let's build the front end

Now we have a very simple but functioning website. Let's add some HTML to it to make in more interesting.

HTML stands for Hypertext Markup Language. This is the language that is used to create webpages. All websites you're using daily are built using HTML.

It's inconvenient to put our HTML right into app.rb. It will be easier to create a separate file. Just like you created app.rb in Sublime Text, create a folder called `views` and a file index.erb inside it. Your project now should look like this.

![index_erb](https://github.com/makersacademy/course/raw/master/images/day_one/index_erb.png)

Why don't we move the text `"Motivational Posters"` from our app.rb into this file?

![index_erb_motivational](https://github.com/makersacademy/course/raw/master/images/day_one/index_erb_motivational.png)

One last thing we need to do is to tell the app.rb file to actually use this file. Update your Ruby code to this.

````ruby
require 'sinatra'

get '/' do
  erb :index
end
````

Line 4 here means: take the contents of index.erb and output it to the browser. What about the views folder? Sinatra looks there by default: it's where most developers using Sinatra keep HTML files, so you don't have to specify it.

Restart your website as you've done before (Ctrl-C and then ruby app.rb again) and refresh the browser. It should look exactly like before.

Now let's add some real HTML into index.erb. Every HTML file must have the following structure.

````html
<!DOCTYPE html>
<html>
<head>
  <title>Title of the website</title>
</head>
<body>
  
</body>
</html>
````

Replace the contents of the index.erb with this HTML code.

````html
<!DOCTYPE html>
<html>
<head>
  <title>Motivational Posters</title>
</head>
<body>
  <h1>Motivational Posters</h1>
  <p>By Tonight I'll have a fully functioning website!</p>
</body>
</html>
````

Go back to the browser (no need to restart the website this time, it's only necessary if you modify app.rb). You should see this.

![localhost_motivational](https://github.com/makersacademy/course/raw/master/images/day_one/localhost_motivational.png)

If you see this, you know you're on the right track: your website is up and running and it loads HTML code from index.erb.

## Version 2: Adding some style

CSS (stands for Cascading Style Sheets) is the technology that is used to define how your website looks. Right now it doesn't look anything special: black text on a white background but if we add a little bit of CSS, it'll be different.

Let's choose the background for our website first. Go to [Subtle Patterns](http://subtlepatterns.com) and choose any background that you like. It will help if your background is light, and not dark. Download the background you chose from the website and unzip it. There will be two images there and a `readme` file. For example, this is the background I chose (unzipped).

![ricepaper](https://github.com/makersacademy/course/raw/master/images/day_one/ricepaper.png)

Take the smaller of the two images (ricepaper_v3.png) in this example and put it in the `public/images` folder in motivational-posters directory (use Finder to do it). You'll need to create the folders `public` and `images` first. After you do this, your project will look like this.

![index_erb2](https://github.com/makersacademy/course/raw/master/images/day_one/index_erb_2.png)

Now let's set this image as the background for our website. Update line 6 in index.erb to do this.

![index_erb3](https://github.com/makersacademy/course/raw/master/images/day_one/index_erb_3.png)

We have just added some CSS code to tell the browser that the body of our page, that is, everything that's visible on the screen, should use the file that we put into the images folder as the background image. Our page now looks like this.

![browser1](https://github.com/makersacademy/course/raw/master/images/day_one/browser_1.png)

I bet you can see where it's going. By adding various CSS rules one after another we will make our website look good in almost no time!

Even though we can put CSS in the HTML file, it's inconvenient. We'll be writing a lot of CSS, so let's put it into a separate file. Create a folder `css` inside the `public` folder and then create a file application.css inside `public/css`. Your project structure will look like this.

![appcss](https://github.com/makersacademy/course/raw/master/images/day_one/appcss.png)

Now let's move our CSS code from the HTML file into here. Remove the CSS from index.erb, so that the `<body>` tag has no attributes:

`<body>`

Then add this CSS into public/css/application.css:

````css
body {
  background-image: url(/images/ricepaper_v3.png)
}
````

Obviously, you'll need to replace ricepaper_v3.png with another filename if you have chosen a different background.

This CSS code tells the browser that this background image should be used for the `body` element in HTML. However, if you refresh your browser right now, there will be no background at all. This is because we haven't told the browser to use this CSS file.

In order to tell the browser to load CSS directives from a different file, we need to link the HTML file to the CSS file. You can do it by adding this line to the <head> section of your HTML (partial index.erb shown):

````html
<head>
  <link href="/css/application.css" rel="stylesheet" type="text/css">
  <title>Motivational Posters</title>
</head>
````

This tells the browser that when rendering this web page, it should use the file application.css in the css folder. It also tells the browser that it's a stylesheet (that is, a file that determines what the webpage looks like) and it's of a CSS type.

If you refresh the browser now, you should see your background again. This time it will be defined in an external CSS file.

![browser1](https://github.com/makersacademy/course/raw/master/images/day_one/browser_1.png)

## Version 3: Adding some logic into the application

## Version 4: Final touches and "getting it out there"

## Extra Exercises

Finally, once you are really comfortable with the existing codebase, do the following exercises. Many of them will involve some googling around to learn something new, others will involve going back to this tutorial, as well as HTML & CSS overview.

- Add more colours into the drop-down menu. Make sure there are lots of colours to choose from.
- Change the background colours of the sections to something new, don't use the colours we've just used. Play with the opacity values.
- When the thumbnails are shown, they look rather dull: all together, without borders or shadows, without any space in between. How can you make them look better?
- When you enter the keyword and press Enter, the search isn't performed by default. What if you add a Javascript event to listen for when you hit "Enter" in the keyword input field? Then, when this event happens, you could kick off the image search. You'll probably need to google a little bit to find out how to listen for this event (stackoverflow.com is the best source of programming tips).
- Right now we're using Helvetica as the font for the page. Find out how to use a different font. What fonts are available in every browser by default? Change the font to one of them.
- Can you find out how to download an exotic font, add it to the project and apply only to the h1 header on the page using CSS?
Right now the "Powered by Google" logo is right-aligned. Can you make it centred?
- Add your name to the footer, so that everyone knew who built this site!
- In the footer we're listing the technologies used. Can you find their websites and add the links in the footer?
- We've got the tweet button on the page that we've got from the Twitter website. Can you find the code for the Facebook like page? (This may be a bit tricky, it may involve creating an "application" on Facebook but it's actually much easier than it sounds).
- What other text properties, apart from position, colour, alignment and font size can you think of? Can you add them to the page and make them work with javascript?
- Find a website that allows you to generate a logo, create one for the page and add as an image to the header.
- Find a website that allows you to generate buttons, create a beautiful "Search" button and replace our plain and dull "Go" button.