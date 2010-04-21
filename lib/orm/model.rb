module ORM
  class Model
    attr_reader   :id
    attr_accessor :name, :object_types, :fact_types, :constraints
    
    # TODO: implement the following:
    # <xs:element name="Definitions" type="DefinitionsType" minOccurs="0"/>
    # <xs:element name="Notes" type="NotesType" minOccurs="0"/>
    # <xs:element name="DataTypes" type="DataTypesType" minOccurs="0"/>
    # <xs:element name="CustomReferenceModes" type="CustomReferenceModesType" minOccurs="0"/>
    # <xs:element name="ModelNotes" type="ModelNotesType" minOccurs="0"/>
    # <xs:element name="ModelErrors" type="ModelErrorsType" minOccurs="0"/>
    # <xs:element name="ReferenceModeKinds" type="ReferenceModeKindsType" minOccurs="0"/>
    # <xs:element name="RecognizedPhrases" type="RecognizedPhrasesType" minOccurs="0"/>
    # <xs:element name="Extensions" type="ExtensionsType" minOccurs="0"/>
    
    def initialize(options={})
      @id               = options[:id]
      self.name         = options[:name]
      self.object_types = options[:object_types]
      self.fact_types   = options[:fact_types]
      self.constraints  = options[:constraints]
    end
  end
end
