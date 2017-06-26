# Splitting Epics into User Stories

Remember you typically are looking to develop slices of a business opportunity that produces valuable working software with the potential to generate feedback from users.
 
 Sometimes the story slices are not deliverable to end-users but they generate value from the learning gained in producing them. They should all result in testable and demonstrable software. Consider applying the XP principle DTSTTCPW (“Do The Simplest Thing That Could Possibly Work”)

Here are some useful questions to consider when trying to slice stoties apart.

What are the visual elements that must be there or can be deferred ?
  * You can make a simple (not pretty) UI.
  * You can make a command line interface.
  * You can make a story for each step on a user journey.
  * You can make a separate story for each component and input field rendered.

What scenarios are in scope for acceptance/feature tests?
  * You can defer conditional paths to other stories.
  * You can defer data validation.
  * You can defer error handling.

What architecture decisions or constraints that can be left until later on?
  * You can defer optimising performance/speed.
  * You can defer internationalisation/accessibility.
  * You can defer support for different platforms / devices
  * You can defer handling large volumes of data.
  * You can hard-code data rather than getting from the real source.
  * You can stub out components.

This is not an exhaustive list! Be creative in your story splitting approach.

Some blogs about this:

   * [Bill Wake](http://xp123.com/articles/twenty-ways-to-split-stories) 
  * [Rachel Davies](http://agilecoach.typepad.com/agile-coaching/2010/09/ideas-for-slicing-user-stories.html)
  * [Richard Lawrence](http://www.richardlawrence.info/2009/10/28/patterns-for-splitting-user-stories)
  * [James Grenning](http://blog.wingman-sw.com/archives/48)
  * [George Dinwiddie](http://idiacomputing.com/pub/UserStories.pdf)
  * [Joe Rainsberger](http://www.jbrains.ca/permalink/how-youll-probably-learn-to-split-features)
  * [Stephen Thomas](http://agile-management.com/wordpress/splitting-user-stories)
  * [Mark Levison](http://agilepainrelief.com/notesfromatooluser/2010/09/story-slicing-how-small-is-enough.html) [and this](http://agilepainrelief.comnotesfromatooluser/2010/12/more-notes-on-story-splitting.html)
  * [Martin Fowler](http://martinfowler.com/bliki/ConversationalStories.html)

Some books about this:

  * User Story Mapping by Jeff Patton
  * Fifty Quick Ideas to Improve your User Stories by Gojko Adzic and David Evans