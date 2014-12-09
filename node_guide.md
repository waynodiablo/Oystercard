#Node.js

Welcome to Node! This week, you will be learning how to build realtime applications using JavaScript across the whole stack. If you haven't heard of Node, here is a short list of what Node is and what Node isn't:

* Node is a server-side implementation of JavaScript, using Google's extremely powerful V8 engine  
* Node is extrememly good at handling large numbers of simultaneous requests or connections  
* Node is deliberately very minimal, encouraging users to write and use their own packages to extend functionality  
* Node is growing at an incredible rate. Its ecosystem is massive, with the number of published `npm` packages rapidly overtaking Ruby's gems  

* Node is NOT multi-threaded; it's just very smart with how it deals with these requests  
* Node is NOT mature - while currently stable, it is nowhere near a 1.0 release  
* Node is NOT a magic bullet - despite what the Internet may say, Node is not suited to every task  
* Node is NOT easy - first of all, it's all JavaScript (tricky!) and has lots of new and strange conventions and techniques  

BUT

* Node is a lot of fun  
* Node is a different way to think about programming, so even if you don't find it fun, you will hopefully learn something!  

##Introduction

Before we start, you should definitely read [Roi's introduction to Node](https://github.com/makersacademy/course/blob/master/pills/node.md), which explains the concepts behind non-blocking I/O and callbacks. Also, [Why the hell would I use Node?](http://www.toptal.com/nodejs/why-the-hell-would-i-use-node-js) and [Convincing the boss](http://nodeguide.com/convincing_the_boss.html) are great articles on what Node is good for. 

Additionally, [this Node style guide](https://github.com/felixge/node-style-guide) will help you write code that is clear and readable. 

##What we will be covering

Node is a whole new environment, so we will be covering __a lot__ of ground in a short space of time. Don't worry if you feel lost at any point, as there is huge amount of information to take in. Also, you are working in a new, unfamiliar paradigm. Where possible, examples linking Node back to more familiar concepts in Ruby will be used.

Here is a broad outline of what we hope to cover this week:

* Setting up your Node environment/starting a project
* Unit testing with `jasmine-node`/Node modules
* Node good practices: `npm`, `grunt`, JavaScript linters
* Feature testing with `mocha` and Selenium/Webdriver
* Starting a web server with Express
* Websockets/`socket.io`

##Setting up your Node environment/starting a project

You should already have Node installed after completing the [Angular walkthrough](https://github.com/makersacademy/Walkthroughs/blob/master/angularjs.md). If not, install Node with `brew install node` and follow any additional instructions. 

There are many ways to start a Node project - [Yeoman](http://yeoman.io/) and [Express generator](http://expressjs.com/starter/generator.html) are fairly common tools for scaffolding entire web apps, to name but two. For a basic app or messing around with Node, this is total overkill. The simplest way, much like creating a Gemfile, would be to use a `package.json` file [(remember that from Angular?)](https://github.com/makersacademy/Walkthroughs/blob/master/angularjs.md#setting-up-our-test-environment) created with `npm init`.

Here's what we get if we run `npm init` in a folder called `starting-node` and follow the on-screen instructions, hitting enter every time:  

`package.json`  
```json
{
  "name": "start-node",
  "version": "1.0.0",
  "description": "",
  "main": "index.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "author": "",
  "license": "ISC"
}
```

Most of the contents of this `package.json` are fairly self-explanatory, but let's take a quick look at the `scripts` section.

`package.json`  
```json
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
    },
```

`"scripts"` is a collection of scripts that can be run with the `npm` command. This is fully customizable, but for now `npm init` provides a test script that can be updated as testing is added to the project. You can see how the scripts section behaves by running `npm test` - it should output: 

```shell
Error: no test specified
npm ERR! Test failed.  See above for more details.
```

Interesting, but not very useful. Let's start adding some testing tools so we can start playing with Node.

###Further resources
[What is the package.json?](https://docs.nodejitsu.com/articles/getting-started/npm/what-is-the-file-package-json)
[npm-init documentation](https://www.npmjs.org/doc/cli/npm-init.html)

##Unit testing with `jasmine-node`/Node modules

At this point, it's a good idea to create a `.gitignore` file and add `node_modules` to it, as we don't want to add our local dependencies to Git, and ultimately to Github.

Next, install `jasmine-node` (which is exactly what you think it is!), first locally to your dev-dependencies (`npm install --save-dev jasmine-node`), then, if you want, install it globally (`npm install -g jasmine-node`).

> _When should I install npm packages globally?_
> 
> Great question. As a rule of thumb, if you want to use a package as an executable anywhere (the way that you can just type `rspec` in any folder and it will try to run - try it!), install it globally. However, always make sure that ALL the dependencies for a given project are listed correctly in the `package.json` so that anyone can clone your repo and get up and running. You can either do this by editing the `package.json` manually (not recommended, humans make silly mistakes), or using `npm install --save [package]` or `npm install --save-dev [package]`. Also, if you set up any scripts or automation tools, using the local executable from the `node_modules/[package]/bin` folder means that other developers won't have to your dependencies globally.

Now we can start doing TDD in Node. Modify the `scripts` section of your `package.json` as follows:

`package.json`  
```json
  "scripts": {
    "test": "node_modules/jasmine-node/bin/jasmine-node spec/ --verbose"
    },
```

We can now run our tests using the command `npm test`, which will look for a `spec` folder. Create that, and then we can start writing some tests.

###Further resources
[jasmine-node](https://github.com/mhevery/jasmine-node)






[UNDER CONSTRUCTION]
##Node good practices: `npm`, `grunt`, JavaScript linters
##Feature testing with `mocha` and Selenium/Webdriver
##Starting a web server with Express
##Websockets/`socket.io`
