PostgreSQL
==========

Postgres is a widely used open source [relational database] engine.

Installation
------------

There are two ways of doing this. Downloading the app will, sometimes, leave
you with a non-working postgresql installation. We recommend the following
method:

2)  In your terminal run

`brew install postgresql`

After homebrew has downloaded the software it will show you some installation
instructions, follow them!

Make sure you run these commands after installing:

```shell
ln -sfv /usr/local/opt/postgresql/*.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist
```

You can check your installation by running

`psql`

At first it can happen that you don't have a database named after your username
(you will see a messags along the lines `database "gypsydave5" does not exist`). Let's
create that database for you so that you can loging without having to specify which one:

`psql postgres`

Which opens up the postgres terminal - it looks something like `postgres=#`.

Then type in the following:

```shell
create database "your_user_name_here";

CREATE DATABASE

postgres=# \q
```
The last command quits out of the postgres terminal.

From now on you will be able to log in to postgresql without having to specify
the database you want to log into.

More fun commands
-----------------


