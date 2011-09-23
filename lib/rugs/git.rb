require 'open3'

module RUGS
  
  # a very dumb wrapper for git
  class Git
    
    def self.method_missing(meth, args)    
      out, status = Open3.capture2e("git", meth.to_s, args)
      raise Object::Exception(out) if status.exitstatus != 0
      out
    end
    
  end
  
end