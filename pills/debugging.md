Debugging
=========

:construction: UNDER CONSTRUCTION :construction:

The process of debugging - breaking the problem down to isolate the cause of the problem.  Assuming that you have isolated what data is going in and what is supposed to come out, you can tell when you are getting the wrong thing out.  This is what your tests are for.

However, there may be many steps of data transformation inbetween the initial method call or user interface click and the final data out, or response from the system.  In general you want to work down from your more comprehensive feature tests that are checking things end-to-end, down through integration tests and then to unit tests to try and isolate the particular step that is failing.

Wrapping new tests around smaller parts of the system is a good way to go, but you can also try to:

1) Printing things out at particular points in the code using 'puts' or 'pp' or similar (e.g. console.log in JavaScript)

2) Use a debugger to stop the execution of the code at some point, ideally driven by a test

Whether you are printing data out, or using a debugger, fundamentally you are just trying to break the data transformation down into smaller and smaller steps to isolate the point at which something is going wrong.

In Ruby [byebug](https://github.com/deivid-rodriguez/byebug) is a great debugging tool, and in JavaScript the Chrome development tools.  See the resources below for more specifics.

Resources:
---------

* [How to use byebug in Ruby](https://github.com/deivid-rodriguez/byebug/blob/master/GUIDE.md)
* [How to use the Chrome debugger for JavaScript](https://developer.chrome.com/extensions/tut_debugging)
