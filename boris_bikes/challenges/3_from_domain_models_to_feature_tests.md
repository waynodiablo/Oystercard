# From a Domain Model to a Feature Test

A **Domain Model** is an abstract representation of the Objects within a system, and the Messages they use to communicate with one another. Once you have a Domain Model for a feature, you need to think about how your Objects and Messages will work together in code. This is called a **Feature Test**.

In this challenge, you will Feature Test the Domain Model you just made.

### Learning Objectives covered
- Define 'Feature Test'
- Define a 'stack trace'
- Use IRB to 'feature test' a Domain Model

### Challenge setup

Here is the User Story you converted into a Domain Model:

```
As a person,
So that I can use a bike,
I'd like to get a bike from a docking station.

As a person,
So that I can use a good bike,
I'd like to see if a bike works
```

Here is a functional representation of that story:

Objects  | Messages
------------- | -------------
Person  | 
Bike  | works?
DockingStation | get_bike


### Self-assessment

To complete this challenge, you will need to:

- [ ] Start `irb` (or any other REPL) from the Command Line
- [ ] Set a variable `docking_station` equal to a new `DockingStation` object
- [ ] Explain to your pair partner what the resulting error means.

### Resources

### [Solution](solutions/3.md)
