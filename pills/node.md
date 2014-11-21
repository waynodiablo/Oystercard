# Introduction to Node

Node is one of the newest technologies on offer at Makers Academy. One of the first things you are likely to hear about Node.js is that it allows you to "build fast, scalable network applications" using Javascript on the server side.

This means that if you choose the path of Javascript, you can become full-stack with a single language. function(){} ftw!

### Blocking vs Non-Blocking Code

Officially described as an "asynchronous event driven framework", Node is able to handle many connections concurrently. However, something that can seem surprising about Node is that it is not multi-threaded. It is in fact a single-threaded, event based technology . To understand the difference, allow me to make an analogy which should make sense to all of us living here in London...

Imagine you're at Old Street Station, and it's a busy Monday morning. Copious amounts of commuters are all lined up waiting to tap out with their Oyster cards, and reach the surface ready to start their day. Now, in a thread-based methodology when someone gets to the barrier and they start to look for their Oyster card, everyone has to wait behind that person before they can progress to the barrier. That person is __blocking__ everything else until they can sort their life out and find their Oyster card. Then imagine they pass their card over the reader and the light turns red, the barriers remaining in place... Everyone is still waiting as that person tries to tap out again and again before accepting the fact that they might have to go seek the help of an attendant.

In a __non-blocking__ model, when that person gets to the barrier and realises they don't know where their Oyster card is (it's in the front pocket of their bag) they immediately step out of line, go to the side and look everywhere for it. Then upon relocating their card, they get back in line, and await their turn before tapping out successfully. But say there is a problem and their card is not recognised? Well again, they step out from in front of the barriers immediately, and line up for the attendant who is more suitable to process their request.

If you wanted to scale the first example (i.e. if you wanted it to be able to handle more traffic), then you would need to invest in more ticket barriers. And perhaps some work would need to be done to increase the space available to place those ticket barriers. It would take a long time, be costly and inefficient on space. In computing terms, you would have to create additional copies of the server, which is where the name thread-based comes from (as each copy tends to require another operating system thread.)

However, in an event based scenario like the second example, it would be a lot easier to scale, as the way your ticket barriers and commuters requesting passage are working together to streamline the process. You could still add more barriers, but you would need far less to equal or surpass the efficiency of the initial example. In computing terms, your web server is constantly accepting requests as it's not waiting for any read or write operations, which makes for a much more efficient service.

#### An aside on Callbacks:

While chatting about this subject with a [very astute student](https://github.com/yvettecook), a good analogy of callbacks came into being: Have you ever been to a restaurant/bar where you are given a small device to accompany you while you have a drink and wait for your table? Halfway through your second Long Island Iced Tea, you get the fright of your life as said device springs to live in a whir of vibration and flashing lights- signalling that your table is ready for you to continue your dining experience (so please report to a member of the waiting staff to be seated.)

In this case, you have a function called __eatAtRestaurant__ and as an argument, you pass a second function called __tableForTwoPlease__ which is necessary for __eatAtRestaurant__ to complete successfully. That annoying little thing with the flashing lights is the message sent to the calling function (__eatAtRestaurant__) to let you know that __tableForTwoPlease__ has been processed.

[Video on NodeJS by Spike](https://vimeo.com/110240527)

Resources
---------

* [Node Patterns](https://github.com/nodebits/distilled-patterns)
* [Module Patterns](http://darrenderidder.github.io/talks/ModulePatterns/#/)
* [Interface Design Patterns for Node](http://bites.goodeggs.com/posts/export-this/)
* [NodeJS Handbook](https://github.com/FredKSchott/NodeJS-Handbook)
* [JavaScript SOLID Principles](https://www.youtube.com/watch?v=TAVn7s-kO9o)
* [Single Responsibility (JavaScript)](http://freshbrewedcode.com/derekgreer/2011/12/08/solid-javascript-single-responsibility-principle/)
* [Open Closed (JavaScript)](http://aspiringcraftsman.com/2011/12/19/solid-javascript-the-openclosed-principle/)
* [Leo's Test-Driven Chat Site](https://github.com/pitchinvasion/node-mocha)


