##Deploying Client-Side Apps on Github-io

__Sources:__

* [Github Help: Creating Project Pages Manually](https://help.github.com/articles/creating-project-pages-manually)
* [StackOverflow: How to Fetch a Remote Branch with Git](http://stackoverflow.com/questions/9537392/git-fetch-remote-branch)


###General Notes

* This walkthrough describes the steps for deployment of simple client-side 
apps on [Github](https://github.com) using the [Github-io](https://pages.github.com) 
(aka [Github-Pages](https://pages.github.com)) server system.

* If your project requires only [HTML](http://en.wikipedia.org/wiki/HTML) pages,
  [CSS](http://www.w3schools.com/css/css3_intro.asp), 
  [Javascript](http://en.wikipedia.org/wiki/JavaScript), and it's various derivatives 
  like [jQuery](http://jquery.com), this is a great (and free!) way to deploy it.

* One main advantages of using Github's deployment platform is that 
  the process is much less opeque and debugging in case 
  of a faliure is much easier. Another advantage is upload speed since Github pages 
  typically become available fairly quickly 
  (unlike Heroku which tends to be somewhat slow in this respect).  

* Text in ALL_CAPITALS_AND_UNDERSCORES indicated a __placeholder__ for your own text 


###Initial Preparation

If you want to keep things really simple, you can create a single, `HTML` file 
that will combine the content of the entire project, that is: `HTML` content, 
`CSS` styling &amp; `JavaScript` scripts, like so:

```html
<!DOCTYPE html>
<html>
	<head>
	    <title>APP_NAME</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<style>
				/*CSS code goes here*/
		</style>
	</head>
	<body>

	</body>
	<script type="text/javascript">
			  <!-- Javascript Code goes here -->
	</script>
</html>
```

Alternatively, you can use separate `HTML`, `CSS` &amp; `JavaScript` files 
as usual and without any alternation.

Either way, before moving forward, check that all the content is there working 
as it should by opening the app's `HTML` file in the browser:

```bash
$> open ./APP_NAME.html
```


###Cloning the Remote Repo

Make sure your remote repo is syncronized with the local one, and then 
__clone the remote repo to a new location in your file system__
(this is a safety measure to make sure the original 
local repo remains untouched in case something goes wrong during the deployment 
process):

```bash
$new_location> git clone REMOTE_REPO_GITHUB_ADDRESS
```

Next, change directory into the newly cloned repo's folder:

```bash
$new location> cd REPO_NAME
```


###Creating a New Branch

Now it's time to create a new branch using __these specific flags__:

```bash
$> git checkout --orphan gh-pages
=> Switched to a new branch 'gh-pages'
```

Note that at this point the new branch, `gh-pages`, will not show on the 
branches list when running 'git branch'. Even so, notice that `master` no longer 
shows as the active branch (i.e. neither marked with an * nor coloured green).


###Editing the New Branch

If you've been using a [Sinatra](http://www.sinatrarb.com/) server, 
the [shotgun](https://github.com/rtomayko/shotgun) gem and all the files 
typically used for development (`config.ru`, `Gemfile`, etc.), they all need to 
be removed (that's the main reason why we __cloned__ our original 
repo to the new location).

In the new branch, leave only your `HTML`, `CSS` &amp; `JavaScript` files 
(or just the single `HTML` file if that's what you're using).

Once again, check that everything works locally.

It is also a good idea to keep your `README.md` file (this will 
make no difference to the diployment process).


###Pushing the Project Page

Once the cleanup is done, stage, commit and push the new branch 
to the Github remote:

Take care to push to the __`gh-pages`__ branch and not to `master`!

```bash
$> git add .
$> git commit -m "First gh-pages commit"
$> git push origin gh-pages
```

After the first push, it may take up to ten minutes before the new GitHub page 
becomes available.


###First Look at the Project Page

Check and see that the app is available at:

```
http://GITHUB_USERNAME.github.io/REPO_NAME
```


###Pulling the New Branch into the Original Local Repo

Go back to the original local repo and pull the new branch:

```bash
$> git fetch origin gh-pages:gh-pages
```

If everything went well, delete the folder containing the cloned repo and 
you're done.

That's it :-)

