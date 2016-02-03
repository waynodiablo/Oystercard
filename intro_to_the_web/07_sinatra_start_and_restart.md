# Sinatra: Start and Restart

[Back to the Challenge Map](00_challenge_map.md)

So far we've defined a single route, '/', that responds with a HTTP message containing "hello!".

In this challenge you will add a second route. By adding a second route we will see that routes, distinct entry points to an application, activate different server actions and so return different responses.

Additionally, we will use **shotgun** to speed up our development process.

### Learning Objectives covered
- Define a route in Sinatra
- Use Shotgun

### To complete this challenge, you will need to:

- [ ] Define a second route, `get '/secret'`. Have it respond with a message of your choosing.
- [ ] Visit the new route in the browser. Do you see the message you wrote? If not, move on.
- [ ] Kill the app on the command line with `ctrl-c` and run it again.
- [ ] Visit the new route in the browser again. Do you see the message you wrote this time?
- [ ] Manually restarting the server every time you change your code is going to get painful. Install and run your server using the `shotgun` gem instead.
- [ ] Define a few more routes. Without killing the server, check if the routes are visitable.

### Resources

- [Shotgun (Github)](https://github.com/rtomayko/shotgun)
- [Sinatra Main Intro Documentation](http://www.sinatrarb.com/intro.html)

### [Walkthrough](solutions/07_sinatra_start_and_restart_solution.md)
