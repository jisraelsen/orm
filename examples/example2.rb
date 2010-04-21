require File.dirname(__FILE__) + '/../init'

model = ORM::Parser.parse(File.open(File.dirname(__FILE__) + "/example2.orm"))

puts "Object Types:\n"
model.object_types.map{|o| puts o.inspect }

puts
puts "Fact Types:\n"
model.fact_types.map{|o| puts o.inspect }

puts
puts "Constraints:\n"
model.constraints.map{|o| puts o.inspect }