# Io (Silver)

First thing's first: silver (nor any other precious metal) has nothing to do with **Io**. I was just trying to think of a good pun for the title of this article. With that said, it's time to learn about everybody's favourite wee language: Io.

So why are we using up valuable Makers time with such an obscure little language? Well, firstly Io is really fun. No, not like your Maths teacher loved Trigonometry - this is actually go out on a Saturday night, get drunk and puke on your shoes kinda fun. At least, as close as you can get in the world of programming...

But perhaps you'd be more impressed if you knew that Io has already been used for some pretty beefy software in various industries - not least animation giants Pixar, who used it to build their rendering engine ['it'](http://web.archive.org/web/20080905015858/http://renderman.pixar.com/products/tools/it.html). Yay cartoons!

## (Proto)typically Speaking...

However, there is also another reason that we are showing you Io as a part of your coding education: Io is a prototype-based language, and will therefore help you navigate the murky waters of Javascript over the coming week. You're welcome.

"What's a prototype-based language, Roi?" Excellent question, have a sticker. So far you will have danced with Object-Oriented languages, and should be familiar with what classes are, and how they fit in with the programs you have been playing with thus far.

As a quick recap, classes can be thought of as a collection of methods, which act as a Blueprint or template for something you wish to represent in your program. In a prototype-based language, the closest equivalent to this would be pre-existing objects that you would *__clone__* "to "become your starting points for objects that you define further. These original (pre-cloned) objects are your prototypes - and they are beautiful in their simplicity.

## Io Who??

Sadly, there is an Io-shaped hole in the internet. It's like a great coffee house that your Soho-savvy friend took you to last week - everything about it makes you smile but you wonder why no-one is using it. There is a beautiful simplicity to this language, and it really deserves some advocacy (like many of the world's underappreciated technologies) and I sincerely hope you will enjoy your experience with Io. Hopefully you will be inspired to build something cool with it, and show the world what they are missing :)

## Getting Started

By far the most comprehensive resource for Io on the internet is the official language documentation over at [iolanguage.org](http://iolanguage.org/). There are some installation instructions on that page WHICH YOU MUST IGNORE OR IT WILL RUIN YOUR LIFE. Instead, do this:

```bash
brew install io
```

Now you should have everything you need to start playing with Io. Navigate to your Terminal emulator of choice, and type 'io'. You should see the following prompt:

```bash
Io>
```

All good? I'm so excited for you right now. Try a little basic maths:

```bash
Io> 1 + 1
==> 2
```

SUCCESS! If you're like me, you'll be feeling pretty cocky right now. But wait there's more:

```bash
Io> a := 1 + 1
==> 2
```
Could it be...?

```bash
Io> a
==> 2
```

Yes people, this little cookie allows you to assign variables. Ok, enough horsing around. We know the [REPL](http://en.wikipedia.org/wiki/Read%E2%80%93eval%E2%80%93print_loop) works, now let's do some serious programming.

Let's say we wanted to make us some Ninja Turtles. Of course you do, it's a hot skill in industry, and also fun. First, you want to create a prototype for a turtle. How do we do this?

```bash
Io> Turtle := Object clone
```

You should see a slightly familiar sight (although the number after 'Turtle_' might be different:

```bash
==>  Turtle_0x7ff732720c40:
  type             = "Turtle"
```

This means you have successfully created a prototypical object of type 'Turtle', which is ready for you to start shaping out of digital clay. Go you.

One of the most obvious differentiations between our beloved Ninja Turtles has and will always be their bandana colour (I was always partial to Donatello - who was your favourite?) So let's give our Turtle the capacity to define a bandana colour:

```bash
Io> Turtle bandana := "some colour"
```

Well this is exciting, isn't it? Let's start reaping the benefits of our awesome (so far) program. Let's make a Leonardo!

```bash
Io> Leonardo := Turtle clone
```

While we're at it, let's see what colour his bandana is set to:

```bash
Io> Leonardo bandana
==> some colour
```

Hmm, that's fine - this means that our Leonardo object has the ability to have a value assigned to 'bandana', so now we just have to set it:

```bash
Io> Leonardo bandana := "Blue"
==> Blue
```

Go ahead and create the rest of the Turtles, and assign their requisite bandana colours - I'll wait here. On the off chance that your childhood was devoid of light and happiness, you might find [this link](http://www.deviantart.com/art/TEENAGE-MUTANT-NINJA-TURTLES-162331870) useful in your endeavours.

So what if we wanted to edit our original Turtle object? What would happen to our newborn individual turtles? Let's find out! I fancy giving them the ability to wield a weapon (for demonstration purposes only):

``` bash
Io> Turtle weapon := "some weapon"
```

Let's check that this has filtered down the foodchain to our turtles, with a random spot check. DONATELLO - I CHOOSE YOU!

```bash
Io> Donatello weapon
==> some weapon
```

Fantastic - now we know that changes to our prototype filter down to the cloned items based on that original object. As you can see, this allows us a great deal of flexibility. Let's get those turtles tooled up!

```bash
Io> Donatello weapon := "Bo Staff"
==> Bo Staff
Io> Raphael weapon := "Sais"
==> Sais
Io> Michaelangelo weapon := "Nunchuckus"
==> Nunchuckus
Io> Leonardo weapon := "Katana"
==> Katana
```

Now this is plenty of fun, but how about we get a method happening? I always loved their irreverent 80s catchphrases, so perhaps we could create a method (or message as they are known in Io) for each turtle to say something cool (a few decades ago):

```bash
Io> Turtle says := method("catchphrase" println)
```

Now we are set to give our little guys a voice. For those of you who weren't present in the 80s (or just not cool during that period), here is a list of possible phrases:

* "Cowabunga"
* "Awesome"
* "Bodacious"
* "Dude"
* "Pizza"

Let's put one of those in action now:

```bash
Io> Michaelangelo says := "COWABUNGA!!!"
```

And with that, it's time for you to accept the keys and take Io for a spin. Be safe, but have fun! You will find plenty of help in the [guide section of the official website](http://iolanguage.org/scm/io/docs/IoGuide.html), and [syntax help in the reference guide](http://iolanguage.org/scm/io/docs/reference/index.html).
































