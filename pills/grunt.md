#Grunt

:construction: UNDER CONSTRUCTION :construction:

Many thanks to [Spike](http://github.com/Spike01) for the original design of this component

Grunt is a task runner, similar to `rake`. Grunt has some [really good documentation](http://gruntjs.com/getting-started) (which is rare in the land of JavaScript), so do check it out, but here is a condensed walkthrough to help get you set up.

First, install the Grunt-CLI tools with:

```sh
npm install -g grunt-cli
```

Then, install it locally for your project with 

```sh
npm install --save-dev grunt
```

Now, we need a Gruntfile. These are just like a Rakefile, and live in the root directory of your project. To begin with, we will be building a Gruntfile that runs `jshint`. For this, we will need to install the relevant Grunt plugin, `grunt-contrib-jshint`. Install that into your dev-dependencies and let's have a look at the insides of the Gruntfile we will be building. 

`Gruntfile.js`
```javascript
module.exports = function(grunt){

  grunt.initConfig({
    jshint: {
      all: ['Gruntfile.js', 'src/**/*.js', 'spec/**/*.js']
    }
  });

  grunt.loadNpmTasks('grunt-contrib-jshint');

  grunt.registerTask('default', ['jshint']);

};
```

This Gruntfile will run `jshint` every time you type `grunt`. 

##Tasks

* Try repeating the above steps from memory (Athletic Reps)  
* See what the rest of the JS community is using Grunt to automate, and discuss why you would or wouldn't want to use Grunt.  
* Get the `grunt-contrib-watch` module working so that JSHint runs automatically every time you save.  
* See if you can set up `grunt-contrib-jasmine` to run your client-side Jasmine tests.  
* Modify your default task to run both JSHint and Jasmine.  
