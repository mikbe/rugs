require 'psych'

module RUGS
  
  class Config
    
    def self.load(name)
      return {} unless File.exist?(file_name(name))
      Psych.load(File.open(file_name(name)))
    end
    
    def self.save(name, hash)
      File.open(file_name(name), "w") do |file|
        file.write(hash.to_yaml)
      end
    end
    
    private
    
    def self.file_name(file)
      File.expand_path(
        File.join(File.dirname(__FILE__), "../../config/#{file}.yaml")
      )
    end

  end 

end