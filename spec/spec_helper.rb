$: << '.'
$:.unshift File.expand_path(File.join(File.dirname(__FILE__), "/../lib"))

require 'rspec'
require 'rugs'
require 'fileutils'

TEMP    = File.expand_path(File.join(File.dirname(__FILE__), "/../temp_rspec"))
CONFIG  = File.expand_path(File.join(File.dirname(__FILE__), "/../config"))

def temp_file(length=12)
  "#{TEMP}/" + length.times.map{('a'..'z').to_a.sample}.join
end

def clean_config
  FileUtils.rm Dir["#{CONFIG}/*"]
end

def clean_temp
  FileUtils.rm_rf TEMP
end

