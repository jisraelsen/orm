module ORM
  class ValueType < ObjectType
    attr_accessor :is_implicit_boolean_value
    
    def initialize(options={})
      super
      self.is_implicit_boolean_value = options[:is_implicit_boolean_value] == "true" ? true : false
    end
  end
end
