# RUGS - RUby Git Setup

A helper script that makes setting up remote git repositories a snap.  

RUGS has three main functions:  

* Creates a local git repository using default templates or ones you create.
* Sets up a remote repository to mirror your local one.
* Adds a framework of git hooks allowing you to store and run your own hooks in directly from the repo.

RUGS makes creating remote repos as simple as `rugs create repo_name on server_name`.

RUGS even allows you to automatically embed your Git hooks in the repo itself. No more jumping through hoops to make sure your hooks are maintained with your project; with RUGS you just store your hook scripts in the `git_hooks` directory and they're automatically updated and run.  

Once you've set up your project using RUGS you just use Git as you normally would with the exception of your hooks being the in `git_hooks` directory.  

## Status

**Alpha**  
Basic functionality done:

* Stores config info for remotes
* Sets up local repos
* Sets up remote repos
* Automatically adds default remotes to repos

## To do

Lots...

* Add setup templates
* Add hook framework to store and run hooks from the repo itself.
* Clean up method output for command line.

## Instructions

* Install the gem.
* Add a remote repo.
* Create a new project

It might look something like this:

	gem install rugs
	
    rugs remote_add origin git@git-server:/srv/repos/git
    rugs create new_project on origin