module ORM
  class Parser
    attr_reader :doc, :model
    
    def self.parse(file)
      new(file).parse
    end
    
    def initialize(file)
      @doc = Nokogiri::XML(file)
    end
    
    def parse
      @model = orm_model
      self
    end
    
    # object types
    def entity_types
      doc.xpath('//orm:Objects/orm:EntityType').map do |node|
        ORM::EntityType.new(
          :uuid => parse_uuid(node['id']), 
          :name => node['Name'], 
          :reference_mode => node['_ReferenceMode'],
          :preferred_identifier_ref => parse_uuid(node.at_xpath('orm:PreferredIdentifier')['ref']),
          :played_role_refs => node.xpath('orm:PlayedRoles/orm:Role').map {|n| parse_uuid(n['ref'])}
        )
      end
    end
    
    def value_types
      doc.xpath('//orm:Objects/orm:ValueType').map do |node|
        value_type = ORM::ValueType.new(
          :uuid => parse_uuid(node['id']), 
          :name => node['Name'],
          :is_implicit_boolean_value => node['IsImplicitBooleanValue'],
          :played_role_refs => node.xpath('orm:PlayedRoles/orm:Role').map {|n| parse_uuid(n['ref'])}
        )
        
        if conceptual_data_type_node = node.at_xpath('orm:ConceptualDataType')
          value_type.conceptual_data_type = ORM::ConceptualDataType.new(
            :uuid => parse_uuid(conceptual_data_type_node['id']),
            :data_type_ref => parse_uuid(conceptual_data_type_node['ref']),
            :scale => conceptual_data_type_node['Scale'],
            :length => conceptual_data_type_node['Length']
          )
        end
        
        if value_constraint_node = node.at_xpath('orm:ValueRestriction//orm:ValueConstraint')
          value_type.value_constraint = ORM::ValueConstraint.new(
            :uuid => parse_uuid(value_constraint_node['id']),
            :name => value_constraint_node['Name'],
            :value_ranges => node.xpath('//orm:ValueRanges/orm:ValueRange').map {|n| 
              ORM::ValueRange.new(
                :uuid => parse_uuid(n['id']),
                :min_value => n['MinValue'],
                :max_value => n['MaxValue'],
                :min_inclusion => n['MinInclusion'],
                :max_inclusion => n['MaxInclusion']
              )
            }
          )
        end
        
        value_type
      end
    end
    
    def objectified_types
      doc.xpath('//orm:Objects/orm:ObjectifiedType').map do |node|
        objectified_type = ORM::ObjectifiedType.new(
          :uuid => parse_uuid(node['id']), 
          :name => node['Name'],
          :is_independent => node['IsIndependent'],
          :is_personal => node['IsPersonal'],
          :preferred_identifier_ref => parse_uuid(node.at_xpath('orm:PreferredIdentifier')['ref']),
          :played_role_refs => node.xpath('orm:PlayedRoles/orm:Role').map {|n| parse_uuid(n['ref'])}
        )
        
       if nested_predicate_node = node.at_xpath('orm:NestedPredicate')
          objectified_type.nested_predicate = ORM::NestedPredicate.new(
            :uuid => parse_uuid(nested_predicate_node['id']),
            :fact_type_ref => parse_uuid(nested_predicate_node['ref']),
            :is_implied => nested_predicate_node['IsImplied']
          )
        end
          
        objectified_type
      end
    end
    
    # fact types
    def fact_types
      doc.xpath('//orm:Facts/orm:Fact').map do |node|
        ORM::FactType.new(
          :uuid => parse_uuid(node['id']), 
          :name => node['_Name'],
          :roles => node.xpath('orm:FactRoles/orm:Role').map {|n| 
            ORM::Role.new(
              :uuid => parse_uuid(n['id']),
              :name => n['Name'],
              :is_mandatory => n['_IsMandatory'],
              :multiplicity => n['_Multiplicity'],
              :role_player_ref => parse_uuid(n.at_xpath('orm:RolePlayer')['ref'])
            )
          },
          :reading_orders => node.xpath('orm:ReadingOrders/orm:ReadingOrder').map {|n| 
            reading_order = ORM::ReadingOrder.new(
              :uuid => parse_uuid(n['id']),
              :role_refs => n.xpath('orm:RoleSequence/orm:Role').map {|role| parse_uuid(role['ref'])}
            )
            
            if reading_node = n.at_xpath('orm:Readings//orm:Reading')
              reading_order.reading = ORM::Reading.new(
                :uuid => parse_uuid(reading_node['id']),
                :text => reading_node.at_xpath('orm:Data').content
              )
            end
            
            reading_order
          },
          :internal_constraint_refs => node.xpath('orm:InternalConstraints/*').map {|n| parse_uuid(n['ref'])}
        )
      end
    end
    
    def implied_fact_types
      doc.xpath('//orm:Facts/orm:ImpliedFact').map do |node|
        ORM::ImpliedFactType.new(
          :uuid => parse_uuid(node['id']), 
          :name => node['_Name'],
          :roles => node.xpath('orm:FactRoles/orm:Role').map {|n| 
            ORM::Role.new(
              :uuid => parse_uuid(n['id']),
              :name => n['Name'],
              :is_mandatory => n['_IsMandatory'],
              :multiplicity => n['_Multiplicity'],
              :role_player_ref => parse_uuid(n.at_xpath('orm:RolePlayer')['ref'])
            )
          },
          :reading_orders => node.xpath('orm:ReadingOrders/orm:ReadingOrder').map {|n| 
            reading_order = ORM::ReadingOrder.new(
              :uuid => parse_uuid(n['id']),
              :role_refs => n.xpath('orm:RoleSequence/orm:Role').map {|role| parse_uuid(role['ref'])}
            )
            
            if reading_node = n.at_xpath('orm:Readings//orm:Reading')
              reading_order.reading = ORM::Reading.new(
                :uuid => parse_uuid(reading_node['id']),
                :text => reading_node.at_xpath('orm:Data').content
              )
            end
            
            reading_order
          },
          :internal_constraint_refs => node.xpath('orm:InternalConstraints/*').map {|n| parse_uuid(n['ref'])},
          :implied_by_objectification_ref => parse_uuid(node.at_xpath('orm:ImpliedByObjectification')['ref'])
        )
      end
    end
    
    # constraints
    def uniqueness_constraints
      doc.xpath('//orm:Constraints/orm:UniquenessConstraint').map do |node|
        uniqueness_constraint = ORM::UniquenessConstraint.new(
          :uuid => parse_uuid(node['id']), 
          :name => node['Name'],
          :role_refs => node.xpath('orm:RoleSequence/orm:Role').map {|n| parse_uuid(n['ref'])},
          :is_internal => node['IsInternal']
        )
        
        if preferred_identifier_for_ref_node = node.at_xpath('orm:PreferredIdentifierFor')
          uniqueness_constraint.preferred_identifier_for_ref = parse_uuid(preferred_identifier_for_ref_node['ref'])
        end
        
        uniqueness_constraint
      end
    end
    
    def mandatory_constraints
      doc.xpath('//orm:Constraints/orm:MandatoryConstraint').map do |node|
        mandatory_constraint = ORM::MandatoryConstraint.new(
          :uuid => parse_uuid(node['id']), 
          :name => node['Name'],
          :role_refs => node.xpath('orm:RoleSequence/orm:Role').map {|n| parse_uuid(n['ref'])},
          :is_simple => node['IsSimple'],
          :is_implied => node['IsImplied']
        )
        
        if implied_by_object_type_ref_node = node.at_xpath('orm:ImpliedByObjectType')
          mandatory_constraint.implied_by_object_type_ref = parse_uuid(implied_by_object_type_ref_node['ref'])
        end
        
        mandatory_constraint
      end
    end
    
    # data types
    def data_types
      doc.xpath('//orm:DataTypes/*').map do |node|
        "ORM::#{node.name}".constantize.new(
          :model => @model,
          :uuid => parse_uuid(node['id'])
        )
      end
    end
    
    # model notes
    def model_notes
      doc.xpath('//orm:ModelNotes/orm:ModelNote').map do |node|
        ORM::ModelNote.new(
          :uuid => parse_uuid(node['id']),
          :text => node.at_xpath('orm:Text').content
        )
      end
    end
    
    # model errors -- only DataTypeNotSpecifiedErrors for now
    def model_errors
      doc.xpath('//orm:ModelErrors/*').map do |node|
        model_error = "ORM::#{node.name}".constantize.new(
          :uuid => parse_uuid(node['id']),
          :name => node['Name']
        )
        
        if conceptual_data_type_ref_node = node.at_xpath('orm:ConceptualDataType')
          model_error.conceptual_data_type_ref = parse_uuid(conceptual_data_type_ref_node['ref'])
        end
        
        model_error
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
        :object_types => entity_types + value_types + objectified_types,
        :fact_types => fact_types + implied_fact_types,
        :constraints => uniqueness_constraints + mandatory_constraints,
        :data_types => data_types,
        :model_notes => model_notes,
        :model_errors => model_errors,
        :reference_mode_kinds => reference_mode_kinds
      )
    end
    
    private
      def parse_uuid(uuid)
        uuid.to_s.gsub(/^_(.+)$/, "\\1")
      end
  end
end
