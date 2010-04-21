require 'rubygems'
require 'active_support'
require 'nokogiri'

$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__))) unless $LOAD_PATH.include?(File.expand_path(File.dirname(__FILE__)))

require "orm/constraint"
require "orm/uniqueness_constraint"
require "orm/mandatory_constraint"

require "orm/object_type"
require "orm/entity_type"
require "orm/value_type"
require "orm/objectified_type"

require "orm/fact_type"
require "orm/implied_fact_type"

require "orm/model"
require "orm/parser"

model = ORM::Parser.parse(File.open(File.dirname(__FILE__) + "/../examples/MOA140_As1_Solution.orm"))

puts "Object Types:\n"
model.object_types.map{|o| puts o.inspect }

puts
puts "Fact Types:\n"
model.fact_types.map{|o| puts o.inspect }

puts
puts "Constraints:\n"
model.constraints.map{|o| puts o.inspect }