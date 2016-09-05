# Section 3: Keeping Secrets

In the subsequent section, we will be using OmniAuth to enable sign-in through an external service. The first stage will be to set up an application and obtain an API key. The proper way of saving secrets is to abstract them out into a separate file.

* Create a [Facebook Developer application](http://developers.facebook.com), making note of the two keys you're given.

Add your API keys to the Rails `secrets.yml` file. They can then get called into our code without needing to check them into version control. You will be able to call them using the following:

`Rails.application.secrets.name_of_secret`

**Never commit production secrets to public git repositories. Especially when using Amazon Web Services because *those secrets are linked to your credit card details*.** Be careful!

* To avoid this, have your secrets.yml file pull in secrets from environment variables like so:

```yml
production:
  secret_key_base: <%= ENV["SECRET_KEY_BASE"] %>
  facebook_app_id: 12345678910987654321
  facebook_app_secret: <%= ENV["FACEBOOK_APP_SECRET"] %>
```

Then set these environment variables using the relevant shell commands.

If you accidentally commit secrets to your git repository, try following [this tutorial](https://help.github.com/articles/remove-sensitive-data/) - but be warned, it's not for the faint-hearted!

### [Next Stage - Adding omniauth login](4_adding_omniauth_login.md)
