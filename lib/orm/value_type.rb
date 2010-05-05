module ORM
  class ValueType < ObjectType
    attr_accessor :is_implicit_boolean_value, :conceptual_data_type, :value_constraint
    
    def initialize(options={})
      super
      self.is_implicit_boolean_value  = options[:is_implicit_boolean_value].to_boolean
      self.conceptual_data_type       = options[:conceptual_data_type]
      self.value_constraint           = options[:value_constraint]
    end
  end
end
