module ORM
  class Parser
    attr_reader :doc, :model, :diagrams
    
    def self.parse(file)
      new(file).parse
    end
    
    def initialize(file)
      @doc = Nokogiri::XML(file)
    end
    
    def parse
      @model = orm_model
      # @diagrams = orm_diagrams
      self
    end
    
    # object types
    def entity_types
      doc.xpath('//orm:Objects/orm:EntityType').map do |node|
        ORM::EntityType.new(
          :uuid => parse_uuid(node['id']), 
          :name => node['Name'], 
          :reference_mode => node['_ReferenceMode']
        )
      end
    end
    
    def value_types
      doc.xpath('//orm:Objects/orm:ValueType').map do |node|
        ORM::ValueType.new(
          :uuid => parse_uuid(node['id']), 
          :name => node['Name'],
          :is_implicit_boolean_value => node['IsImplicitBooleanValue']
        )
      end
    end
    
    def objectified_types
      doc.xpath('//orm:Objects/orm:ObjectifiedType').map do |node|
        ORM::ObjectifiedType.new(
          :uuid => parse_uuid(node['id']), 
          :name => node['Name'],
          :is_independent => node['IsIndependent'],
          :is_personal => node['IsPersonal']
        )
      end
    end
    
    # fact types
    def fact_types
      doc.xpath('//orm:Facts/orm:Fact').map do |node|
        ORM::FactType.new(
          :uuid => parse_uuid(node['id']), 
          :name => node['_Name']
        )
      end
    end
    
    def implied_fact_types
      doc.xpath('//orm:Facts/orm:ImpliedFact').map do |node|
        ORM::ImpliedFactType.new(
          :uuid => parse_uuid(node['id']), 
          :name => node['_Name']
        )
      end
    end
    
    # constraints
    def uniqueness_constraints
      doc.xpath('//orm:Constraints/orm:UniquenessConstraint').map do |node|
        ORM::UniquenessConstraint.new(
          :uuid => parse_uuid(node['id']), 
          :name => node['Name'],
          :is_internal => node['IsInternal']
        )
      end
    end
    
    def mandatory_constraints
      doc.xpath('//orm:Constraints/orm:MandatoryConstraint').map do |node|
        ORM::MandatoryConstraint.new(
          :uuid => parse_uuid(node['id']), 
          :name => node['Name'],
          :is_simple => node['IsSimple'],
          :is_implied => node['IsImplied']
        )
      end
    end
    
    # data types
    def data_types
      doc.xpath('//orm:DataTypes/*').map do |node|
        "ORM::#{node.name}".constantize.new(
          :uuid => parse_uuid(node['id'])
        )
      end
    end
    
    # model notes
    def model_notes
      doc.xpath('//orm:ModelNotes/orm:ModelNote').map do |node|
        ORM::ModelNote.new(
          :uuid => parse_uuid(node['id']),
          :text => node.at_xpath('//orm:Text').content
        )
      end
    end
    
    # model errors
    def data_type_not_specified_errors
      doc.xpath('//orm:ModelErrors/orm:DataTypeNotSpecifiedError').map do |node|
        ORM::DataTypeNotSpecifiedError.new(
          :uuid => parse_uuid(node['id']),
          :name => node['Name'],
          :conceptual_data_type_ref => parse_uuid(node.at_xpath('//orm:ConceptualDataType')['ref'])
        )
      end
    end
    
    # reference mode kinds
    def reference_mode_kinds
      doc.xpath('//orm:ReferenceModeKind').map do |node|
        ORM::ReferenceModeKind.new(
          :uuid => parse_uuid(node['id']), 
          :format_string => node['FormatString'],
          :reference_mode_type => node['ReferenceModeType']
        )
      end
    end
        
    # orm model
    def orm_model
      node = doc.at_xpath('//orm:ORMModel')
      ORM::Model.new(
        :uuid => parse_uuid(node['id']),
        :name => node['Name'],
        :object_types => entity_types+value_types+objectified_types,
        :fact_types => fact_types+implied_fact_types,
        :constraints => uniqueness_constraints+mandatory_constraints,
        :data_types => data_types,
        :model_notes => model_notes,
        :model_errors => data_type_not_specified_errors,
        :reference_mode_kinds => reference_mode_kinds
      )
    end
    
    private
      def parse_uuid(uuid)
        uuid.to_s.gsub(/^_(.+)$/, "\\1")
      end
  end
end
