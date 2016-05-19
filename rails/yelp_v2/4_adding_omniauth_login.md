#### Adding OmniAuth login

Omniauth allows a user to log in to your site using a 3rd party login such as Facebook, Twitter, Github or other trusted 3rd party. This avoids the need for the user to create a new login/password just for your site.  Omniauth is a particular implementation of 3rd party authentication which involves a callback process as shown in this diagram:

<center>
![Omniauth login flow](http://3.bp.blogspot.com/-AkxYz8Ah9zA/T0rrsOVc0VI/AAAAAAAAIUI/GZUx5TbdecE/s1600/How+Omniauth+works.png)
</center>

For this example, we'll be adding a 'sign in with Facebook' link.

##### Setting up Facebook authentication

Go to the [Devise wiki](https://github.com/plataformatec/devise/wiki/OmniAuth:-Overview) to set up facebook authentication, ensuring you have worked through [3_keeping_secrets](3_keeping_secrets.md) and are keeping your private details safe! Be aware that you will also need to consider the scope of permissions you are requesting from the user. [Omniauth-facebook](https://github.com/mkdynamic/omniauth-facebook) has good information on scope in its README.

Note that Devise will add the link to Facebook sign-up automatically and you don't need to add the sign out to the config/routes (since Devise also does that), so you don't need to follow those steps on the wiki.

Under Settings => Advanced in your Facebook Developer dashboard, you need to add http://localhost:3000 as a valid redirect URI. Make sure the user logging in through facebook has privacy settings that permit their email to be viewed by 3rd parties.
