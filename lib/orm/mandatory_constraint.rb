module ORM
  class MandatoryConstraint < Constraint
    attr_accessor :is_simple, :is_implied
    
    # TODO: implement the following:
    # <xs:element name="ExclusiveOrExclusionConstraint" type="ExclusionConstraintRef" minOccurs="0"/>
    # <xs:element name="ImpliedByObjectType" type="ObjectTypeRef" minOccurs="0"/>
    # <xs:element name="Extensions" type="ExtensionsType" minOccurs="0"/>
    
    def initialize(options={})
      super
      self.is_simple  = options[:is_simple] == "true" ? true : false
      self.is_implied = options[:is_implied] == "true" ? true : false
    end
  end
end
