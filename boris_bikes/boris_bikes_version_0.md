# OOD & OOP Basics: Boris Bikes

The goal of this project is to introduce you to [Object-Oriented Programming (OOP) ](https://en.wikipedia.org/wiki/Object-oriented_programming)and show you the very basics of [Object-Oriented Design (OOD)](https://en.wikipedia.org/wiki/Object-oriented_design).

***Please note, as with all Makers Academy materials, there may be subtle errors in the following materials.  Please try to approach those as challenges on which to polish your debugging skills - pull requests always welcome.***

We are creating a simple system for managing [Boris Bikes in London](https://en.wikipedia.org/wiki/Barclays_Cycle_Hire). Our system will keep track of a number of docking stations and the bikes. It will allow you to rent the bikes and return them. Occasionally the bikes will break and then they will be unavailable for rental. There will also be a garage to fix the bikes and a van to move the bikes between the stations and the garage.

A system like this (in a much more complex form) is actually used by the real Boris bikes system in London. Every time you rent a bike or return it some objects get created somewhere in the system that tracks the usage of all bikes.

***Please work through this walkthrough with a pair partner. Please take turns on the keyboard as the driver as described in the [pairing pill](pills/pairing.md) :pill:.   Please swap driver/navigator roles following an appropriate protocol (ping-pong, change the message), ensuring that the maximum time one person is driving is 15minutes, but as frequently as every minute.***

## Version 0: Building a domain model

The first step of the process (even before we think about a single line of code) is to create the [domain model](https://en.wikipedia.org/wiki/Domain_model). The [domain model](https://en.wikipedia.org/wiki/Domain_model) describes key concepts in the domain and the relationships between them. In other words, it helps us understand what classes we may have and what methods they may implement.

Remember that a class is a collection of data and related methods that operate on this data. In order to build a [domain model](https://en.wikipedia.org/wiki/Domain_model) we need to understand what data we'll have in the system and what operations will be performed on that data.

The first step in creating the domain model is to describe the problem in plain English.

> We are building a system that manages bikes that can be rented by users from docking stations and returned there at the end of the rental. The bikes can break while being used, in which case they will not be available for rental after they are returned. There is a garage that can fix broken bikes. A van is used to move broken bikes from the stations to the garage. It can also be used to take fixed bikes back to the station(s). The van, all stations and the garage have fixed capacity, so they cannot take more bikes that they can hold.

The easy way to start thinking about what classes you may have is to take a look at all nouns in the text. They are prime candidates for classes.

> We are building a system that manages **bikes** that can be rented by **users** from **docking stations** and returned there at the end of the **rental**. The **bikes** can break while being used, in which case they will not be available for **rental** after they are returned. There is a **garage** that can fix broken **bikes**. A **van** is used to move broken **bikes** from the **stations** to the **garage**. It can also be used to take fixed **bikes** back to the **station(s)**. The **van**, all **stations** and the **garage** have fixed capacity, so they cannot take more **bikes** that they can hold.

Not every noun will become a class and not every class we'll create will correspond to a noun in a plain English description. However, it's a good starting point. All data we'll have in the system will somehow be related to some class. For example, a number of bikes in a certain station is related to the station itself, not to a van or garage.

Our classes will implement a number of methods. To get an idea of what they may be, we can take a look at the verbs in our description.

> We are building a system that manages bikes that can be **rented** by users from docking stations and **returned** there at the end of the rental. The bikes can **break** while being **used**, in which case they will not be available for rental after they are **returned**. There is a garage that can **fix** broken bikes. A van is used to **move** broken bikes from the stations to the garage. It can also be used to **take** fixed bikes back to the station(s). The van, all stations and the garage have fixed capacity, so they cannot **take** more bikes that they can **hold**.

Again, not all verbs will become methods and we'll have methods that don't correspond to any verbs in this description but that's ok. Right now we just need a idea of what they could be.
