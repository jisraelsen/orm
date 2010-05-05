module ORM
  class FactType
    attr_reader   :model, :uuid
    attr_accessor :name, :roles, :reading_orders, :internal_constraint_refs
		
    def initialize(options={})
      @model                        = options[:model]
      @uuid                         = options[:uuid] || UUID.generate
      self.name                     = options[:name]
      self.roles                    = options[:roles]
      self.reading_orders           = options[:reading_orders]
      self.internal_constraint_refs = options[:internal_constraint_refs]
    end
  end
end
