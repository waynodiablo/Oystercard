# Clojure #

Clojure is a wonderfully contradictory language.

It's an amazing, modern programming language that has been designed specifically for the concurrent multithread abilities and memory capacity of modern computers. But it is simultaneously rooted in traditions that are almost as old as computer science itself.

We'll see how part of its power is derived from an _interesting_ syntax many people struggle with when first coming to the language. Try not to let these superficial concerns get in the way. You'll come to understand how Clojure derives a lot of its power from its syntax.

## Getting started ##

Clojure is a language that runs on the Java Virtual Machine (JVM). The JVM is responsible for running your code similar to how the `ruby` is responsible for running your .rb files or a web browser is responsible for running your javasScript code.

Unlike Ruby, Clojure is a compiled language, and your code has to be compiled into JVM bytecode in order to run. To handle this process we'll install a program called leiningen to take care of this for us.

### Install Leiningen ###

Follow the instructions at [http://leiningen.org](http://leiningen.org/#install) to install the `lein` command-line utility.

In addition to compiling Clojure code, Leiningen functions a lot like bundler does for Ruby. It manages a project's dependencies and we'll be using it a lot.

**Make sure you run `lein` on the command-line before proceeding.**

### Create a test project ###

In the directory on your computer where you keep your code, run

```bash
lein new clojure-intro
```
This will create a brand new Clojure project in a new directory of the same name.

Inside the directory will be a `project.clj` file which contains the project dependencies written in Clojure. Just like `.rb` is the suffix for Ruby files, `.clj` is the suffix for Clojure files.

Next run
```bash
lein deps
```

to install dependencies. At this stage Clojure is the only project dependency. It will install the latest version of Clojure by default, which is normally what you want.

Notice how in the `project.clj` file Clojure is a _dependency_, just like any other. This is because code is compiled together with your other libraries into executable files that are run like applications on your computer. You can run the compiled code on a computer that doesn't have Clojure installed.

### Setting up your editor ###

Working with Clojure is a lot more pleasant if you have great text editor integration.

Make sure you follow these instructions for [Sublime Text](http://dev.clojure.org/display/doc/Getting+Started+With+Sublime+Text+2), [Atom](https://github.com/lsegal/atom-runner#configuring) or [Light Table](http://lighttable.com/), or [Emacs](http://www.gnu.org/software/emacs/)

Unless you're particularly attached to your text extitor, [Light Table](http://lighttable.com/) is the recommended choice. Take a look at [http://docs.lighttable.com/tutorials/full/](http://docs.lighttable.com/tutorials/full/) to get started.

## Clojure REPL ##

The REPL (pronounced _REH-pull_) is the primary way of developing Clojure code. REPL stands for Read - Evaluate - Print - Loop.

* Read - wait for you to write some code
* Evaluate - interpret and run the code it reads
* Print - output the result of evaluating the code
* Loop - go back to the beginning

This is because Clojure is designed to be written _interactively_. You are positively encouraged to try things out and see what happens.

### Writing code in the REPL ###

Our examples will use Light Table.

We've already seen Clojure code - the `project.clj` file is written in Clojure. Let's open another source file that was created by leiningen: `src/clojure_intro/core.clj`.

In Light Table, go to `File > Open Folder` and select the project folder you just created. You should see something like this:

![welcome.png](https://github.com/makersacademy/course/blob/master/pills/images/clojure/welcome.png)

Use the side bar to navigate to the `core.clj` file and open it. You should see something like this:

![core.png](https://github.com/makersacademy/course/blob/master/pills/images/clojure/core.png)

This file contains a simple 'Hello World' example. Let's check we can run it. Type `CMD-SHIFT-Enter` to get Light Table to evaluate our code.

This will *take a long time* the very first time you run it. It has to start up the java virtual machine in the background and download LightTable's dependencies.

Eventually, you should see the following:

![evaluated.png](https://github.com/makersacademy/course/blob/master/pills/images/clojure/evaluated.png)

Now add to the bottom of your file:

```clojure
;; Add this to the bottom of your file:

(foo "Whoa")
```

Put your cursor on the line you just wrote and enter `CMD-Enter`. This will evaluate the particular line you are on. Text appears next to this line in blue saying `nil`.

However you should have an small blue square in the bottom right of the screen. This is informing you that you have some console output.

![console-flag.png](https://github.com/makersacademy/course/blob/master/pills/images/clojure/console-flag.png)

Go to `View > Console` to see the LightTable console output.

![console-output.png](https://github.com/makersacademy/course/blob/master/pills/images/clojure/console-output.png)

Hooray! You've just executed your first Clojure code in the REPL.

## Clojure basics

Delete everything from the file except the line at the top. Clojure doesn't have classes and objects. It has namespaces and functions.

```clojure
(ns clojure-intro.core)
```

This line tells the Clojure compiler that any functions you define should be part of the `clojure-intro.core` namespace.

![blank-ns.png](https://github.com/makersacademy/course/blob/master/pills/images/clojure/blank-ns.png)

