module ORM
  class ObjectifiedType < ObjectType
    attr_accessor :is_independent, :is_personal
    
    # TODO: implement the following:
    # <xs:element name="Definitions" type="DefinitionsType" minOccurs="0"/>
    # <xs:element name="Notes" type="NotesType" minOccurs="0"/>
    # <xs:element name="Abbreviations" type="AliasesType" minOccurs="0"/>
    # <xs:element name="PlayedRoles" type="PlayedRolesType" minOccurs="0"/>
    # <xs:element name="SubtypeDerivationRule" type="SubtypeDerivationRuleType" minOccurs="0"/>
    
    def initialize(options={})
      super
      
      self.is_independent = options[:is_independent] == "true" ? true : false
      self.is_personal    = options[:is_personal] == "true" ? true : false
    end
  end
end
