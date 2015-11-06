# Solution - Setting up a Database

[Back to Challenge](../03_setting_up_a_database.md)

Try installing the Postgres 9.3 server development headers like this:

```sh
  sudo apt-get install postgresql-9.3 postgresql-server-dev-9.3 libpq-dev
```

Suggestion from [here](https://github.com/datamapper/do/issues/66)

If that doesn't work, try using Ruby 2.1.5 (2.1.1 is ideal, but Nitrous won't let you downgrade that far).

[next challenge](../04_creating_your_first_table.md)
