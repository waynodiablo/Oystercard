# Walkthrough - Setting up a Database

[Back to Challenge](../04_setting_up_a_database.md)

Setting up Postgres on GNU/Linux systems requires a slightly different approach to Macs. On most Linux systems, postgres is not installed by default. This means you will need to install it, along with its server and libraries:

On Ubuntu/Mint:

```bash
sudo apt-get install postgresql postgresql-contrib postgresql-server-dev-9.3 libpq-dev
```

On Fedora:

```bash
sudo yum install postgresql-server postgresql-contrib libpq-dev
sudo systemctl enable postgresql
sudo postgresql-setup initdb
```

You now need to set up the database user and initial databases. For this you first need to switch to the ‘postgres’ user:

```bash
sudo -i -u postgres
```

You can then create the database user via **either** of the following commands; _not both!_

```bash
createuser --interactive # for interactive user setup…
createuser -drS «USERNAME»  # NB: CAPITAL S! Replace «USERNAME» with your system login name.
```

Return to your normal login using `logout`.

Next you need to create a default database:

```bash
createdb «USERNAME» # Again replace «USERNAME» with your system login name.
```

Check that this new database has been created successfully by logging in to psql and listing the databases:

```bash
psql
# You will now get a new prompt: «USERNAME»=#
\l # or \list
# Check that your database is here
\q # to exit psql
```

Finally, you need to allow your system to modify databases from the localhost without a prompt (this may be a minor security issue depending on who has access to your machine and what you intend to run on it, but experience taught us that getting passwords to work was futile). To do this you need to edit you `pg_hba.conf` file. Depending on your system, this may be in `/var/lib/psql/data` or `/etc/postgres/9.3/main` – use your Unix Command skills from the precourse to find it if necessary! You will need to edit a line in the file (probably as `root` too*):

```bash
# Change…
host    all             all             127.0.0.1/32            md5
# …to…
host    all             all             127.0.0.1/32            trust
```

* If you're unable to change the file due to a permissions problem, use `sudo su` and input your password, and then try again. That will put you into a `root` environment so you can override any permissions.

### Sources

[Postgres on Ubuntu 14.04](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-postgresql-on-ubuntu-14-04)

[Postgres Install on Ubuntu - Github Issue](https://github.com/datamapper/do/issues/66)

[Fedora Wiki](https://fedoraproject.org/wiki/PostgreSQL)

[Next Challenge](../05_creating_your_first_table.md)


![Tracking pixel](https://githubanalytics.herokuapp.com/course/bookmark_manager/walkthroughs/04_linux.md)
