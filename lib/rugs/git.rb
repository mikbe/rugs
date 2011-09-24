require 'open3'

module RUGS
  
  # a very simple wrapper for git, only wraps what I nee
  class Git
    
    def self.init(args)
      out, status = Open3.capture2e("git", 'init', args)
      raise Object::Exception(out) if status.exitstatus != 0
      out
    end
    
  end
  
end