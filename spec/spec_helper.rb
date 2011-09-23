$: << '.'
$:.unshift File.expand_path(File.join(File.dirname(__FILE__), "/../lib"))
require 'rspec'
require 'rugs'

TEMP = "temp_rspec"

def temp_name(length=8)
  "#{TEMP}/" + length.times.map{('a'..'z').to_a.sample}.join
end
