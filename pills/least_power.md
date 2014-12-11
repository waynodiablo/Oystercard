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
10. collections of interactions objects
11. composition
12. inheritance

Attr_* from least to most powerful:

1. attr_reader
2. attr_writer
3. attr_accessor

Wherever possible you should prefer the items with lower power to avoid uneccessary complexity
