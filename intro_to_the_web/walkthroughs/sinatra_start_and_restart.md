# Walkthrough – Sinatra: Start and restart

[Back to the Challenge](../sinatra_start_and_restart.md)

If we wanted to have another page at `http://localhost:4567/secret`, then we'd do the following:

````ruby
# inside app.rb
require 'sinatra'

get '/' do
  'hello!'
end

get '/secret' do
  'This is a secret page'
end
````
But wait! Having done this in your Sinatra application, visiting `http://localhost:4567/secret` in a browser gives you this page:

![alt text](../images/second_sinatra_route.png)

An error! Another good time to commit your code, push it to Github (:pill: [Version Control with Git](git.md)), and switch Driver/Navigator Roles&nbsp;:twisted_rightwards_arrows:

### Reload your code

What's happening here? Nothing bad: Sinatra is telling you that it doesn't know what '/secret' is all about, despite you having written this in your app.

The problem: we haven't rebooted the server after making our changes. The running server has a `/` route, but no `/secret` one.

To stop the server, head to the terminal tab in which the server is running and hit `Ctrl-C`. Then restart the server just like you started it in the first place:

`$ ruby app.rb`

Head back to _http://localhost:4567/secret_: it now works! But restarting the server manually every time we change the code is going to get very painful.

## Automatic code reloading

What we've been doing is restarting our server every time we made a change to the files because Sinatra needed to reload them. There's a way to reload the files without restarting the entire process.

Firstly, install a gem called **Shotgun** within this project. You already know how to require and install gems.

Secondly, load your application like this:

`$ shotgun app.rb -p 4567`

The `-p` switch tells shotgun what port to use. Use this switch to keep the port consistent with the default Sinatra port. By default shotgun will use port 9393.

If you see a "Boot Error" when you're starting the application using shotgun, double check that you have required the _sinatra_ gem in the `Gemfile`, and have run `bundle install` afterwards.

> What does `bundle install` do? Are there any other uses for `bundle`?

Assuming that you get Shotgun working you can now make changes to your `app.rb` file and see the changes with a simple browser refresh.  Try adjusting the strings in the `do ... end` blocks and reload the browser.

Shotgun works by reloading your entire application on every request. While this is very convenient for our development process, it might cause problems down the line with the way Sinatra secures session data (you will learn about this in a later challenge). To avoid this pitfall, we should add the line `set :session_secret, 'super secret'` to our `app.rb` file. What this is doing is beyond the scope of this challenge, but go [here](https://groups.google.com/forum/#!topic/sinatrarb/pUFSoyQXyQs) if you're interested.

Webpages that return strings are kind of boring. Next up, let's add some [HTML](pills/html.md) to the mix.

[Forward to the Challenge Map](../README.md)
