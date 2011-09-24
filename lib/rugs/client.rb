module RUGS
  
  class Client
  
    def server_list
      @server_list ||= Config.load("servers")
    end
 
    def default_servers
      @default_servers ||= server_list.select do |server, keys|
        keys[:default]
      end
    end
    
    def create(repo_name)
      make_repo(repo_name)
      make_hooks(repo_name)
    end
    
    def remote_add(server, url, default=false)
      server_list.merge!(server => {url: url, default: default == "default"})
      Config.save("servers", server_list)
    end 

    # def on(server)
    #   @install_server = {server => server_list[server]}
    # end

    private
    
    def make_repo(repo_name)
      return if Dir.exists?("#{repo_name}/.git")
      Git.init(repo_name) 
    end

    # def add_defaults(repo_name)
    #   #Git.remote_add(default_server)
    #   
    # end

    def make_hooks(repo_name)
      FileUtils.mkdir_p "#{repo_name}/git_hooks"
    end
    
  end
  
end