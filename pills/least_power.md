The Least Power Principle
=========================

Some Ruby concepts from least to most powerful:

1. nil
2. boolean (true/false)
3. :symbol
4. 'string'
5. "string"
6. array []
7. hash {}
8. nested array/hashes
9. object
10. collections of interacting objects
11. composition
12. mixins
13. inheritance

Attr_* from least to most powerful:

1. attr_reader
2. attr_writer
3. attr_accessor

Wherever possible you should prefer the items with lower power to avoid uneccessary complexity.  Don't use a tool any more complex than you need, unless you really are getting something from it, such as special flexibility that you are pretty damn sure is going to support delivering value to the client.


![Tracking pixel](https://githubanalytics.herokuapp.com/course/pills/least_power.md)
