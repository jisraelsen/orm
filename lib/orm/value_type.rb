module ORM
  class ValueType < ObjectType
    attr_reader   :conceptual_data_type, :value_constraint
    attr_accessor :is_implicit_boolean_value
    
    def initialize(options={})
      super
      self.is_implicit_boolean_value  = options[:is_implicit_boolean_value].to_boolean
      self.conceptual_data_type       = options[:conceptual_data_type]
      self.value_constraint           = options[:value_constraint]
    end
    
    def conceptual_data_type=(other)
      other.value_type ||= self if other
      @conceptual_data_type = other
    end
    
    def value_constraint=(other)
      other.value_type ||= self if other
      @value_constraint = other
    end
  end
end
