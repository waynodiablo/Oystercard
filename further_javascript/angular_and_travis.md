#Angular and Travis CI

Getting Angular tests to work on Travis can be difficult - here's a basic guide to set up CI.

1. Follow the instructions [here](http://karma-runner.github.io/0.8/plus/Travis-CI.html) to get your Karma tests running. The command there is a bit weird - it should be pointing to `./node_modules/karma/bin/karma`. Make sure that you are pointing Karma at `karma.conf.js`. Make sure that running `npm test` locally runs your tests correctly.
2. Make sure your `npm start` command starts your server correctly - we will be using this later on.
3. Sign up for [Sauce Labs](https://saucelabs.com/signup). Make sure you pick the Open Sauce pricing level!
4. Start following the instructions on [this page](https://docs.saucelabs.com/ci-integrations/travis-ci/) VERY CAREFULLY
5. Create a e2e script in your `package.json` which will run your Protractor tests - make sure this works locally. Make sure Protractor is in your dependencies.
6. Add a `before_script` to your `.travis.yml` - it needs to start your server in the background (the & runs scripts in the background):

```yml
before_script:
  - npm start &
  - sleep 3
```

7. Add a postinstall script to your `package.json` that installs Bower
8. Bower will install to your root folder by default: if you have a `public` folder, you need to install there. This can be controlled using a `.bowerrc`.
9. Add, commit and push.
10. Cross fingers.
