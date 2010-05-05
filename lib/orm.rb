$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__))) unless $LOAD_PATH.include?(File.expand_path(File.dirname(__FILE__)))

require 'rubygems'
require 'active_support'
require 'nokogiri'
require 'uuid'

require "extensions"

require "orm/constraint"
require "orm/uniqueness_constraint"
require "orm/mandatory_constraint"
require "orm/value_constraint"
require "orm/value_range"

require "orm/object_type"
require "orm/entity_type"
require "orm/value_type"
require "orm/objectified_type"
require "orm/nested_predicate"

require "orm/fact_type"
require "orm/implied_fact_type"
require "orm/role"
require "orm/reading_order"
require "orm/reading"

require "orm/data_type"
require "orm/conceptual_data_type"
require "orm/model_note"
require "orm/model_error"
require "orm/reference_mode_kind"

require "orm/model"
require "orm/parser"
