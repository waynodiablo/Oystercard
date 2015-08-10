# PostgreSQL

Postgres is a widely used open source [relational database](http://en.wikipedia.org/wiki/Relational_database) engine.

### Installation

(Linux users may want to start [here](postgres_linux.md) and Nitrous users may want to start [here](postgres_nitrous.md)

There are two ways of doing this. Firstly, you can download the PostgreSQL app. However, the app can sometimes be problematic, and actually leave you with a non-working PostgreSQL installation.

**We recommend the following method:**

In your terminal run `brew install postgresql`

After homebrew has downloaded the software it will show you some installation instructions, follow them!

Make sure you run these commands after installing:

```shell
ln -sfv /usr/local/opt/postgresql/*.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist
```

You can check your installation by running `psql`

At first it can happen that you don't have a database named after your username (you will see a message along the lines `database "your_computer_username" does not exist`).

Let's create that database for you so that you can log in without having to specify which one: `psql postgres`

Which opens up the postgres terminal - it looks something like `postgres=#`.

Then type in the following:

```
create database "your_user_name_here";

CREATE DATABASE

postgres=# \q
```
The last command quits out of the postgres terminal.

From now on you will be able to log in to postgresql without having to specify the database you want to log into.

Checkout the [playing_with_postgres_and_datamapper.md](Playing with Postgres and DataMapper pill) for an introduction on using Postgres and how it works with an ORM, DataMapper.
