require 'commandable'

module RUGS

  class Client
    extend Commandable
    
    command 'stored remotes'
    def remote_list
      @remote_list ||= Config.load("remotes")
    end
 
    command 'remotes that will automatically be added to repos'
    def default_remotes
      @default_remotes ||= remote_list.select do |remote, keys|
        keys[:default]
      end
    end
    
    command 'make and set up a remote'
    def create(repo_name, *remote)
      make_local_repo(repo_name)
      add_defaults(repo_name)
      make_hooks(repo_name)
      
      unless remote.empty?
        just_name = repo_name.split("/").last
        make_remote_repo(just_name, remote.last)
      end
    end
    
    command 'add a remote server to be used when setting up repos'
    def remote_add(remote, url_path, default=false)
      url, path = url_path.split(":")
      
      default = (remote == 'origin' || default == 'default')
      
      remote_list.merge!(remote => {url: url, path: path, default: default})
      Config.save("remotes", remote_list)
    end

    command 'remove a remote server'
    def remote_remove(remote)
      remote_list.delete(remote)
      Config.save("remotes", remote_list)
    end

    command 'make an existing remote a default remote'
    def default(remote, is_default=true)
      remote_list[remote][:default] = is_default
    end

    command 'remove a remote from the default list'
    def undefault(remote)
      default remote, false
    end

    private
    
    def make_local_repo(repo_name)
      return if Dir.exists?("#{repo_name}/.git")
      Git.init(repo_name) 
    end

    def make_remote_repo(repo_name, remote)
      url     = remote_list[remote][:url]
      path    = remote_list[remote][:path]
      default = remote_list[remote][:default]
      
      `ssh #{url} 'git init #{"#{path}/" if path}#{repo_name}.git --bare'`
    end

    def add_defaults(repo_name)
      default_remotes.each do |remote, keys|
        url       = keys[:url]
        path      = keys[:path]
        just_name = repo_name.split("/").last
        
        Git.remote_add(
          repo_name, 
          remote, 
          "#{url}:#{"#{path}/" if path}#{just_name}.git"
        )
      end
    end

    def make_hooks(repo_name)
      FileUtils.mkdir_p "#{repo_name}/git_hooks"
    end
    
  end
  
end