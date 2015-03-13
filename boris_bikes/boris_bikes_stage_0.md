## Stage 0: Domain Model and Project Setup

Given that we have established the high level system behaviours, the next step of the process (even before we think about a single line of code) is to create the [domain model](https://en.wikipedia.org/wiki/Domain_model). As we started to describe above, the [domain model](https://en.wikipedia.org/wiki/Domain_model) describes key concepts in the domain and the relationships between them.  In other words, it helps us understand what classes we may have and what methods they may implement.

Remember that a class is a collection of data and related methods that operate on this data. In order to build a [domain model](https://en.wikipedia.org/wiki/Domain_model) we need to understand what data we'll have in the system and what operations will be performed on that data.

A useful step in creating the domain model is to describe the problem in plain English.

> We are building a system that manages bikes that can be rented by users from docking stations and returned there at the end of the rental. The bikes can break while being used, in which case they will not be available for rental after they are returned. There is a garage that can fix broken bikes. A van is used to move broken bikes from the stations to the garage. It can also be used to take fixed bikes back to the station(s). The van, all stations and the garage have fixed capacity, so they cannot take more bikes that they can hold.

An easy way to start thinking about what classes you may have is to take a look at all nouns in the text. They are prime candidates for classes.

> We are building a system that manages **bikes** that can be rented by **users** from **docking stations** and returned there at the end of the **rental**. The **bikes** can break while being used, in which case they will not be available for **rental** after they are returned. There is a **garage** that can fix broken **bikes**. A **van** is used to move broken **bikes** from the **stations** to the **garage**. It can also be used to take fixed **bikes** back to the **station(s)**. The **van**, all **stations** and the **garage** have fixed capacity, so they cannot take more **bikes** that they can hold.

Not every noun will become a class and not every class we'll create will correspond to a noun in a plain English description. However, it's a good starting point. All data we'll have in the system will somehow be related to some class. For example, a number of bikes in a certain station is related to the station itself, not to a van or garage.

Our classes will implement a number of methods. To get an idea of what they may be, we can take a look at the verbs in our description.

> We are building a system that manages bikes that can be **rented** by users from docking stations and **returned** there at the end of the rental. The bikes can **break** while being **used**, in which case they will not be available for rental after they are **returned**. There is a garage that can **fix** broken bikes. A van is used to **move** broken bikes from the stations to the garage. It can also be used to **take** fixed bikes back to the station(s). The van, all stations and the garage have fixed capacity, so they cannot **take** more bikes that they can **hold**.

Again, not all verbs will become methods and we'll have methods that don't correspond to any verbs in this description but that's ok. Right now we just need a idea of what they could be.

[CRC?  UML diagrams?]

## Setting up the project

***Please note, as with all Makers Academy materials, there may be subtle errors in the following materials.  Please try to approach those as challenges on which to polish your debugging skills - pull requests always welcome.***

Once we have an idea of what we are building our first step will be describing some part of what we will build using 'specs' (short for specifications).  We'll also refer to these as 'tests'.  Our preferred Ruby testing tool is [RSpec](https://github.com/makersacademy/course/blob/master/pills/rspec.md), and each individual test of our code is a 'spec'.  We can use RSpec to specify all kinds of tests; feature, integration and unit.  Let's get our project setup and we'll start with a feature test.

[NOT SURE ABOUT FORKING VS CREATING OWN REPO - NIKESH SAYS ALL PRECOURSERS ARE DOING PULL REQUESTS WITH RUBY KICKSTARTER]

Create a new repository in your projects directory adding a `README.md` file like so.

````
mkdir boris-bikes
cd boris-bikes
git init
touch README.md
…
````

Add some basic explanation of the project to the README and then create a Github repo called 'boris-bikes' (note: please please ensure that the repo on Github is called exactly this, please ensure you use a hypen '-' and not an underscore '_'), and then connect your local repo to the Github repo and push the changes to the README up to Github and confirm that they are visible on Github.  This is a critical backup of your local changes to a remote machine that you MUST repeat as regularly as possible, ideally each time you get your tests to go green.

Also note that the contents of the README.md file are going to be extremely important.  You are putting your code in public repositories on Github and the README.md file is the first thing that other programmers and potential employers are going to see when they look at your repo.  It's okay to start with a placeholder at the moment, but you will want to keep updating your README as you go along, ensuring that it tells people about the project, how to get set up with it, how to contribute to it etc.

Anyhow, this setup process is all just throat clearing activity before we start specifying the behaviour of our system with RSpec tests.  However it is very important in that we want to ensure we are set up to carefully backup the detailed history of the work we are doing.  Now we are going to iterate through a series of stages creating our first feature test, our first unit test, refactoring and so forth.

[TODO: Link to stage 1]
