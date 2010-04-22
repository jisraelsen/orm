module ORM
  class EntityType < ObjectType
    attr_accessor :reference_mode
    
    def initialize(options={})
      super
      self.reference_mode = options[:reference_mode]
    end
  end
end
