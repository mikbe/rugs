$: << '.'
$:.unshift File.expand_path(File.join(File.dirname(__FILE__), "/../lib"))

require 'rspec'
require 'rugs'
require 'fileutils'
require 'tmpdir'

def random_name
  12.times.map{('a'..'z').to_a.sample}.join
end

def clean_config
  FileUtils.rm Dir["#{RUGS::Config::PATH}/*"]
end

def clean_temp 
  FileUtils.rm_rf TEMP_DIR
end

TEMP_DIR = "#{Dir.tmpdir}/#{random_name}"
