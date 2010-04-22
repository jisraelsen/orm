module ORM
  class Model
    attr_reader   :uuid
    attr_accessor :name, :object_types, :fact_types, :constraints
    attr_accessor :data_types, :model_notes, :model_errors, :reference_mode_kinds
    
    # TODO: implement the following:
    # <xs:element name="Definitions" type="DefinitionsType" minOccurs="0"/>
    # <xs:element name="Notes" type="NotesType" minOccurs="0"/>
    # <xs:element name="CustomReferenceModes" type="CustomReferenceModesType" minOccurs="0"/>
    # <xs:element name="RecognizedPhrases" type="RecognizedPhrasesType" minOccurs="0"/>
    # <xs:element name="Extensions" type="ExtensionsType" minOccurs="0"/>
    
    def initialize(options={})
      @uuid                     = options[:uuid] || UUID.generate
      self.name                 = options[:name]
      self.object_types         = options[:object_types]
      self.fact_types           = options[:fact_types]
      self.constraints          = options[:constraints]
      self.data_types           = options[:data_types]
      self.model_notes          = options[:model_notes]
      self.model_errors         = options[:model_errors]
      self.reference_mode_kinds = options[:reference_mode_kinds]
    end
  end
end
