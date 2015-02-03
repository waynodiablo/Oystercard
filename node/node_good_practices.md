#Node good practices 

[Video of session](https://www.youtube.com/watch?v=-EaT-6rGNqI)

##`npm`, `grunt` and JavaScript linters

##Grunt

###What is Grunt?
Grunt is a task runner, similar to `rake`. Grunt has some [really good documentation](http://gruntjs.com/getting-started) (which is rare in the land of JavaScript), so do check it out, but here is a condensed walkthrough to help get you set up.

First, install the Grunt-CLI tools with `npm install -g grunt-cli`. Then, install it locally for your project with `npm install --save-dev grunt`. 
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

###Tasks

There are two more plugins that you should try to get working: `grunt-contrib-jshint` and `grunt-contrib-watch`. Try to get these installed and working, as well as setting up separate tasks so that you can run each one individually, as well as having `jshint` and `jasmine-node` running when you only type `grunt`.

##JSHint and 'use strict'

JavaScript can be extremely temperamental, as you may have noticed(!!). Also, a lot of the code you will see online in tutorials is not very well written. But not all is lost! There are a few tricks you can use to ensure that your code meets certain standards, throws errors when expected and is a general pleasure to read and maintain. 

__JSHint__  
[JSHint](http://jshint.com/)  

__'use strict'__  
[JavaScript’s Strict Mode and Why You Should Use It](http://cjihrig.com/blog/javascripts-strict-mode-and-why-you-should-use-it/)  

__Node style__  
[Node style guide](https://github.com/felixge/node-style-guide)
