# Understanding **self**, the current/default object

One of the cornerstones of Ruby programming—the backbone, in some respects—is the default object or current object, accessible to you in your program through the keyword _self_. 

At every point when your program is running, there is **one and only one** self.

## Who gets to be self, and where

There is always one (and only one) current object or self. You can tell which object it is by following a small set of rules. These rules are summarised in table 1.1.

To know which object is self, you need to know what context you’re in.

Table 1.1 How the current object (self) is determined

![Table 1.1](/pills/images/table_1-1.png)

## Resources

- [Self in Ruby](http://www.jimmycuadra.com/posts/self-in-ruby)

![Tracking pixel](https://githubanalytics.herokuapp.com/course/pills/self.md)
