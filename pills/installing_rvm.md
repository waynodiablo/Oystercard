# Installing RVM

RVM (Ruby enVironment Manager) is a command-line tool which allows you to easily install, manage, and work with multiple ruby environments from interpreters to sets of gems.

Open your Terminal and type this into it:

```
curl -L https://get.rvm.io | bash -s stable --ruby=2.0.0
```

Once that has finished you'll need to type the following command into your terminal to make RVM available in your current session 

```
source ~/.rvm/scripts/rvm
```

And then finally you should type the following in order to tell rvm to use version 2.0.0 of Ruby

```
rvm use 2.0.0
```

You may be asked to install a particular version of Ruby, e.g.

```
rvm install ruby-2.0.0-p451
```

and you may need to enter your administrator password a few times to complete the install.

## Resources

- [RVM](http://rvm.io)
