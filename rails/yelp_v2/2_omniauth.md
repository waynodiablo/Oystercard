# Section 2: OmniAuth login

OmniAuth allows a user to log in to your site using a 3rd party login such as Facebook, Twitter, Github or other trusted 3rd party. This avoids the need for the user to create a new login/password just for your site.  Omniauth is a particular implementation of 3rd party authentication which involves a callback process as shown in this diagram:

<center>
![OmniAuth login flow](http://3.bp.blogspot.com/-AkxYz8Ah9zA/T0rrsOVc0VI/AAAAAAAAIUI/GZUx5TbdecE/s1600/How+Omniauth+works.png)
</center>

For this example, we'll be adding a 'sign in with Facebook' link.

##### Register a Facebook Developer application

Create a [Facebook Developer application](http://developers.facebook.com), making note of the two keys you're given.

Before you go to the devise wiki, finish reading this whole section.

Go to the [Devise wiki](https://github.com/plataformatec/devise/wiki/OmniAuth:-Overview) to set up facebook authentication, ensuring you read the next section straight after about keeping your private details safe!

Note that Devise will add the link to Facebook sign-up automatically and you don't need to add the sign out to the config/routes (since Devise also does that), so you don't need to follow those steps on the wiki.

Under Settings => Advanced in your Facebook Developer dashboard, you need to add http://localhost:3000 as a valid redirect URI. Make sure the user logging in through facebook has privacy settings that permit their email to be viewed by 3rd parties.

##### Keeping secrets properly

The proper way of saving secrets is to abstract them out into a separate file.

Add your Facebook keys to the Rails `secrets.yml` file. They can then get called into the above code without needing to check them into version control. Call them using the following:

`Rails.application.secrets.[name_of_secret]`

**Never commit production secrets to public git repositories. Especially when using Amazon Web Services because *those secrets are linked to your credit card details*.** Be careful!

To avoid this, have your secrets.yml file pull in secrets from environment variables like so:

```yml
production:
  secret_key_base: <%= ENV["SECRET_KEY_BASE"] %>
  facebook_app_id: 12345678910987654321
  facebook_app_secret: <%= ENV["FACEBOOK_APP_SECRET"] %>
```
Then set these environment variables using the relevant shell commands.

If you accidentally commit secrets to your git repository, try following [this tutorial](https://help.github.com/articles/remove-sensitive-data/) - but be warned, it's not for the faint-hearted!

### Version 2 Complete!


### Related Videos

* [Devise/OmniAuth](https://www.youtube.com/watch?v=_nV4ENuO5QA)
* [Scaffold/Bootstrap](https://www.youtube.com/watch?v=pO7_fA2LeAk)


### [Next Section - Setting Limits on Users](../yelp_v3/1_user_must_log_in.md)
