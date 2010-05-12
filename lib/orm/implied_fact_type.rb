module ORM
  class ImpliedFactType < FactType
    attr_reader   :role_proxies
    attr_accessor :implied_by_objectification_ref
    
    def initialize(options={})
      super
      self.role_proxies                   = options[:role_proxies]
      self.implied_by_objectification_ref = options[:implied_by_objectification_ref]
    end
    
    def role_proxies=(others)
      others.each {|o| o.fact_type ||= self} if others
      @role_proxies = others || []
    end
    
    def implied_by_objectification
      model.objectified_types.map(&:nested_predicate).flatten.detect{|o| o.uuid == implied_by_objectification_ref } if model
    end
  end
end
