module ORM
  class NestedPredicate
    attr_reader   :uuid
    attr_accessor :fact_type_ref, :is_implied
    
    def initialize(options={})
      @uuid               = options[:uuid] || UUID.generate
      self.fact_type_ref  = options[:fact_type_ref]
      self.is_implied     = options[:is_implied].to_boolean
    end
  end
end
