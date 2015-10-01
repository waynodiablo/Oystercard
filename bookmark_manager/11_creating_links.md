## Creating Links

[Back to the Challenge Map](0_challenge_map.md)

So our first feature test is passing, and we have a web app that displays the links in our database table.  However we have no way for a user to add any new links.  We'll need to add some functionality for this that corresponds to the following user story:

```
As a time-pressed user
So that I can find again the latest and greatest website I just found
I would like to add the link to my bookmark manager and have it appear in list of links
```
So naturally you'll be wanting to create a new feature test to drive the implementation of this functionality.

## Learning Objectives covered

* Week 3 learning objectives re-covered?? RESTful endpoints, GET vs POST?

## To complete this challenge, you will need to

- [ ] Add a new feature test called creating_links_spec.rb that uses a form to submit a new link
- [ ] Ensure it fails and take steps to fix it e.g.
  - [ ] Define get '/links/new' route in app.rb.
  - [ ] Create an associated view containing a form that POSTs to /links with the appropriate fields
  - [ ] Within app.rb, define a route for the form data to be submitted
- [ ] Discuss with your pair partner why do we POST to /links and not /links/new? And also why do we GET links/new?

## Resources

* [How to structure an HTML form](https://developer.mozilla.org/en-US/docs/Web/Guide/HTML/Forms/How_to_structure_an_HTML_form)
* [Representational State Transfer(REST)](https://en.wikipedia.org/wiki/Representational_state_transfer)

## [Solution](solutions/11.md)
