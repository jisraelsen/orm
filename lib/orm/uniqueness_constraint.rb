module ORM
  class UniquenessConstraint < Constraint
    attr_accessor :role_refs, :is_internal, :preferred_identifier_for_ref
    
    def initialize(options={})
      super
      self.role_refs                    = options[:role_refs]
      self.is_internal                  = options[:is_internal].to_boolean
      self.preferred_identifier_for_ref = options[:preferred_identifier_for_ref]
    end
    
    def roles
      role_refs.map{|role_ref| model.fact_types.map(&:roles).flatten.detect{|o| o.uuid == role_ref }} if model
    end

    def preferred_identifier_for
      model.object_types.detect{|o| o.uuid == preferred_identifier_for_ref} if model
    end
  end
end
