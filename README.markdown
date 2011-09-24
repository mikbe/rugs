# RUGS - RUby Git Setup

A helper script that makes setting up git repositories a snap.  

RUGS has three main functions:  

* Creates a local git repository using default templates or ones you create.
* Sets up a remote repository to mirror your local one.
* Adds a framework of git hooks allowing you to store and run your own hooks in directly from the repo.

RUGS makes creating remote repos as simple as `rugs create repo_name on server_name`. If you have a default server set you don't even have to specify the server you can just run `rugs create repo_name`.  

RUGS even allows you to automatically embed your Git hooks in the repo itself. No more jumping through hoops to make sure your hooks are maintained with your project; with RUGS you just store your hook scripts in the `git_hooks` directory and they're automatically updated and run.  

Once you've set up your project using RUGS you just use Git as you normally would with the exception of your hooks being the in `git_hooks` directory.  

## Status

**In Development**  
Beginning development.