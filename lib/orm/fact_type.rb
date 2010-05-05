module ORM
  class FactType
    attr_reader   :uuid, :roles, :reading_orders
    attr_accessor :model, :name, :internal_constraint_refs
		
    def initialize(options={})
      @uuid                         = options[:uuid] || UUID.generate
      self.model                    = options[:model]
      self.name                     = options[:name]
      self.roles                    = options[:roles]
      self.reading_orders           = options[:reading_orders]
      self.internal_constraint_refs = options[:internal_constraint_refs]
    end
    
    def roles=(others)
      others.each {|o| o.fact_type ||= self} if others
      @roles = others || []
    end
    
    def reading_orders=(others)
      others.each {|o| o.fact_type ||= self} if others
      @reading_orders = others || []
    end
    
    def internal_constraints
      model.constraints.select{|o| internal_constraint_refs.include?(o.uuid) } if model
    end
  end
end
