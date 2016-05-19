| [← Yelp V1](yelpv1.md) | [Yelp home](yelp.md) | [Yelp V3 →](yelpv3.md) |
|------------------------|----------------------|-----------------------:|

# Yelp

***As you know, as with all Makers Academy materials, there may be subtle errors in the following code snippets.  Please try to approach those as challenges on which to polish your debugging skills - pull requests always welcome.***

### V2 Walkthrough

- [Installing Devise](yelp_v2/1_installing-devise.md)
- [Adding links to log in and out](yelp_v2/2_adding_links_log_in_out.md)
- [Keeping secrets properly](yelp_v2/3_keeping_secrets.md)
- [Adding OmniAuth login](yelp_v2/4_adding_omniauth_login.md)

***Please work through this walkthrough with a pair partner. Please take turns on the keyboard as the driver as described in the [pairing pill](pills/pairing.md) :pill:.   Please swap driver/navigator roles at least as often as you see the :twisted_rightwards_arrows: sign.***

In this version, we want to add user login. In Sinatra, this requires you to manually add a User model, and then create all the usual controller routes – for login, logout, signing up and so on. How tedious.

Rails has a gem that does all of that for you – [Devise](https://github.com/plataformatec/devise). It handles building a user model, routes for your users controller, and even fancy things like OAuth (which handles those 'Log in with Facebook'-type buttons).

### Related Videos

* [Devise/OmniAuth](https://www.youtube.com/watch?v=_nV4ENuO5QA)
* [Scaffold/Bootstrap](https://www.youtube.com/watch?v=pO7_fA2LeAk)
