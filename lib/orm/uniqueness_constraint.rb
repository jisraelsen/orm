module ORM
  class UniquenessConstraint < Constraint
    attr_accessor :role_refs, :is_internal, :preferred_identifier_for
    
    def initialize(options={})
      super
      self.role_refs                = options[:role_refs]
      self.is_internal              = options[:is_internal].to_boolean
      self.preferred_identifier_for = options[:preferred_identifier_for]
    end
  end
end
