Pushing a Single JavaScript Page to Heroku Using Sinatra
---------------------------------------------------------

[Video from session](https://www.youtube.com/watch?v=uoSfB2yEogM)

***Please note, as with all Makers Academy materials, there may be subtle errors in the following materials.  Please try to approach those as challenges on which to polish your debugging skills - pull requests always welcome.***

We don't need a cloud hosting service as complex as Heroku to host a simple one page JavaScript app, but Heroku has a free tier and it gives us a path to scale up to much larger apps so it's great to get really familiar with it.

Note that we can deploy a static site without sinatra using simply the rack gem, but the walkthrough below shows how to do this for Sinatra.  See [this Heroku article](https://devcenter.heroku.com/articles/static-sites-ruby) to deploy a static site simply with rack.

To get a simple sinatra server on heroku we need a simple app.rb file:

```ruby
require 'sinatra'

get '/' do
  erb :index
end
```

We'll need a views directory, and if we previously had an index.html file that we were using for our single page JavaScript app then we need to rename that to index.erb and move it into the views directory.  JavaScript and anything else that the user's browser needs access to (e.g. images, CSS, fonts etc.) should go in a public directory.  We should never put our source code in the public directory.

We'll also need a Gemfile and a config.ru file:

```ruby
require_relative './javascript/app'

run Sinatra::Applicaton
```

Our Gemfile will need a rubygems source and sinatra gemgit  like so:

```ruby
source 'https://rubygems.org'

gem 'sinatra'
```

and we need to move our image files and javascript into the public directory.  Your directory structure might now look something like this (excluding the test directories):

```sh
→ tree
.
├── Gemfile
├── Gemfile.lock
├── README.md
├── SpecRunner.html
├── app.rb
├── config.ru
├── public
│   ├── images
│   │   ├── lizard.png
│   │   ├── paper.png
│   │   ├── rock.png
│   │   ├── scissors.png
│   │   └── spock.png
│   └── javascript
│       ├── Game.js
│       ├── Player.js
│       └── app.js
└── views
    └── index.erb

```

Finally, if we want to deploy our system to Heroku we need to execute the following commands:

```sh
git add .
git commit -am 'ready to run on heroku'
heroku create
git push heroku master
heroku open
```

Note that you will have to ensure that any remote scripts you load are done so over https, otherwise Heroku will complain - check your index.erb file for any plain http request for JavaScript libraries.

Exercises
-------

* Get your app on heroku and post a link to the live site and your Github repo into the [course wiki](https://github.com/makersacademy/course/wiki/Demo-Apps)


Resources:
-------

* [Getting Started with Sinatra on Heroku](https://devcenter.heroku.com/articles/getting-started-with-ruby-o)


![Tracking pixel](https://githubanalytics.herokuapp.com/course/walkthroughs/heroku_sinatra_javascript.md)
