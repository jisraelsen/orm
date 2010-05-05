module ORM
  class ObjectifiedType < ObjectType
    attr_reader   :nested_predicate
    attr_accessor :preferred_identifier_ref
    
    def initialize(options={})
      super
      self.preferred_identifier_ref = options[:preferred_identifier_ref]
      self.nested_predicate         = options[:nested_predicate]
    end
    
    def nested_predicate=(other)
      other.objectified_type ||= self if other
      @nested_predicate = other
    end
    
    def preferred_identifier
      model.uniqueness_constraints.detect{|o| o.uuid == preferred_identifier_ref } if model
    end
  end
end
