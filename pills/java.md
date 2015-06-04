Java
====

Java derives much of its syntax from the [C] family of programming
languages - the closest you will have seen to the overall look of Java is its
namesake [JavaScript], but the similarity is at the surface level; the two
languages are quite different.

###Compilation

The first difference you will notice is that Java is compiled. Unlike Ruby
and JS, files writen in Java (conventionally saved with the extension `.java`).
cannot be run directly by your computer. Instead they are changed by another
program - the compiler - into files which can be run by the Java Virtual
Machine (JVM) - files with the extension `.class`. The JVM runs Java programs
extremely quickly and has been implemented in almost all operating systems.
This speed and prevalence has made the JVM a popular target for other
programming languages, including [Clojure], [Scala], and even [jRuby], an
implementation of Ruby for the JVM.

Let's take a look at this in action. First of all you'll need to make sure you
have Java installed on your computer. All Macs will come with Java by default,
but you may need to install it on other systems. Please see the [Java website]
for installation instructions.

Make yourself a test directory and start a new file called `hello.java`. Write
the following:

```java
class HelloWorld {
    public static void main(String[] args) {
        System.out.println("Hello World!");
    };
};
```

Pretty verbose, right? We'll get on to the `public static void` etc. later --
for now see it as a bit of magic [boilerplate]. The `System.out` part should be
a little more familiar - we're asking Java to print a line (`println`) and then
giving it a string to print. And the `class` is very much as in other languages
-- we've made a class called 'HelloWorld'. Note also the curly braces and
semicolons as you'd see in JavaScript. This is a feature in C-like syntax,
although the semicolons are not optional here (this is _not_ JavaScript).

To compile your program run `javac hello.java` (the `c` is for compile). All
things being equal you'll see nothing happen. If you `ls` the contents you
should see another file called `HelloWorld.class` in your directory. This is the
compiled version of the Java you've just written. To run it just type
`java HelloWorld`, and you'll see what was expected. Note that the `.class`
file name represents the class name in the `.java` file - it's best practice to
name your `.java` files after the class they describe - do that from now on.

###Errors
But what if things were not equal? Let's edit the program by pretending we
were writing JavaScript and stripping out those semicolons. Do so and try and
compile it again -- you will get a very descriptive error message telling you
what went wrong. Java is handy like that.

###`main` method

Every Java application has a `main` method, which is the method that runs when
the application is executed. But what about all the other words on that line:

- *`public`* : unlike Ruby where you can split methods up into `public` and
  `private` groups, all methods in Java have to be declared to be `public`,
  `private` or `protected`.
- *`static`* : the `static` keyword declares that this is a class method rather
  than an instance method - the equivalent of `def self.method_name` in a Ruby
  class.
- *`void`* : methods in Java need to declare what _type_ of object they return.
  Here we don't want there to be any return value, so we declare it to be
  `void`.
- *`main`* : the name of the method - in this case `main`.
- *`(String[] args)`* : these braces take the method argument variables, much as
  you would see in Ruby. Unlike in Ruby you need to declare the _type_ of each
  argument variable. In this case the name of the variable is `args`, and the
  type is an array of strings, written as `String[]` in Java. The `args` is the
  array of command line options fed to the program on execution.

###Type

A type, or __data type__ to give it its full name, is classification of the sort
of data available in a programming language. In Ruby we're used to everything
being an object, but we can see the different data types as some of the classes
in Ruby -- `String` and `Fixnum` for instance.

In Java, when you declare a method or an argument variable, you must declare the
type of data that is coming out or going in to the method. There are eight
_primitive_ data types to choose from, along with `void` for no return value in
a method. A class is also a data type - an object's parent class is its data
type. Take a look at the Java documentation on [primitives] for more detail.

If we wanted to declare a method for a class that added two numbers together we
would write something like this:

```java
class Calculator {
    public int addTwoNumbers(int firstNumber, int secondNumber) {
        return firstNumber + secondNumber;
    };
};
```

What if we need some variables to add together? These also need their type to
be declared:

```java
int aNumber = 1;
boolean isNumber = true;
Calculator pocketCalculator = new Calculator();
```

