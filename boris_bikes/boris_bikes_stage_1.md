## Stage 1: Implementing Our First User Story

***As with all Makers Academy materials, there may be subtle errors in the following materials.  Please try to approach these as challenges on which to polish your debugging skills - pull requests always welcome.***

We cannot possibly implement all functionality at once. We need to start somewhere and then increase the number of features until we are happy.  We'll often talk about a Minimum Viable Product (MVP) which is the minimum set of operating features needed for the client to test their business model, but before that we need to start with a single user story.  Which user story is the most likely to take us towards an MVP? What is the absolute minimum we could implement but still provide some value to the end user? Our first user story sounds promising:

```
As a member of the public,
So that I can get across town,
I'd like to get a working bike from a docking station.
```

It's interesting to reflect that one could imagine a version of the boris bikes system that had no code or infrastructure at all.  There could simply be places where bikes could be left unlocked.  Bike rental would be free, and bikes would be returned or not on an honour policy.  One might argue that in London that would soon lead to all the bikes being stolen or broken, and so some system for managing fees and repairs and so forth was essential.  An honour-based Boris Bikes system might seem like a joke, but it's excellent practice to check your assumptions.  Could what the client wants be delivered without writing a line of code?  Every line of code you write is a line of code that you may have to maintain in future. Every line of code you write now will support certain features that the client currently wants, but the client may change their mind, or the market may evolve, or who knows what?

To a certain extent you want to hold off writing any code for as long as possible, ensuring that you and your client agree on which user stories deliver value, and then pick the simplest one and exert the minimum effort to support it.

As regards our user story, or feature, above, let us assume that we are going to have some way of delivering a working bike to a user.  In the real Boris Bike's system this might involve a real person entering their credit card, validation via an online payment gateway and the unlocking of a physical lock to allow a bike to be removed from a real docking station.  In this tutorial let us assume that the interactive ruby (`irb`) environment is our *user interface*, and so if someone can type in something like `docking_station.release_bike` and we can check that a working bike is released, then this corresponds to the high-level feature we are looking for.  Something like this:

```sh
$ irb
2.0.0-p195 :001 > station = DockingStation.new
 => #<DockingStation:0x007fae7b3b8950>
2.0.0-p195 :002 > bike = station.release_bike
 => #<Bike:0x007fae7b3c0dd0>
2.0.0-p195 :003 > bike.working?
 => true
```

Our goal is to create the necessary code to support the above functionality.  Why did we choose to name the method that releases a bike from the station `release_bike`? Naming things is one of [two hardest problems in Computer Science](http://martinfowler.com/bliki/TwoHardThings.html). We could have chosen a different name but this one seems good enough.

Take a few moments to discuss this code with your pair partner.  Ensure you understand what each line means.  You don't need to understand how it works yet, but it's important that you understand the semantics.

Notice also that none of the objects we are referencing actually exist in code.  We are using our domain model as a guide and then **writing the code we wish we had.**

Later in the course we'll see how this kind of manual check can be converted into an automated 'feature' test, but  to keep things simple for the moment we'll just test the high level user stories or 'features' via manual feature testing in irb.

Let's do that right now. Run `irb` (or [`pry`](http://pryrepl.org/) if you prefer) from the command line and type in the first line from the irb trace above, that's `station = DockingStation.new`.  Whatever you do, **DO NOT** copy and paste this code, you must type it out yourself.  It is essential that you type the code out yourself or you will not learn effectively.  You should get something like the following:

```sh
$ irb
2.2.2 :001 > station = DockingStation.new
NameError: uninitialized constant DockingStation
	from (irb):1
	from /Users/tansaku/.rvm/rubies/ruby-2.2.2/bin/irb:11:in '<main>'
2.2.2 :002 >
```

We got an error message.  You might think this is bad, but actually this is excellent.  The computer is trying to communicate with us to let us know why it can't perform the actions we asked of it.

There's a lot of information here, but it's important to work through it carefully.  There's nothing worse than seeing some sort of failure/error and then bashing away at the code randomly in the hopes of fixing it.  Ruby is giving you critical information about the precise nature of the underlying problem and you need to use that to work out what's wrong.  Have you seen this kind of error before?

Have a go with your pair partner at fixing this, and then check out [Stage 2](boris_bikes_stage_2.md)
