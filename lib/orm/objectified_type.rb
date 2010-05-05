module ORM
  class ObjectifiedType < ObjectType
    attr_accessor :preferred_identifier_ref, :nested_predicate
    
    def initialize(options={})
      super
      self.preferred_identifier_ref = options[:preferred_identifier_ref]
      self.nested_predicate         = options[:nested_predicate]
    end
  end
end
