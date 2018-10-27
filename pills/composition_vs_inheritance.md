Composition vs inheritance
----
Inheritance (subclassing a class) and composition (including a module) are two powerful mechanisms for reusing code. When should you use one over another?

In general, aim to prefer composition over inheritance. Inheritance is applicable in situations when the child class should acquire all behaviour and properties of the parent class, extending or modifying them. Used inappropriately, inheritance may lead to rigid, hard to refactor code.

A good rule of thumb (or, scientifically called [Liskov substitution principle](http://en.wikipedia.org/wiki/Liskov_substitution_principle)) is that you should be able to substitute a parent class with the child's class without any change in functionality. If this is true, then you are looking at a use-case for inheritance. Another way to put it, you are dealing with a clear **is-a relationship**: Cow **is a** Mammal, House **is a** Building, etc.

If you have a **has-a (or uses-a)** relationship, then it's probably a use case for composition. For example, if project needs a set of methods to generate invoices for it, we can say that a Project has an Invoiceable property. Or, if an image can be resized, we can say that Image has a Resizeable property. Or, if an ElectricCar can use an ElectricMotor that can also be used by other vehicles.

![Tracking pixel](https://githubanalytics.herokuapp.com/course/pills/composition_vs_inheritance.md)
