require 'open3'

module RUGS
  
  # a very simple wrapper for git, only wraps what I nee
  class Git
    
    def self.init(repo_name)
      exec 'init', repo_name
    end
    
    def self.remote_add(repo_name, server, url)
      pwd = FileUtils.pwd
      FileUtils.cd repo_name
      exec 'remote', 'add', server, url
      FileUtils.cd pwd
    end

    private
    
    def self.exec(cmd, *args)
      out, status = Open3.capture2e("git", cmd, *args)
      raise Object::Exception(out) if status.exitstatus != 0
      out
    end
    
  end
  
end