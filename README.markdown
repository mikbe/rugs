# RUGS - RUby Git Setup

A helper script that makes setting up remote git repositories a snap.  

RUGS has three main functions:  

* Creates a local git repository using default templates or ones you create.
* Sets up a remote repository to mirror your local one.
* Adds a framework of git hooks allowing you to store and run your own hooks in directly from the repo.

RUGS makes creating remote repos as simple as `rugs create repo_name on server_name`. A local and remote repo will be created and your default remotes will automatically to the local repo.

[This is to-do functionality so the "instructions" are just brainstorming]
If you want to create just a local repo but add a remote as origin you would do this:  
`rugs create repo_name on server_name using remote as origin`

RUGS even allows you to automatically embed your Git hooks in the repo itself. No more jumping through hoops to make sure your hooks are maintained with your project; with RUGS you just store your hook scripts in the `git_hooks` directory and they're automatically updated and run.  

Once you've set up your project using RUGS you just use Git as you normally would with the exception of your hooks being the in `git_hooks` directory.  

## Status

**Alpha**  
Basic functionality done:

* Stores config info for remotes.
* Sets up local repos.
* Sets up remote repos.
* Automatically adds default remotes to repos.

## To-do

Lots:

* Add setup templates.
* Add hook framework to store and run hooks from the repo itself.
* Deal with existing repos.
* Figure out how to set remotes in a repo as some name other than the remote's name.

Non-functionality stuff:

* Refactor (of course).
* Clean up test, they're really ugly.

## Instructions

* Install the gem.
* Add a remote repo.
* Create a new project.

It might look something like this:

	gem install rugs
	
    rugs remote_add origin git@git-server:/srv/repos/git
    rugs create new_project on origin

