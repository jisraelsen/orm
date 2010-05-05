module ORM
  class EntityType < ObjectType
    attr_accessor :reference_mode, :preferred_identifier_ref
    
    def initialize(options={})
      super
      self.reference_mode           = options[:reference_mode]
      self.preferred_identifier_ref = options[:preferred_identifier_ref]
    end
  end
end
