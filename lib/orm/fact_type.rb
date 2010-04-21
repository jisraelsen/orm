module ORM
  class FactType
    attr_reader   :id
    attr_accessor :name

    # TODO: implement the following
    # <xs:element name="Definitions" type="DefinitionsType" minOccurs="0"/>
    # <xs:element name="Notes" type="NotesType" minOccurs="0"/>
    # <xs:element name="FactRoles" type="FactRolesType" minOccurs="0"/>
    # <xs:element name="ReadingOrders" type="ReadingOrdersType" minOccurs="0"/>
    # <xs:element name="InternalConstraints" type="InternalConstraintsType" minOccurs="0"/>
    # <xs:element name="DerivationRule" type="FactTypeDerivationRuleType" minOccurs="0"/>
    # <xs:element name="Instances" type="FactTypeInstancesType" minOccurs="0"/>
    # <xs:element name="Extensions" type="ExtensionsType" minOccurs="0"/>
		
    def initialize(options={})
      @id               = options[:id]
      self.name         = options[:name]
    end
  end
end
