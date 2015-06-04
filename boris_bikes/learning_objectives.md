##Learning Objectives: Boris Bikes

*Learning Objectives are organised by topic. As you go down the bullet-point list below each topic header, skills become more advanced/involved. The section of the course that addresses a learning objective is appended to to each, in parentheses.*

######BDD
- Define BDD (intro)
- Explain how BDD works (intro)
- Explain how BDD and TDD are related (intro)

######Domain Modeling
- Define 'Domain' as the abstract area in which the problem is defined (0) [[Samm's brief introduction](http://blog.sjmog.co/2015/03/11/a-brief-introduction-to-domain-modelling/) *(reading)*, [Scaled Agile Framework: Domain Modelling](http://www.scaledagileframework.com/domain-modeling/) *(reading)*]
- Define 'class structure' (0) [[Samm's brief introduction](http://blog.sjmog.co/2015/03/11/whats-a-class-structure/)]
- Recall that a Domain Model describes key concepts in the domain and the relationships between them (0)
- Explain that defining the problem in plain English is a good first step to a Domain Model (0)
- Explain how to extract a Domain Model by analysing the nouns and verbs in a plain English description of the problem (0)
- Illustrate links between User Stories, Domain Models, and Class Structures

######RSpec
- Know what RSpec is (0)
- Know to use `_spec` in filenames if they include tests (3)
- Explain that RSpec provides a natural, English-like syntax (1)
- Explain how RSpec is a DSL (1)
- Explain why RSpec's syntax is helpful for developers (1)
- Fail an RSpec test (1)
- Debug code to pass an RSpec test (1)
- Use `describe`, `it`, and expectation syntax (2)
- Use `respond_to` syntax (2)
- Use RSpec implicitly-defined subject syntax (2)
- Use RSpec 'predicate' syntax
- Use RSpec 'context' syntax
- Select the lightest useful testing method (2)
- Assess when is appropriate to use RSpec's one-liner syntax (3)
- Analyse why sometimes tests pass when it seems like they shouldn't (3)
- Evaluate the difference between RSpec failures and Ruby errors (3)
- Refactor tests (3)

######Doubles
- Define doubles as a kind of 'stunt stand-in' for objects in testing (2)
- Explain that doubles are useful to avoid interacting with 3rd-party services (2)

######TDD
- Know what an 'acceptance' (or 'feature') test is (intro)
- Know what an 'integration' test is (1)
- Know what a 'unit' test is (intro)
- Explain that starting with tests helps us to avoid going mad (1)
- Organise a spec-driven filesystem (1)
- Set up a unit test (3)
- Link RSpec failures to progress in TDD (2)
- Assess which properties to implement into objects using TDD as a guide (3)
- Move between unit and feature tests (3)
- Analyse why code should be written in a TDD manner (3)
- Analyse why passing tests does not guarantee fully-working code (3)

######Debugging
- Define a 'stack trace' (3)
- Explain how to use a stack trace to debug errors (3)
- Debug errors using a stack trace (3)

######OOP
- Define OOP (intro)
- Explain that OOP allows us to write more flexible code (intro)
- Explain why modular code is useful for future code maintainers (intro)

######Agile
- Define an 'Agile' process (intro) [[Wikipedia](http://en.wikipedia.org/wiki/Agile_software_development) *(reading)*, [Agile Manifesto Principles](http://agilemanifesto.org/principles.html) *(reading)*]
- Explain how to apply Agile methodology to development (intro) [[Scrum Reference Card](http://scrumreferencecard.com/scrum-reference-card/) *(reading, visual)*]
- Differentiate between BDUF, NDUF, and EDUF [[Samm's brief introduction](http://blog.sjmog.co/2015/03/12/software-design-up-front-how-much/)]
- Work in an Agile way (0 onwards)
- Link Agile methodology and TDD (1 onwards)
- Evaluate why Agile methodology is so popular

######Pair Programming
- Define 'pair programming', 'driver', and 'navigator' (intro)
- Explain why pair programming is so useful in development (intro)
- Use pair programming techniques (0 onwards)
- Argue for why pair programming is often better for code quality than solo programming
- Evaluate how pair programming with a new partner every day has developed their proficiency in other topics, and more generally

######Style Guides
- Give an example of a style guide (intro)
- Recall that it is better to write self-explanatory code than fill code with comments (1)
- Install and run RuboCop (1)
- Analyse why 'linters' like RuboCop are useful when developing (1)
- Correct style violations (1)

######User Stories
- Recall the structure of a user story (intro) [[Wikipedia](http://en.wikipedia.org/wiki/User_story) *(reading)*, [Agile Modelling: User Stories Introduction](http://www.agilemodeling.com/artifacts/userStory.htm) *(reading)*]
- Elicit user stories from clients (intro)
- Select high-value user stories (1)

######Interfaces
- Define an interface as a way to interact with a system (1)
- Recognize that IRB is an interface (1)

######Setting up a project
- Recall how to set up a simple project (0)
- Explain why a complete README is important (0)
- Initialize and push a git project (0)

######MVP
- Define an MVP as a Minimum Viable Product (1)
- Explain that an MVP is the minimum set of operating features for a client to test a business model (1)

######Ruby
- Know to include files in other files using `require` (2)
- Outline Ruby convention for `require` (2)
- `require` a file in another (2)
- Differentiate between `require` and `require_relative` (3)
- `require_relative` one file into another (3)

### Activities
* Use BDD/TDD and pair programming together to create a simple model of the Boris Bikes problem in Ruby.
* Use BDD/TDD and solo programming to approach a slightly more complex model (e.g. Airports) which requires wider use of doubles.


Weekly Challenge
===========

## Airport

**Learning Objectives**

* Simple OOD and OOP creating and linking at least two objects via composition
* Mocking random behaviour effectively in order to ensure consistent and reliable tests
* Test driven development (TDD)


## Tube

**Learning Objectives**

* Simple OOD and OOP creating and linking at least two objects via composition
* Writing effective tests, i.e. doing TDD
