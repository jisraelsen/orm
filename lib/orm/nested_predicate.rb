module ORM
  class NestedPredicate
    attr_reader   :uuid
    attr_accessor :objectified_type, :fact_type_ref, :is_implied
    
    def initialize(options={})
      @uuid                 = options[:uuid] || UUID.generate
      self.objectified_type = options[:objectified_type]
      self.fact_type_ref    = options[:fact_type_ref]
      self.is_implied       = options[:is_implied].to_boolean
    end
    
    def fact_type
      objectified_type.model.fact_types.detect{|o| o.uuid == fact_type_ref} if objectified_type && objectified_type.model
    end
  end
end
