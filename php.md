# An introduction to [PHP](http://php.net/)

If PHP is [not the world's greatest language](http://whydoesitsuck.com/why-does-php-suck/) (a fact [even its creator seems to admit](http://talks.php.net/mx14#/8)) it's certainly [the most popular on the web](http://trends.builtwith.com/framework/programming-language) and one worth being aware of, particularly if you plan to work with WordPress (the world's most popular blogging engine), or Drupal (the most popular open-source CMS).

## Installing PHP

We can install PHP using [Homebrew](http://brew.sh/). Run these commands in the terminal (the final command installs Composer which is PHP's answer to Bundler):

```
brew tap homebrew/dupes
brew tap homebrew/versions
brew tap homebrew/homebrew-php
brew install php56
brew install php56-pdo-pgsql
brew install composer
```

## Hello World

PHP at first glance works a bit like ERB, and historically that was how it was always used, building pages that combine PHP with HTML. If we create a file called `index.php` with the following code:

```php
<html>
  <head>
    <title>Hello world</title>
  </head>
  <body>
    <p>
      Hello world, in unix time it is: <?php echo time(); ?>
    </p>
  </body>
</html>
```

And then start our local server in the command line:

```
php -S localhost:8000
```

If we go to [http://localhost:8000](http://localhost:8000) we should now see an HTML page with PHP embedded in it (PHP is showing us a Unix timestamp). If you refresh the page you should see the number of seconds increase.

> Note that because anything outside a `<?php ?>` block is considered HTML by the PHP interpreter, we **always** need to add a `<?php` to the beginning of our PHP file when executing PHP code, even if there is no HTML on the page at all

## Understanding the syntax

PHP is a bit like JavaScript in that it uses curly braces and semi-colons. It's a bit of a mess in other respects however. Fortunately, the PHP manual is pretty good at explaining things. You can read the [manual's language reference](http://php.net/manual/en/langref.php) here or if you want a quick guide this [reference sheet](http://www.dreamincode.net/downloads/ref_sheets/php_reference_sheet.pdf) is pretty useful.

One thing to note is that although PHP's arrays are pretty familiar, rather than have hashes like Ruby PHP has "associative arrays". This means we can use arrays in two ways:

1) Like we normally would in Ruby:

```php
<?php

$array = array(1,2,3);
$array[] = 4; // Adds 4 to the array
```

2) Kind of like a hash:

```php
<?php

$assoc_array = array('name' => 'PHP', 'weird_quirks' => 23456);

print $assoc_array['name']; // Prints 'PHP'

$assoc_array['author'] = 'Rasmus Lerdorf'; // Adds Rasmus Lerdorf to the associative array
```

Another gotcha is to remember that in PHP FALSE, NULL, 0, and "" are considered false:

```php
<?php

if ("" == FALSE)
{
  print "unbelievably this is true";
}

```

## PHP and OOP

At some point OOP was hacked onto PHP. It improved in PHP 5 but is still by no means as elegant as Ruby. You can learn more in the the [manual](http://php.net/manual/en/language.oop5.basic.php) where we can see this example:

```php
<?php

class SimpleClass
{
    // public property declaration
    public $var = 'a default value';

    // private property declaration
    private $construct_var;

    // constructor
    public function __construct($construct_var) {

       // this is like self in Ruby
       $this->construct_var = $construct_var;
       print "In constructor\n";
   }

    // public method declaration
    public function displayVar() {
        echo $this->var;
        $this->displayPrivate();
    }

    // private method declaration
    private function displayPrivate() {
        echo $this->construct_var;
        echo "Only called within this class";
    }
}
```

We can then instantiate the class by going:

```php
<?php

$object = new SimpleClass('constructor vars');
$object->displayVars(); // Prints out the variables
```

Can you work out the analogies with Ruby?

## Going further

Of course we want to go a bit more advanced than just embedding bits of PHP in the page, and in fact PHP allows us to build an entire MVC application just like we can in Ruby.

For this purpose I recommend you use [Slim](http://www.slimframework.com/), which is pretty similar to Sinatra. We'll also need an ORM: [Laravel](http://laravel.com/) (the equivalent to Rails) has [Eloquent ORM](http://laravel.com/docs/4.2/eloquent) (the equivalent to Active::Record) which is available as a separate package from Composer.

You can follow [this video](https://vimeo.com/112265555) (from around 35 minutes in) to help you get your app started. [This gist](https://gist.github.com/pitchinvasion/17320a48231de57026f9) shows one way of setting up Slim to work with Eloquent ORM and Postgres. Can you get your app [deployed on Heroku](https://devcenter.heroku.com/articles/getting-started-with-php)?

**Watch out for these gotchas:**

* You might get a memory error when installing your composer files, if so run `sudo subl /usr/local/etc/php/5.6/php.ini` and search for memory_limit and change it to **5000M**.
