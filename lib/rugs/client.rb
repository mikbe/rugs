require 'fileutils'
require 'psych'

module RUGS
  
  class Client
  
    def server_list
      @server_list ||= load_servers
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
      save_servers
    end 

    def on(server)
      @install_server = {server => server_list[server]}
    end

    private
    
    def make_repo(repo_name)
      return if Dir.exists?("#{repo_name}/.git")
      Git.init(repo_name) 
      #Git.remote_add(default_server)
    end

    def make_hooks(repo_name)
      FileUtils.mkdir_p "#{repo_name}/git_hooks"
    end
    
    def load_servers
      return {} unless File.exist?(server_config_file_name)
      Psych.load(File.open(server_config_file_name))
    end
    
    def save_servers
      File.open(server_config_file_name, "w") do |file|
        file.write(server_list.to_yaml)
      end
    end
    
    def server_config_file_name
      @server_config_file_name ||= File.expand_path(
        File.join(File.dirname(__FILE__), "../../config/servers.yaml")
      )
    end
    
  end
  
end