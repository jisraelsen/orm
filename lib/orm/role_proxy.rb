module ORM
  class RoleProxy
    attr_reader   :uuid
    attr_accessor :fact_type, :role_ref
    
    def initialize(options={})
      @uuid           = options[:uuid] || UUID.generate
      self.fact_type  = options[:fact_type]
      self.role_ref   = options[:role_ref]
    end
    
    def role
      fact_type.model.fact_types.map(&:roles).flatten.detect{|o| o.uuid == role_ref } if fact_type && fact_type.model
    end
  end
end
