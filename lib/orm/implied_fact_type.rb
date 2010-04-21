module ORM
  class ImpliedFactType
    attr_reader   :id
    attr_accessor :name

    # TODO: implement the following
    # <xs:element name="Definitions" type="DefinitionsType" minOccurs="0"/>
    # <xs:element name="Notes" type="NotesType" minOccurs="0"/>
    # <xs:element name="FactRoles" type="ImpliedFactRolesType" minOccurs="0"/>
    # <xs:element name="ReadingOrders" type="ReadingOrdersType" minOccurs="0"/>
    # <xs:element name="InternalConstraints" type="InternalConstraintsType" minOccurs="0"/>
    # <xs:element name="DerivationRule" type="FactTypeDerivationRuleType" minOccurs="0"/>
    # <xs:element name="ImpliedByObjectification" type="ObjectificationRef"/>
    # <xs:element name="Extensions" type="ExtensionsType" minOccurs="0"/>
		
    def initialize(options={})
      @id               = options[:id]
      self.name         = options[:name]
    end
  end
end
