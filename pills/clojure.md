# Clojure #

Clojure is a wonderfully contradictory language.

It's a cutting edge programming language that has been designed specifically for the concurrent multithread abilities and memory capacity of modern computers. But it is simultaneously rooted in traditions that are almost as old as computer science itself.

We'll see how part of its power is derived from an _interesting_ syntax many people struggle with when first coming to the language. Try not to let these superficial concerns get in the way. You'll come to understand how Clojure derives a lot of its power from its syntax.

## Getting started ##

Clojure is a language that runs on the Java Virtual Machine (JVM). The JVM is responsible for running your code similar to how the `ruby` is responsible for running your .rb files or a web browser is responsible for running your javasScript code.

Unlike Ruby, Clojure is a compiled language, and your code has to be compiled into JVM bytecode in order to run. To handle this process we'll install a program called leiningen to take care of this for us.

### Install Leiningen ###

[Leiningen](http://leiningen.org/#install) is a build tool that assists with writing Clojure code. It is accessed through the `lein` command-line utility.

You can install Leiningen through homebrew in the usual way:
```bash
brew install leiningen
```

In addition to compiling Clojure code, Leiningen functions a lot like bundler does for Ruby. It manages a project's dependencies and we'll be using it a lot.

### Install a JDK

Clojure runs on the Java Virtual Machine (JVM). In order to compile Clojure code you'll need a working JDK.

TODO: JDK installation walkthough

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

![project.clj](https://github.com/makersacademy/course/blob/master/pills/images/clojure/project-clj.png)

Notice how in the `project.clj` file Clojure is a _dependency_, just like any other. This is because code is compiled together with your other libraries into executable files that are run like applications on your computer. You can run the compiled code on a computer that doesn't have Clojure installed.

### Setting up your editor ###

Working with Clojure is a lot more pleasant if you have great text editor integration.

This walkthough will assume you are using the [Light Table](http://lighttable.com/) text editor. Take a look at [http://docs.lighttable.com/tutorials/full/](http://docs.lighttable.com/tutorials/full/) to get started.

It is **strongly recommended** that you use Lighttable for the walkthrough since Clojure integration is provided out of the box. Once you are comfortable with the basics of the language you can choose to follow these instructions for [Sublime Text](http://dev.clojure.org/display/doc/Getting+Started+With+Sublime+Text+2), [Atom](https://github.com/lsegal/atom-runner#configuring) or [Emacs](http://www.gnu.org/software/emacs/)

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

### Datatypes ###

In spite of not having classes and objects Clojure has all the data types you'd expect.

```clojure
(ns clojure-intro.core)


;; We have numbers

42

3.14159

;; ...including fractions

7/5

;; We also have strings...

"Hi there!"

;; ...and keywords...

:hola

;; ...and regular expressions

#"\d+"

;; We also have collection types like arrays (though they're called vectors)...

[5 10 15 20 "The end"]

;; ...and hashes (though they're called maps)...

{ :name "Henry"
  :status "Writing" }

;; ... and sets (just sets)

#{"fish" "chips" "mushy peas"}
```

Notice how there aren't any unneccesary commas between vector, map and set elements.

## Lists

There is another collection type that has a particular meaning in Clojure that we'll cover in more detail: the List.

Lists in Clojure are defined with round brackets:

```clojure
("a" "list" "of" "strings")
```

If you try to execute this in Light Table something weird will happen.

![error](https://github.com/makersacademy/course/blob/master/pills/images/clojure/error.png)

You'll get an error complaining that `java.lang.ClassCastException: java.lang.String cannot be cast to clojure.lang.IFn`.

This is interesting for two reasons:

  1. I told you that Clojure didn't have classes, and you have a ClassCastException
  2. It's looking for a clojure.lang.IFn (IFn is an abbreviation of Function Interface)

The reason we're getting java.lang.ClassCastExceptions is because Clojure is built on top of Java. Much like a language like CoffeeScript is built on top of JavaScript, or Swift is built on top of C (and ruby, for that matter), we're seeing an error bubble up from the underlying implementation.

The second error is because lists occupy a special place in Clojure. The first element of a list is assumed to be a function call.

[[Indentation]]

## Calling Functions

The code failed because "a" (the first element in the list) is not a function. Let's replace it with something that is.

`println` is a function that we already saw above. It prints its arguments to the console.

```clojure
(println "list" "of" "strings")
```

If you execute the above you'll get something different:

![println](https://github.com/makersacademy/course/blob/master/pills/images/clojure/println.png)

The println function will output each of the arguments it is given with a space between them to the console. You see `nil` next to the function in Light Table because the `println` function returns `nil`.

## More functions

Other functions do return values such as `inc` that increments a number.

```clojure
(inc 1)
; => 2
```
Or `dec` which decrements a number

```clojure
(dec 2)
; => 1
```

Let's look at some simple maths.

```clojure
(+ 1 3)
; => 4
```
Clojure uses *prefix* notation rather than *infix* notation. This is not the sort of arithmetic you're probably used to seeing.

An advantage is that you don't need to keep repeating the function name.

```clojure
(+ 1 2 3 4 5)
; => 15

(- 15 1 2 3)
; => 9
```

### Nesting

You can next lists within lists. The result of one list is evaluated before being passed to another list (usually - we'll cover Macros soon).

```clojure
(+ (inc (inc 3)) (- 7 2))
; => ?
```
What's the value of the expression above? Think about it before moving on.

### Evaluation

You can imagine the code as a tree structure. The branches are evaluated first from the bottom up. When the top of the tree is reached, the final value is returned.

```txt
+
|-- Inc
|     \-- Inc
|           \-- 3
\-- -
    |-- 7
    \-- 2
```

## Evaluation II

Hopefully the above seems very simple. We've covered lists, and how the first element of a list is a function that receives the rest of the (evaluated) elements as arguments.

Knowing that, can you see a problem with this code?

```clojure
(if button-pressed?
  (launch-the-missiles!))
```

Take a moment to think about this.

---

The reason is that launch the missiles will be evaluated and the return value will be passed to `if` before it has a chance to test whether the button has been pressed! :(

Clojure gets around this by making *if a special form*. Arguments are *not* evaluated first. Phew!

```clojure
;; "If" will evaluate the condition *before* subsequent arguments

(if (suspicous-noise? outside)
  (release-the-hounds! "barking")
  (back-to-sleep))

; When statement (like an if with no else)

(when (finished-homework?)
  (smugface))
  ```
  
`when` is defined internally by the language in terms of `if` using macros. We'll cover how you can write your own macros at a later date.

## Naming things

To do much useful work we want to name things. There are two other *special forms* that Clojure defines that allow us to name variables.

### Let

The most common way of defining variables is with `let`.

```clojure
(let [x 5
      y 10]
  (* x y))
; => 50
```

Let associates values to symbols in pairs. In the above example the value `5` is associated with the symbol `x`. The value `10` is associated with the symbol `y`. Becase the values are being bound to symbols, the associations are called *bindings*.

You can supply as many bindings to let as you like, as long as there's an even number of values to symbols.

Bindings are evaluated in order, so later bindings can use earlier bindings.

```clojure
(let [cats 3
      legs (* 4 cats)]
  (str legs " legs all together"))
      
; => "12 legs all together"
```

The *scope* of variables defined with let is defined by the the extent of the list. What would the happen with the following?

```clojure
(let [wizard "Hermione"])

(println wizard)
```

Unfortunately we get an error.

![scope error](https://github.com/makersacademy/course/blob/master/pills/images/clojure/scope-error.png)

The reason is that the variable has ceased to exist outside of the scope of the let bindings.

We'd need to move the use of the variable inside the let list in order to use it.

![hermione](https://github.com/makersacademy/course/blob/master/pills/images/clojure/hermione.png)

### Def

If you want to make use of variables more widely, you can **def**ine them to be able to refer back to them later.

```clojure
(def job-description "Wizard")

(println job-description)
```

**NB: unlike let, you can only define one thing at a time with `def`.**

## Creating functions

We've been using functions already, but how do we create our own?

We can use the `fn` special form.

```clojure
(fn [a-number]
  (+ a-number 1))
  ```

This function adds one to the number it is given.

We could call it by including it as the first element in a list.

```clojure
((fn [a-number]
  (+ a-number 1)) 2)
; => 3
```

This is hard to read, but we could `def` the function first and then use it.

```clojure
(def add-one
  (fn [a-number]
    (+ a-number 1)))

(add-one 2)
; => 3
```

This works, but it's such a common thing to there is a shorthand for creating and defining functions in one go called `defn`.

```clojure
(defn add-one [a-number]
  (+ a-number 1))

(add-one 2)
; => 3
```

Much more legible!

![defn](https://github.com/makersacademy/course/blob/master/pills/images/clojure/defn.png)

## Return values

Like Ruby, in Clojure a function returns the last thing it evaluated.

## Higher-order functions ##

Clojure is a function language, and functions are first-class entities. They can be passed to other functions, or returned from functions.

Higher-order functions are functions which accept or return functions.

```clojure
(def numbers
  [1 2 3 4 5 6 7 8 9 10])


(map inc numbers)
; => (2 3 4 5 6 7 8 9 10 11)
```

The `inc` function increments a number by one, and we can pass it as an *argument* to map. `map` will iterate over a collection passed as its second argument and apply the function passed as its second argument to each element in turn.

There is nothing special about higher order functions or the functions you pass to them! We could also use our `add-one` function in place of `inc`.

```clojure
(def numbers
  [1 2 3 4 5 6 7 8 9 10])

(map add-one numbers)
; => (2 3 4 5 6 7 8 9 10 11)
```

Other higher-order functions that return a sequence are:

```clojure
(filter even? [1 2 3 4 5 6])
; => (2 4 6)

(remove even? [1 2 3 4 5 6])
; => (1 3 5)

(sort-by count ["bb" "aaa" "c"]
; => ("c" "bb" "aaa")
```

Some higher-order functions accept a sequence and return something different in return:

```clojure
; Reduce is just like Ruby's inject...

(reduce + [1 2 3 4 5])
; => 15

(group-by even? [1 2 3 4])
; => {false [1 3], true [2 4]}
```

## Installing Dependencies

Ruby has Gems, Node has Packages, and Clojure has *Jars* (short for Java archive).

There are a huge number of Clojure libraries available. You can search for them at [Clojars](https://clojars.org/). Clojure can also run jars written for other languages such as Java, which means that although Clojure is a recent language you can make use of a wealth of software developed over the last several decades.

We can add jars as dependencies to your project in the `project.clj` file.

```clojure
(defproject clojure-intro "0.1.0-SNAPSHOT"
  :description "FIXME: write description"
  :url "http://example.com/FIXME"
  :license {:name "Eclipse Public License"
            :url "http://www.eclipse.org/legal/epl-v10.html"}
  :dependencies [[org.clojure/clojure "1.6.0"]])

```

To make HTTP requests we're going to use a dependency called clj-http. The GitHub is here: [https://github.com/dakrone/clj-http](https://github.com/dakrone/clj-http). At the time of writing, the latest version is 1.0.1.

```clojure
[clj-http "1.0.1"]
```

This needs to be added to the project dependencies in the `project.clj`. This is just like adding it to a Gemfile in ruby, except we always need to specify the version we want.

![clj-http](https://github.com/makersacademy/course/blob/master/pills/images/clojure/clj-http.png)

The new dependency will be automatically downloaded, **but only once we restart our REPL**. To do this in Light Table, go to `View > Connections` and disconnect from the current connection.

![connections](https://github.com/makersacademy/course/blob/master/pills/images/clojure/connections.png)

Now, when you execute your code again, the latest dependencies will be downloaded.

## Requiring & using dependencies

Dependencies are required on a per-namespace basis. To access the functions provided by `clj-http`, we have to update our namespace declaration.

```clojure
(ns clojure-intro.core
  (:require [clj-http.client]))
```

The `:require` clause tells the compiler that we want access to the functions defined in the `clj-http/client` namespace. The client namespace contains a function called `get` that gets an HTTP page.

The `clj-http.client/get` function expects to recieve the URL to get as a string. We can execute it like so:

```clojure
(ns clojure-intro.core
  (:require [clj-http.client]))

(clj-http.client/get "http://google.com")

```

This should output something like the following:

![Google respons](https://github.com/makersacademy/course/blob/master/pills/images/clojure/google.png)

Hooray! We've just spoken to Google from Clojure.

Our function call is a little long-winded, so we can choose to alias the required namespace with a shorter symbol. Try updating the namespace declaration and function call like so:

```clojure
(ns clojure-intro.core
  (:require [clj-http.client :as http]))

(http/get "http://google.com")

```

## HTTP requests and responses

One of the things that makes Clojure so interesting is its emphasis on simple, reusable data structures. You might be able to see that the response we get back from `http/get` is a map. It's just like the map we created earlier `{:with "keys" :and "values"}`.

We could ask what keys the map returns by executing:

```clojure
(keys (http/get "http://google.com"))

; => (:cookies :orig-content-encoding :trace-redirects :request-time :status :headers :body)
```

We could ask what headers our map contains by calling:

```clojure
(:headers (http/get "http://google.com"))

; => {"Server" "gws" "Content-Type" "text/html; charset=ISO-8859-1" "X-Frame-Options" "SAMEORIGIN"}
```

Notice how the headers are maps too! This is very common in Clojure code.

We can make requests using maps as well, we can pass an optional map of configuration to our `http/get` request:

```clojure
(http/get "http://google.com" {:query-params {:q "Makers Academy"}})
```

You may not be able to see what this is doing, but take a look at the `:trace-redirects` in the response. This will show the URL that Google sent us to:

```clojure
; => ["http://google.com" "http://www.google.co.uk/?q=Makers+Academy"]
```

Notice how we have added a query parameter onto the end of the URL.

## JSON responses and Open Weather Map

This sort of maps in, maps out way of working with HTTP requests and responses is even more powerful when you are dealing with APIs.

Instead of talking to Google, let's access the JSON API provided by openweathermap.com at http://api.openweathermap.org/data/2.5/.

This API will allow us to search for locations using the `find` path, search for weather at a particular location using the `weather` path and see weather predictions with the `forecast` path.

You can:

* Find Londons with http://api.openweathermap.org/data/2.5/find?q=london
* See the weather with http://api.openweathermap.org/data/2.5/weather?q=london
* See the forecast with  http://api.openweathermap.org/data/2.5/forecast?q=london

Each response will return a JSON document. For example, below is the response from the *find* query.

```json
{
  "message": "accurate",
  "cod": "200",
  "count": 2,
  "list": [
    {
      "id": 6058560,
      "name": "London",
      "coord": {
        "lon": -81.23304,
        "lat": 42.983391
      },
      "main": {
        "temp": 265.819,
        "temp_min": 265.819,
        "temp_max": 265.819,
        "pressure": 1014.61,
        "sea_level": 1041.07,
        "grnd_level": 1014.61,
        "humidity": 88
      },
      "dt": 1422644988,
      "wind": {
        "speed": 8.76,
        "deg": 327.001
      },
      "sys": {
        "country": "CA"
      },
      "clouds": {
        "all": 68
      },
      "weather": [
        {
          "id": 803,
          "main": "Clouds",
          "description": "broken clouds",
          "icon": "04d"
        }
      ]
    },
    {
      "id": 2643743,
      "name": "London",
      "coord": {
        "lon": -0.12574,
        "lat": 51.50853
      },
      "main": {
        "temp": 275.25,
        "humidity": 89,
        "pressure": 979.2,
        "temp_min": 275.25,
        "temp_max": 275.25
      },
      "dt": 1422644712,
      "wind": {
        "speed": 2,
        "gust": 2.8,
        "deg": 202
      },
      "sys": {
        "country": "GB"
      },
      "rain": {
        "3h": 0.5
      },
      "snow": {
        "3h": 0.025
      },
      "clouds": {
        "all": 68
      },
      "weather": [
        {
          "id": 500,
          "main": "Rain",
          "description": "light rain",
          "icon": "10n"
        }
      ]
    }
  ]
}
```

We can make the same request using Clojure by changing the URL that we request, and the query parameter to London.

```clojure
(:body (http/get "http://api.openweathermap.org/data/2.5/find"
         {:query-params {:q "london"}
          :as :json}))
```

We have added `:as :json` to the options map, and requested the `:body` from the response. Now our response will be a Clojure map that we can query and manipulate.

```clojure
{:message "accurate",
 :cod "200",
 :count 2,
 :list
 [{:coord {:lon -81.23304, :lat 42.983391},
   :name "London",
   :dt 1422645458,
   :wind {:speed 8.76, :deg 327.001},
   :id 6058560,
   :weather
   [{:id 803,
     :main "Clouds",
     :description "broken clouds",
     :icon "04d"}],
   :clouds {:all 68},
   :sys {:country "CA"},
   :main
   {:temp 265.819,
    :temp_min 265.819,
    :temp_max 265.819,
    :pressure 1014.61,
    :sea_level 1041.07,
    :grnd_level 1014.61,
    :humidity 88}}
  {:coord {:lon -0.12574, :lat 51.50853},
   :name "London",
   :dt 1422645312,
   :wind {:speed 2, :gust 2.8, :deg 202},
   :id 2643743,
   :weather
   [{:id 500, :main "Rain", :description "light rain", :icon "10n"}],
   :clouds {:all 88},
   :sys {:country "GB"},
   :main
   {:temp 275.05,
    :humidity 90,
    :pressure 979.2,
    :temp_min 275.05,
    :temp_max 275.05},
   :rain {:3h 1.5}}]}
```

## Now it's your turn!

Use what you've learned to write functions that answer the following questions:

* How many cities called London are there?
* What are the lat/long positions of all the Londons?
* What is the forecasted average temperature for London, UK for the last 5 days?
* What is the forecasted averages temperature of London, UK for the last 10 days?
* How many of the next 10 days is it forecasted to be cloudy?
* How many of the next 10 days is it forecasted not to be cloudy?

## Resources

* [Clojure for the Brave and True](http://www.braveclojure.com/)
* [Try Clojure](http://www.tryclj.com/)
* [Light Table workflow for interactive Clojure development](https://blog.safaribooksonline.com/2013/09/11/light-table-workflow-for-interactive-clojure-development/)
* [Are we there yet?](http://www.infoq.com/presentations/Are-We-There-Yet-Rich-Hickey)
* [Simple Made Easy](http://www.infoq.com/presentations/Simple-Made-Easy)
* [Managing state](http://blog.jayfields.com/2011/04/clojure-state-management.html)
* [Atoms, Refs, Vars](http://programmers.stackexchange.com/questions/143361/clojure-vars-atoms-and-refs-oh-my)
