# Walkthrough - Setting up again with tests

[Back to the Challenge](../08_setting_up_again_with_tests.md)

First thing we need to do is set up npm which we'll use for installing all our
server-side JavaScript (such as the testing libraries Protractor/Karma). npm is
part of node.js so make sure node is installed:

```shell
node -v
```

If no version number is returned you'll need to install it:

```shell
brew install node
```

Now let's get our `package.json` file set-up (this is similar to a Gemfile in
Ruby, with some additional functionality). In a fresh directory, run

```shell
npm init
```

Choose the defaults (keep hitting return) and you're all good.

Now let's use npm to install bower. Bower is a npm package (like a Gem in Ruby)
which is used for installing front-end JavaScript, CSS, HTML and font packages.

```shell
npm install bower --save-dev
```

> We put `--save-dev` so that bower gets saved in our `package.json` as a
devDepedency - these are dependencies we won't need in our production
environment.

Now bower is installed, we can use it to install angular. We need to create a
`bower.json` file, by running

```shell
bower init
```

and once again just hitting return to choose all the defaults.


It makes sense at this point to consider that we're going to want to have an app folder which is
different from our test folder (a similar folder structure to those we've used in the
past when working with test-driven Ruby).

Let's create an app folder

```shell
mkdir app
```

And then we'll need to create a `.bowerrc` file in our root directory:

```shell
touch .bowerrc
```

In this file we then set bower to install its components inside of the app
folder

```json
{
  "directory": "app/bower_components"
}
```

Now we can install angular using bower

```shell
bower install angular --save
```

The `--save` will add the package into your `bower.json` file as dependencies. Then when you clone your repo again you can do a `bower install` in exactly the same way as you `bundle install` with Ruby.

Most package managers don't work the same way as Ruby gems. Package managers normally download packages into your local folder. Go ahead and do an `ls` and see what has been downloaded. Now we don't really want to add `bower_components` or `node_modules` into our repository - most people consider it bad practice but not all.

Because we don't want to commit those dependencies we need to add both folders to our `.gitignore` file.

```shell
node_modules
app/bower_components
```

Now is a good time to commit your changes!

[Forward to the Challenge Map](../00_challenge_map.md)
