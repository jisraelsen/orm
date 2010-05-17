module ORM
  module XML
    class Serializer
      attr_reader :model, :xml
    
      def self.serialize(model)
        new(model).serialize
      end
    
      def initialize(model)
        @model = model
      end
    
      def serialize
        @xml = orm_xml
        self
      end
    
      def object_types(xml)
        xml.Objects do
          model.object_types.each do |object_type|
            attributes = ActiveSupport::OrderedHash.new
            attributes[:id] = serialize_uuid(object_type.uuid)
            attributes[:Name] = object_type.name
            attributes[:_ReferenceMode] = object_type.reference_mode if object_type.respond_to?(:reference_mode)
            attributes[:IsImplicitBooleanValue] = object_type.is_implicit_boolean_value if object_type.respond_to?(:is_implicit_boolean_value)
          
            xml.send(object_type.class.name.sub('ORM::',''), attributes) do
              xml.PlayedRoles do
                object_type.played_role_refs.each do |role_ref|
                  xml.Role(:ref => serialize_uuid(role_ref))
                end
              end
            
              xml.PreferredIdentifier(:ref => serialize_uuid(object_type.preferred_identifier_ref)) if object_type.respond_to?(:preferred_identifier_ref)
            
              if object_type.respond_to?(:nested_predicate) && nested_predicate = object_type.nested_predicate
                attributes = ActiveSupport::OrderedHash.new
                attributes[:id] = serialize_uuid(nested_predicate.uuid)
                attributes[:ref] = serialize_uuid(nested_predicate.fact_type_ref)
                attributes[:IsImplied] = nested_predicate.is_implied
              
                xml.NestedPredicate(attributes)
              end
            
              if object_type.respond_to?(:conceptual_data_type) && conceptual_data_type = object_type.conceptual_data_type
                attributes = ActiveSupport::OrderedHash.new
                attributes[:id] = serialize_uuid(conceptual_data_type.uuid)
                attributes[:ref] = serialize_uuid(conceptual_data_type.data_type_ref)
                attributes[:Scale] = conceptual_data_type.scale
                attributes[:Length] = conceptual_data_type.length
              
                xml.ConceptualDataType(attributes)
              end
            
              if object_type.respond_to?(:value_constraint) && value_constraint = object_type.value_constraint
                xml.ValueRestriction do
                  attributes = ActiveSupport::OrderedHash.new
                  attributes[:id] = serialize_uuid(value_constraint.uuid)
                  attributes[:Name] = value_constraint.name
                
                  xml.ValueConstraint(attributes) do
                    xml.ValueRanges do
                      value_constraint.value_ranges.each do |value_range|
                        attributes = ActiveSupport::OrderedHash.new
                        attributes[:id] = serialize_uuid(value_range.uuid)
                        attributes[:MinValue] = value_range.min_value
                        attributes[:MaxValue] = value_range.max_value
                        attributes[:MinInclusion] = value_range.min_inclusion
                        attributes[:MaxInclusion] = value_range.max_inclusion
                      
                        xml.ValueRange(attributes)
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    
      def fact_types(xml)
        xml.Facts do
          model.fact_types.each do |fact_type|
            attributes = ActiveSupport::OrderedHash.new
            attributes[:id] = serialize_uuid(fact_type.uuid)
            attributes[:_Name] = fact_type.name

            xml.send(fact_type.class.name.sub('ORM::','').sub('Type',''), attributes) do
              xml.FactRoles do
                if fact_type.respond_to?(:role_proxies)
                  fact_type.role_proxies.each do |role_proxy|
                    xml.RoleProxy(:id => serialize_uuid(role_proxy.uuid)) do
                      xml.Role(:ref => role_proxy.role_ref)
                    end
                  end
                end
                fact_type.roles.each do |role|
                  attributes = ActiveSupport::OrderedHash.new
                  attributes[:id] = serialize_uuid(role.uuid)
                  attributes[:_IsMandatory] = role.is_mandatory
                  attributes[:_Multiplicity] = role.multiplicity
                  attributes[:Name] = role.name
                
                  xml.Role(attributes) do
                    xml.RolePlayer(:ref => role.role_player_ref)
                  end
                end
              end
            
              xml.ReadingOrders do
                fact_type.reading_orders.each do |reading_order|
                  xml.ReadingOrder(:id => serialize_uuid(reading_order.uuid)) do
                    xml.Readings do
                      xml.Reading(:id => serialize_uuid(reading_order.reading.uuid)) do
                        xml.Data reading_order.reading.text
                      end
                    end
                  
                    xml.RoleSequence do
                      reading_order.roles_and_proxies.each do |role_or_proxy|
                        xml.Role(:ref => serialize_uuid(role_or_proxy.uuid))
                      end
                    end
                  end
                end
              end
            
              xml.InternalConstraints do
                fact_type.internal_constraints.each do |internal_constraint|
                  xml.send(internal_constraint.class.name.sub('ORM::',''), :ref => serialize_uuid(internal_constraint.uuid))
                end
              end
            
              xml.ImpliedByObjectification(:ref => serialize_uuid(fact_type.implied_by_objectification_ref)) if fact_type.respond_to?(:implied_by_objectification_ref)
            end
          end
        end
      end
    
      def constraints(xml)
        xml.Constraints do
          model.constraints.each do |constraint|
            attributes = ActiveSupport::OrderedHash.new
            attributes[:id] = serialize_uuid(constraint.uuid)
            attributes[:Name] = constraint.name
            attributes[:IsInternal] = constraint.is_internal if constraint.respond_to?(:is_internal)
            attributes[:IsSimple] = constraint.is_simple if constraint.respond_to?(:is_simple) && constraint.is_simple
            attributes[:IsImplied] = constraint.is_implied if constraint.respond_to?(:is_implied) && constraint.is_implied

            xml.send(constraint.class.name.sub('ORM::',''), attributes) do
              xml.RoleSequence do
                constraint.role_refs.each do |role_ref|
                  xml.Role(:ref => serialize_uuid(role_ref))
                end
              end
            
              xml.ImpliedByObjectType(:ref => constraint.implied_by_object_type_ref) if constraint.respond_to?(:implied_by_object_type_ref) && constraint.implied_by_object_type_ref
              xml.PreferredIdentifierFor(:ref => constraint.preferred_identifier_for_ref) if constraint.respond_to?(:preferred_identifier_for_ref) && constraint.preferred_identifier_for_ref
            end
          end
        end
      end
    
      def data_types(xml)
        xml.DataTypes do
          model.data_types.each do |data_type|
            xml.send(data_type.class.name.sub('ORM::',''), :id => serialize_uuid(data_type.uuid))
          end
        end
      end
    
      def model_notes(xml)
        xml.ModelNotes do
          model.model_notes.each do |model_note|
            xml.ModelNote(:id => serialize_uuid(model_note.uuid)) do
              xml.Text model_note.text
            end
          end
        end
      end
    
      def model_errors(xml)
        xml.ModelErrors do
          model.model_errors.each do |model_error|
            attributes = ActiveSupport::OrderedHash.new
            attributes[:id] = serialize_uuid(model_error.uuid)
            attributes[:Name] = model_error.name
          
            xml.send(model_error.class.name.sub('ORM::',''), attributes) do
              if model_error.respond_to?(:conceptual_data_type_ref)
                xml.ConceptualDataType(:ref => serialize_uuid(model_error.conceptual_data_type_ref))
              end                    
            end
          end
        end
      end
    
      def reference_mode_kinds(xml)
        xml.ReferenceModeKinds do
          model.reference_mode_kinds.each do |reference_mode_kind|
            attributes = ActiveSupport::OrderedHash.new
            attributes[:id] = serialize_uuid(reference_mode_kind.uuid)
            attributes[:FormatString] = reference_mode_kind.format_string
            attributes[:ReferenceModeType] = reference_mode_kind.reference_mode_type
          
            xml.ReferenceModeKind(attributes)
          end
        end
      end
    
      # using ActiveSupport::OrderedHash to preserve ordering of attributes from original .orm file
      def orm_xml
        template_xml = '<?xml version="1.0" encoding="utf-8"?>
        <ormRoot:ORM2 xmlns:orm="http://schemas.neumont.edu/ORM/2006-04/ORMCore" xmlns:ormDiagram="http://schemas.neumont.edu/ORM/2006-04/ORMDiagram" xmlns:ormRoot="http://schemas.neumont.edu/ORM/2006-04/ORMRoot"></ormRoot:ORM2>'
      
        builder = Nokogiri::XML::Builder.with(Nokogiri::XML(template_xml).at('/ormRoot:ORM2')) do |xml|
          attributes = ActiveSupport::OrderedHash.new
          attributes[:id] = serialize_uuid(model.uuid)
          attributes[:Name] = model.name
        
          xml['orm'].ORMModel(attributes) do
            object_types(xml)
            fact_types(xml)
            constraints(xml)
            data_types(xml) unless model.data_types.blank?
            model_notes(xml) unless model.model_notes.blank?
            model_errors(xml) unless model.model_errors.blank?
            reference_mode_kinds(xml) unless model.reference_mode_kinds.blank?
          end
        end
      
        builder.to_xml
      end
    
      private
        def serialize_uuid(uuid)
          "_#{uuid}"
        end
    end
  end
end