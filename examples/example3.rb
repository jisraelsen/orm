require File.dirname(__FILE__) + '/../init'

model = ORM::Parser.parse(File.open(File.dirname(__FILE__) + "/example3.orm")).model

# puts "Object Types:\n"
# model.object_types.map{|o| puts o.inspect }

puts
puts "Fact Types:\n"
model.fact_types.each do |o| 
  puts o.verbalizations.first
end
# 
# puts
# puts "Constraints:\n"
# model.constraints.map{|o| puts o.inspect }
# 
# puts
# puts "Data Types:\n"
# model.data_types.map{|o| puts o.inspect }
# 
# puts
# puts "Model Notes:\n"
# model.model_notes.map{|o| puts o.inspect }
# 
# puts
# puts "Model Errors:\n"
# model.model_errors.map{|o| puts o.inspect }
# 
# puts
# puts "Reference Mode Kinds:\n"
# model.reference_mode_kinds.map{|o| puts o.inspect }
