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
    
    def implied_by_object_type
      model.object_types.detect{|o| o.uuid == implied_by_object_type_ref} if model
    end
    
    def roles
      role_refs.map{|role_ref| model.fact_types.map(&:roles).flatten.detect{|o| o.uuid == role_ref }} if model
    end
  end
end
