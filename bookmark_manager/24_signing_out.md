## Signing Out

[Back to the Challenge Map](0_challenge_map.md)

You now have a fully functioning signup and sign in mechanism. In order to allow the
use of multiple accounts on the same browser in this challenge you will allow users to sign out.

## Learning Objectives covered

* Construct a form for signing in ('authenticating') a user
* Use session to manage a user's authenticated state
* Create a basic registration/authentication system from scratch

## To complete this challenge, you will need to

- [ ] Write a failing feature test that checks that:
  - [ ] A user can sign out
  - [ ] A goodbye message is displayed on signing out
  - [ ] The user is redirected to `/link`
- [ ] Extract the `sign_in` and `sign_out` methods into a helper module and include it
in your spec helper
- [ ] Ensure to test manually locally and on Heroku

## Resources

* [DELETE method with Sinatra](http://stackoverflow.com/questions/5166484/sending-a-delete-request-from-sinatra)
* [Sinatra Configuration](http://www.sinatrarb.com/configuration.html)
* [RSpec helper modules](https://www.relishapp.com/rspec/rspec-core/docs/helper-methods/define-helper-methods-in-a-module)
* [Sinatra Flash](https://github.com/SFEley/sinatra-flash)


## [Solution](solutions/24.md)
