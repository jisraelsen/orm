module ORM
  class MandatoryConstraint < Constraint
    attr_accessor :role_refs, :is_simple, :is_implied, :implied_by_object_type_ref
    
    def initialize(options={})
      super
      self.role_refs                  = options[:role_refs]
      self.is_simple                  = options[:is_simple].to_boolean
      self.is_implied                 = options[:is_implied].to_boolean
      self.implied_by_object_type_ref = options[:implied_by_object_type_ref]
    end
  end
end
