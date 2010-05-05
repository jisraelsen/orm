module ORM
  class ObjectType
    attr_reader   :uuid
    attr_accessor :name, :is_independent, :is_external, :is_personal, :played_role_refs
    
    def initialize(options={})
      @uuid                 = options[:uuid] || UUID.generate
      self.name             = options[:name]
      self.is_independent   = options[:is_independent].to_boolean
      self.is_external      = options[:is_external].to_boolean
      self.is_personal      = options[:is_personal].to_boolean
      self.played_role_refs = options[:played_role_refs]
    end
  end
end