(That's how to make a new instance of a class by the way.)

###Control flow

The control flow in Java is much as in other languages (the `for` loop is
almost identical to that in JavaScript), but can often be written as neat,
idiomatic one-liners:

```java
public String parityOf(int number) {
    return if (number % 2 != 0) "Odd";
    return if (number % 2 == 0) "Even";
};
```

###Packages and Testing with jUnit

So far, so obvious. The difficulties with Java are when you come to managing
dependencies. Java needs all of its required packages to be installed locally,
and then you need to require in each individual class (and methods if you
like) to the project you're working on. This is considerably more secure than
the way Ruby deals with imports - just loading the entire file's contents.

An example: we would, as good TDDers, like to be writing tests. [jUnit] is the
_de facto_ standard test suite for Java. Requiring a jUnit into a Java program
and writing a test looks something like this:

```java
import org.junit.Test;
import static org.junit.Assert.*;

public class CalculatorTest {
    @Test
    public void knowsTwoIsEven() {
       assertThat(Calculator.parityOf(2), is("Even"));
    };
};
```

Java packages are named, by convention, with the reversed Internet domain name
of the author or company, to help avoid namespacing issues (i.e. classes with
the same name). Don't ask why. Here we've required in the class `test` and all
the methods of the `Assert` class (such as `assertThat`).

We declare to jUnit that the method is a test with the [annotation] `@Test` at
the top. The assertion syntax should be relatively obvious.

###Package management with Gradle

Downloading each required package individually and directing Java to the folder
you've saved it in can be time consuming to say the least. Happily package
managers are available for Java, the best at present which is [Gradle], which
is written in [Groovy]. Groovy is basically what Java people wrote when they
were jealous of Ruby.

Installing Gradle can be as simple as `brew install Gradle`. Recent versions
even come with a project initializing script: `gradle init --type java-library`
will generate a series of files. Of interest to you will be the contents of
`src/main` and `src/test`. To run the tests is simply a case of running `gradle
test`. Building the project - `gradle build`.

Examine the `build.gradle` file to see the dependencies for the project (note
that `testCompile` is only required for testing, unlike `compile`. Read the
extensive and thorough Gradle documentation for more information.

###IDEs with IntelliJ

Even with the help of a relatively simple package manager like Gradle, Java can
be a terrible beast to master. Professional Java developers tend to steer clear
of pure text editors like [Vim] and [Sublime] in favour of using an [IDE] - an
integrated development environment. These programs take care of the
boilerplate in Java, constantly compile your code in the background to pick up
errors on as you're typing, organize your project directory structure, help you
to refactor, provide handy shortcuts, push to Git, run your tests... they
almost write the code for you. Although it's important to know what's going on
in the background, a good IDE will help you write good code faster.

Take a look at [IntelliJ IDEA]'s community version (recommended) or [Eclipse].
Both tools are fairly daunting to begin with, but experiment with starting
a project in one or the other and writing your code with them. There are many
tutorials available.

###Further Reading

The [Java Tutorials] are an excellent and free source of materials about Java,
especially the first track on [Learning the Java Language], along with the
[Java reference pages]

[annotation]: https://docs.oracle.com/javase/tutorial/java/annotations/index.html
[C]: http://en.wikipedia.org/wiki/C_%28programming_language%29
[Clojure]: http://clojure.org/
[Eclipse]: https://eclipse.org/
[Gradle]: http://www.gradle.org/
[Groovy]: http://groovy.codehaus.org/
[IDE]: http://en.wikipedia.org/wiki/Integrated_development_environment
[IntelliJ IDEA]: https://www.jetbrains.com/idea/
[Java reference pages]: https://docs.oracle.com/javase/8/
[Java Tutorials]: https://docs.oracle.com/javase/tutorial/index.html
[JavaScript]: http://en.wikipedia.org/wiki/JavaScript
[jRuby]: http://jruby.org/
[jUnit]: http://junit.org/
[Learning the Java Language]: https://docs.oracle.com/javase/tutorial/java/index.html
[primitives]: https://docs.oracle.com/javase/tutorial/java/nutsandbolts/datatypes.html
[Scala]: http://www.scala-lang.org/
[Sublime]: http://www.sublimetext.com/
[Vim]: http://en.wikipedia.org/wiki/Vim_(text_editor)

Other Resources
---------------

* [Udacity Online Course](https://www.udacity.com/course/cs046)
* [Learning Java Resources](https://netbeans.org/kb/articles/learn-java.html)
