module ORM
  class ImpliedFactType < FactType
    attr_accessor :implied_by_objectification_ref
    
    def initialize(options={})
      super
      self.implied_by_objectification_ref = options[:implied_by_objectification_ref]
    end
  end
end
