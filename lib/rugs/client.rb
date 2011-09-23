require 'fileutils'

module RUGS
  
  class Client
    
    def self.create(repo_name)
      Git.init(repo_name) unless Dir.exists?("#{repo_name}/.git")
      FileUtils.mkdir_p "#{repo_name}/git_hooks"
    end
    
  end
  
end