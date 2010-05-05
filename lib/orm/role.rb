module ORM
  class Role
    attr_reader   :uuid
    attr_accessor :name, :is_mandatory, :multiplicity, :role_player_ref
    
    def initialize(options={})
      @uuid                 = options[:uuid] || UUID.generate
      self.name             = options[:name]
      self.is_mandatory     = options[:is_mandatory].to_boolean
      self.multiplicity     = options[:multiplicity]
      self.role_player_ref  = options[:role_player_ref]
    end
  end
end
