module ORM
  class ImpliedFactType < FactType
    attr_accessor :implied_by_objectification_ref
    
    def initialize(options={})
      super
      self.implied_by_objectification_ref = options[:implied_by_objectification_ref]
    end
    
    def implied_by_objectification
      model.objectified_types.map(&:nested_predicate).flatten.detect{|o| o.uuid == implied_by_objectification_ref } if model
    end
  end
end
