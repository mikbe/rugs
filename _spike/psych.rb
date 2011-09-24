require 'fileutils'
require 'psych'

x = {a: "The a", b: "the b"}
fn = "test.yaml"

File.open(fn, "w+") do |file|
  file.write(x.to_yaml)
end

y = Psych.load(File.open(fn))

puts y

z = Psych.load(File.open("no_such_file.yaml"))

puts z