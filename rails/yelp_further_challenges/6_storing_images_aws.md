#  Bonus Section 6: Uploading images to Amazon Web Services S3

So far we've got images being saved straight to your web server – which is okay, and certainly fine for testing, but in practice may not be what you'd do. For example, Heroku has a strict size limit on dynos, which you'll quickly exceed if you upload files directly onto Heroku. So we want to store images somewhere else.

For this, we'll use Amazon Web Services (AWS) **S3**, which stands for **Simple Storage Service**.

Getting Paperclip to work with S3 is pretty well documented in [this Heroku tutorial](https://devcenter.heroku.com/articles/paperclip-s3). We'll give you the choice parts here.

##### Sign up for AWS

An obvious first step. [http://aws.amazon.com](http://aws.amazon.com) is probably where you want to be looking.

##### Install the gem

AWS has a gem (of course), so let's start by installing that.

`Gemfile`:

```ruby
gem 'aws-sdk'
```

Now run `bundle install`.

##### Setting AWS environment vars

We need to tell Paperclip what our AWS keys are. First we add references to some environment variables that we'll set in a moment:

`config/environments/production.rb` and `config/environments/development.rb`:

```ruby
config.paperclip_defaults = {
  :storage => :s3,
  :s3_credentials => {
    :bucket => ENV['S3_BUCKET_NAME'],
    :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
    :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
  }
}
```

What we're doing here is setting environment variables so we don't have to store our AWS secrets naked in a configuration file – which is checked into version control and visible to the public internet. That would be **a Very Bad Thing**.

You will need to check your S3 hostname is set correctly if you are on a non-US server.



##### Deploying to Heroku

Ideally you've been deploying to Heroku as you've added each new piece of functionality.  Heroku deploys are a lot smoother than what we had to do back in the day but they can have tricky issues.  In particular features that require secret keys for 3rd party services may take a few goes to deploy successfully and securely. Here's some hints to help you on your way:


Unfortunately we can't use secrets.yml on Heroku, instead we need to manually tell Heroku about our secret variables, for example in the case of getting AWS working we would do:

```shell
$ heroku config:set S3_BUCKET_NAME=your_bucket_name
$ heroku config:set AWS_ACCESS_KEY_ID=your_access_key_id
$ heroku config:set AWS_SECRET_ACCESS_KEY=your_secret_access_key
```
This will set these values to the ENV hash.

You can use gems such as [Figaro](https://github.com/laserlemon/figaro) or [Dotenv](https://github.com/bkeepers/dotenv) to manage your secrets rather than `secrets.yml`
##### Deploy

Commit, run `git push heroku master` and watch as your users are able to upload items and have them saved on S3!

However you will still need to find a way to get all of the values in your secrets.yml file working with Heroku which uses ENV variables instead. Remember to be careful not to expose any of your secrets!

## Related Videos

* [Rails Ajax and AWS](https://www.youtube.com/watch?v=OIjiJotzTnA)

## End of Bonus Section!
