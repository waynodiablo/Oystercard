#Grunt

:construction: UNDER CONSTRUCTION :construction:

Many thanks to [Spike](http://github.com/Spike01) for the original design this component

Grunt is a task runner, similar to `rake`. Grunt has some [really good documentation](http://gruntjs.com/getting-started) (which is rare in the land of JavaScript), so do check it out, but here is a condensed walkthrough to help get you set up.

First, install the Grunt-CLI tools with:

```sh
npm install -g grunt-cli
```

Then, install it locally for your project with 

```sh
npm install --save-dev grunt
```

Now, we need a Gruntfile. These are just like a Rakefile, and live in the root directory of your project. To begin with, we will be building a Gruntfile that runs our `jasmine-node` tests. For this, we will need to install the relevant Grunt plugin, `grunt-jasmine-node`. Install that into your dev-dependencies and let's have a look at the insides of the Gruntfile we will be building. 

`Gruntfile.js`
```javascript
module.exports = function(grunt){

  grunt.initConfig({
    jasmine_node: {
      options: {
        forceExit: true,
      },
      all: ['spec/']
      }
  });

  grunt.loadNpmTasks('grunt-jasmine-node');

  grunt.registerTask('default', ['jasmine_node']);

};
```

This Gruntfile will run `jasmine-node` every time you type `grunt`. 

##Tasks

* Try repeating the above steps from memory (Athletic Reps)
* Get the `grunt-contrib-jshint` module working and set up a separate task so you can run each one individually
* Get the `grunt-contrib-watch`  module working and set up a separate task so you can run each one individually
* Have the above and `jshint` and `jasmine-node` run when you only type `grunt`.