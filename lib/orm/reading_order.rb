module ORM
  class ReadingOrder
    attr_reader   :uuid, :reading
    attr_accessor :fact_type, :role_refs
    
    def initialize(options={})
      @uuid           = options[:uuid] || UUID.generate
      self.fact_type  = options[:fact_type]
      self.reading    = options[:reading]
      self.role_refs  = options[:role_refs]
    end
    
    def reading=(other)
      other.reading_order ||= self if other
      @reading = other
    end
    
    def roles
      fact_type.roles.select{|o| role_refs.include?(o.uuid) } if fact_type
    end
  end
end
