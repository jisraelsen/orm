module ORM
  class Role
    attr_reader   :uuid
    attr_accessor :fact_type, :name, :is_mandatory, :multiplicity, :role_player_ref
    
    def initialize(options={})
      @uuid                 = options[:uuid] || UUID.generate
      self.fact_type        = options[:fact_type]
      self.name             = options[:name]
      self.is_mandatory     = options[:is_mandatory].to_boolean
      self.multiplicity     = options[:multiplicity]
      self.role_player_ref  = options[:role_player_ref]
    end
    
    def role_player
      fact_type.model.object_types.detect{|o| o.uuid == role_player_ref } if fact_type && fact_type.model
    end
  end
end
