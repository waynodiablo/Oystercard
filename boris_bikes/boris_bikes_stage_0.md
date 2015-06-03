## Stage 0: Domain Model and Project Setup


Once we've agreed on what our basic system should do, we can start to think about constructing a **Domain Model**. A Domain Model:

- describes the objects in a system, and
- describes how those objects interact.

We *could* spend a lot of time fleshing out that domain model in advance. But remember: we're only dealing with a subset of all the user stories, and we're anticipating lots of change in future. As we construct tests for our system, we'll see a clearer picture of the Domain Model start to **emerge**. This design philosophy is generally known as *Emergent Design*.

In the process of creating individual objects through a test driven process we'll gradually create an implementation in code of our domain model.  Over the course of this tutorial we'll fashion a series of **classes** that allow us to create bike objects, van objects, docking station objects and so on.  A system like this (in a much more complex form) is actually used by the real Boris bikes system in London. Every time you rent or return a bike, some code objects get created somewhere in the system that tracks the usage of all bikes.

Given that we have established the high-level user stories, the next step of the process (even before we think about a single line of code) is to create the [domain model](https://en.wikipedia.org/wiki/Domain_model). As we started to describe above, the domain model describes key concepts in the domain and the relationships between them.  In other words, it helps us understand what classes we may have and what methods they may implement.

Remember that a **class** is the **definition of a type of object**; in particular, the object's discrete collection of data and the related methods that operate on this data. In order to build a domain model, we need to understand what data we'll have in the system and what operations will be performed on that data.

A useful step in creating the domain model is to describe the problem in plain English.

> We are building a system that manages bikes that can be rented by users from docking stations and returned there at the end of the rental. The bikes can break while being used, in which case they will not be available for rental after they are returned. There is a garage that can fix broken bikes. A van is used to move broken bikes from the stations to the garage. It can also be used to take fixed bikes back to the station(s). The van, all stations and the garage have fixed capacity, so they cannot take more bikes than they can hold.

An easy way to start thinking about what classes you may have is to take a look at all nouns in the text. They are prime candidates for classes.

> We are building a system that manages **bikes** that can be rented by **users** from **docking stations** and returned there at the end of the **rental**. The **bikes** can break while being used, in which case they will not be available for **rental** after they are returned. There is a **garage** that can fix broken **bikes**. A **van** is used to move broken **bikes** from the **stations** to the **garage**. It can also be used to take fixed **bikes** back to the **station(s)**. The **van**, all **stations** and the **garage** have fixed **capacity**, so they cannot take more **bikes** than they can hold.

Not every noun will become a class and not every class we'll create will correspond to a noun in a plain English description. However, it's a good starting point. All data we'll have in the system will somehow be related to a class. For example, *capacity* is probably not a class in itself, but a property related to a station, van or garage.

Our classes will implement a number of methods. To get an idea of what they may be, we can take a look at the verbs in our description.

> We are building a system that manages bikes that can be **rented** by users from docking stations and **returned** there at the end of the rental. The bikes can **break** while being **used**, in which case they will not be available for rental after they are **returned**. There is a garage that can **fix** broken bikes. A van is used to **move** broken bikes from the stations to the garage. It can also be used to **take** fixed bikes back to the station(s). The van, all stations and the garage have fixed capacity, so they cannot **take** more bikes that they can **hold**.

Again, not all verbs will become methods and we'll have methods that don't correspond to any verbs in this description but that's ok. Right now we just need a idea of what they could be.

With your pair partner, have a go at producing a domain model on paper.  Don't worry too much about the format, just try to identify the key objects, their properties and/or methods and how they might interact with other objects.

### Investigate more formal domain modeling formats

How did you document your domain model on paper?  Did you use boxes for the classes?  Did you join boxes with lines/arrows?

There are standard modeling languages and techniques used within the software industry.  There are also large and expensive software packages to help you design your domain using those techniques and languages!

A simple example of a class modeling technique is the [Class Responsibilty Colloborator card](https://en.wikipedia.org/wiki/Class-responsibility-collaboration_card).  Have a read up on CRC cards and compare this technique with your own model.  You may need to Google for more detailed resources.

A more exhaustive modeling framework is Unified Modeling Language (UML).  Have a look at [UML class diagrams](https://en.wikipedia.org/wiki/Class_diagram) and compare these with CRC cards and you're own effort.

Sophisticated modeling languages are sometimes necessary in highly complex systems, but very often they are an expensive overhead.  Our objective here is an understanding of the domain so that we can code it, so any technique, including a rough sketch on paper should suffice.


## Setting up the project

***Please note, as with all Makers Academy materials, there may be subtle errors in the following materials.  Please try to approach those as challenges on which to polish your debugging skills - pull requests always welcome.***

Once we have an idea of what we are building, our first step will be describing some part of what we will build using a Feature Test.  Our preferred Ruby testing tool is [RSpec :pill:](../pills/rspec.md).  We can use RSpec to specify all kinds of tests; feature, integration and unit.

Let's get our project set up.  Create a new repository in your projects directory adding a `README.md` file like so:

```sh
$ mkdir boris-bikes
$ cd boris-bikes
$ git init
$ touch README.md
```

Add some basic explanation of the project to the `README.md` and then create a Github repo called 'boris-bikes' (note: please please ensure that the repo on Github is called exactly this, please ensure you use a hyphen '-' and not an underscore '_'), and then connect your local repo to the Github repo and push the changes to the README up to Github and confirm that they are visible on Github.  This is a critical backup of your local changes to a remote machine that you MUST repeat as regularly as possible, ideally each time you get your tests to go green.

Also note that the contents of the README.md file are going to be extremely important.  You are putting your code in public repositories on Github and the README.md file is the first thing that other programmers and potential employers are going to see when they look at your repo.  It's okay to start with a placeholder at the moment, but you will want to keep updating your README as you go along, ensuring that it tells people about the project, how to get set up with it, how to contribute to it etc.

Anyhow, this setup process is all just boilerplate activity before we start specifying the behaviour of our system with RSpec tests.  However it is very important in that we want to ensure we are set up to carefully backup the detailed history of the work we are doing.  Now we are going to iterate through a series of stages creating our first feature test, our first unit test, refactoring and so forth.

To finish the set up and get ready to write our first feature test, let's initialize RSpec:
```sh
$ rspec --init
```

We are going to use a library called Capybara to help us with our feature tests.  You'll be getting to know Capybara much better in the next few weeks, so don't worry too much about this extra detail at this stage.

Ensure you have run the following command:

```sh
$ gem install capybara
```

Then edit the `.rspec` file in your root project folder (`boris-bikes`) and add the following line to the end of the file:
```
--require capybara/rspec
```

Commit the changes to git then push your changes up to Github.

Let's start with [Stage 1](boris_bikes_stage_1.md).
