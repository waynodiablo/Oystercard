#npm

:construction: UNDER CONSTRUCTION :construction:

npm is a node based package manager, that will help you to organise and version control Node Packages on your machine and in your projects.

npm is the node package manager, the equivalent of 'bundle' from the Ruby world.  Node packages function in a similar way to Ruby's Gems. Check out the [npm web site](https://www.npmjs.com/) to see the trending node modules - there are now [more node modules that Ruby gems](http://www.modulecounts.com/)!

It is possible to install a package globally (i.e. to make a command available to you on the command line), locally within a project, and locally within a dev environment.

npm is installed by default when you install node, however the version updates more frequently than node, so you should update to the latest version. The [documentation](https://docs.npmjs.com/) will point you in the right direction.

##Starting a project with npm

If you haven't already, install Node with `brew install node` and follow any additional instructions.  Note that this can cause problems if you already have a node version manager (e.g. n, nvm, nodenv) installed.  Please contact a coach or alumni helper if you are having trouble with your node install.

There are many ways to start a Node project - [Yeoman](http://yeoman.io/) and [Express generator](http://expressjs.com/starter/generator.html) are fairly common tools for scaffolding entire web apps, to name but two. For a basic app or messing around with Node, this is total overkill. The simplest way, much like creating a Gemfile, would be to use a `package.json` file created with `npm init`.

Here's what we get if we run `npm init` in a folder called `temp` and follow the on-screen instructions, hitting enter every time:

`package.json`
```json
{
  "name": "temp",
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

To install a package into your project, for instance if you wanted to use a package called hapi in your application, you would use ``` npm install hapi --save ```. The --save option tells npm to install the package into the project inside a folder called node_modules, and will also update your package.json. 

If you want to install a package that is needed by anyone developing your app, but is not needed to run the app, then you have another option. For example, if you wanted to use the test framework 'jasmine-node', you would enter ``` npm install jasmine-node --save-dev ```. The --save-dev option will save the files to your node_modules and update the package.json with the new dev-only dependencies.

As a rule of thumb, if you want to use a package as an executable anywhere (the way that you can just type `rspec` in any folder and it will try to run - try it!), install it globally. However, always make sure that ALL the dependencies for a given project are listed correctly in the `package.json` (by using ``` npm install --save ``` or ``` npm install --save-dev ```) so that anyone can clone your repo and get up and running. Also, if you set up any scripts or automation tools, using the local executable from the `node_modules/[package]/bin` folder means that other developers won't have to have your dependencies globally.

Your package.json should now look like this:

``` json
{
  "name": "temp",
  "version": "1.0.0",
  "description": "",
  "main": "index.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "author": "",
  "license": "ISC",
  "dependencies": {
    "hapi": "^8.4.0"
  },
  "devDependencies": {
    "jasmine-node": "^1.14.5"
  }
}

```

Finally, add your node_modules folder to your .gitignore file, to avoid clogging up your repo with external files. This means that when working in a team, it is important for every member of your team to run the command ``` npm install ``` from the top level directory of your project - this will then install all the packages as described in the package.json, in a similar way to running bundle in a ruby project.

###Further resources
* [What is the package.json?](https://docs.nodejitsu.com/articles/getting-started/npm/what-is-the-file-package-json)
* [npm-init documentation](https://www.npmjs.org/doc/cli/npm-init.html)
