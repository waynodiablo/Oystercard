## Creating Links

[Back to the Challenge Map](00_challenge_map.md)

So our first feature test is passing, and we have a web app that displays the links in our database table.  However we have no way for a user to add any new links.  We'll need to add some functionality for this that corresponds to the following user story:

```
As a time-pressed user
So that I can save a website
I would like to add the site's address and title to my bookmark manager
```
So let's create a new feature test to drive the implementation of this functionality.

## Learning Objectives covered

* Week 3 learning objectives re-covered?? RESTful endpoints, GET vs POST?

## To complete this challenge, you will need to

- [ ] Add a new feature test called creating_links_spec.rb that uses a form to submit a new link
- [ ] Ensure it fails and take steps to fix it:
  - [ ] Define a route, `get '/links/new'`, to serve a form for creating a new link
  - [ ] Create an associated view containing the form
  - [ ] Define a route, `post '/links'` to receive the form data
- [ ] Discuss with your pair partner why do we POST to /links and not /links/new? And also why do we GET links/new?

## Resources

* [How to structure an HTML form](https://developer.mozilla.org/en-US/docs/Web/Guide/HTML/Forms/How_to_structure_an_HTML_form)
* [Representational State Transfer(REST)](https://en.wikipedia.org/wiki/Representational_state_transfer)

## [Solution](solutions/11.md)
