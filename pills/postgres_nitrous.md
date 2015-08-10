# Installing Postgres on Nitrous

For the most part, you can follow the regular tutorial. If you run into issues, try the following:

### Issues installing the `do_postgres` gem

Try installing the Postgres 9.3 server header files like this:

```sh
sudo apt-get install postgresql-9.3 postgresql-server-dev-9.3 libpq-dev
```

Suggestion from [here](https://github.com/datamapper/do/issues/66)

If that doesn't work, try using Ruby 2.1.5 (2.1.1 is ideal, but Nitrous won't let you downgrade that far).