require 'psych'

module RUGS
  
  class Config
    
    
    def self.load(name)
      return {} unless File.exist?(config_file(name))
      Psych.load(File.open(config_file(name)))
    end
    
    def self.save(name, hash)
      File.open(config_file(name), "w") do |file|
        file.write(hash.to_yaml)
      end
    end
    
    private
    
    def self.config_file(name)
      build_path(PATH, "#{name}.yaml")
    end

    def self.build_path(root, append)
      File.expand_path(File.join(root, "/#{append}"))
    end

    public 
    
    PATH = build_path(File.dirname(__FILE__), "../../config")
    #File.expand_path(File.join(File.dirname(__FILE__), "/../config"))

  end 

end