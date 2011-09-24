module RUGS
  
  class Client
  
    attr_reader :current_remote
  
    def remote_list
      @remote_list ||= Config.load("remotes")
    end
 
    def default_remotes
      @default_remotes ||= remote_list.select do |remote, keys|
        keys[:default]
      end
    end
    
    def create(repo_name)
      make_repo(repo_name)
      add_defaults(repo_name)
      make_hooks(repo_name)
    end
    
    def remote_add(remote, url, default=false)
      remote_list.merge!(remote => {url: url, default: default == "default"})
      Config.save("remotes", remote_list)
    end 

    def remote_remove(remote)
      remote_list.delete(remote)
      Config.save("remotes", remote_list)
    end

    def on(remote)
      @current_remote = {remote => remote_list[remote]}
    end

    def default(remote, is_default=true)
      remote_list[remote][:default] = is_default
    end

    def undefault(remote)
      default remote, false
    end

    private
    
    def make_repo(repo_name)
      return if Dir.exists?("#{repo_name}/.git")
      Git.init(repo_name) 
    end

    def add_defaults(repo_name)
      default_remotes.each do |remote, keys|
        Git.remote_add(repo_name, remote, keys[:url])
      end
    end

    def make_hooks(repo_name)
      FileUtils.mkdir_p "#{repo_name}/git_hooks"
    end
    
  end
  
end