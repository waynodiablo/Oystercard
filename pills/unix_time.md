
Unix Time
=========

Note that we can easily find out how many seconds it has been since 1st January 1970:

```sh
date +%s
1417007848
```

This is UNIX time.  Also called the [epoch time](http://en.wikipedia.org/wiki/Unix_time).  Note in Javascript that a new Date is falsey because it is zero, while every other date after 1st Jan 1970 is truthy.


![Tracking pixel](https://githubanalytics.herokuapp.com/course/pills/unix_time.md)
