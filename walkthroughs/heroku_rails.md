Heroku
========

***UNDER CONSTRUCTION***

To deploy to a Rails app to heroku (a service that provides online hosting of Rails and Sinatra apps, amongst other things)

* add everything into git and commit

```
git add --all .
git commit -m 'pushing to heroku'
```
* get things onto heroku by creating an instance on heroku

```
heroku create instagramay
```

* then push to heroku via git

```
git push heroku master
```

* For Rails, one failure you might encounteris that Devise.secret_key was not set, in which ccase

  * in config/initializers/devise.rb activate the secret key
  * use bin/rake secret to generate a secret key

It's good to do that for production secret base key (could just be a random string), however still have the problem of not wanting keys pushed to heroku via git - official solution is to use environment variables, but that can get tedious so let's use this gem which we should add to our gem file. 

```ruby
gem 'heroku_secrets', github: 'alexpeattie/heroku_secrets'
```

Then do the following:

```sh
bundle
git add .; git commit -m 'adding heroku secrets'; git push heroku master
```

The first push will always be the slowest - loading libraries, compiling assets, doing minification. Once completed you can do:

```sh
heroku open
```

You may see an internal server error, and in the logs you may then see a missing 'secret_key_base' for production environment:

```sh
heroku logs
```

set this value in config/secrets.yml, and then the following will set the environment variables on heroku without going through git

```bin/rake heroku:secrets RAILS_ENV=production``` 

* now `heroku open` will give a different error

* note: makersacademy-website as example of keys not being shared over github

* user `heroku logs --tail` to check for error - message not very helpful here

* here we'll need rails12_factor

```ruby
group :production
  gem 'rails12_factor'
end 
```

* add to git and then push to heroku
* now get PG::Undefined Table error from `heroku logs --tail`
* so need to `heroku run rake db:migrate`
* now heroku open should give us a working app
* maybe get error with uploading images - check logs
* heroku config to check secrets

* run `bin/rake heroku:secrets RAILS_ENV=production` to deploy again as necessary

* note fingerprints to application.js - which ensures that we always fetch the latest version of application.js since fingerprint changes when code changes	


 


![Tracking pixel](https://githubanalytics.herokuapp.com/course/walkthroughs/heroku_rails.md)
