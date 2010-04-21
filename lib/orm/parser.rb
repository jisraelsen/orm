module ORM
  class Parser
    def self.parse(file)
      doc = Nokogiri::XML(file)
      
      entity_types = doc.xpath('//orm:Objects/orm:EntityType').map do |node|
        ORM::EntityType.new(
          :id => node['id'], 
          :name => node['Name'], 
          :reference_mode => node['_ReferenceMode']
        )
      end
      
      value_types = doc.xpath('//orm:Objects/orm:ValueType').map do |node|
        ORM::ValueType.new(
          :id => node['id'], 
          :name => node['Name']
        )
      end
      
      objectified_types = doc.xpath('//orm:Objects/orm:ObjectifiedType').map do |node|
        ORM::ObjectifiedType.new(
          :id => node['id'], 
          :name => node['Name'],
          :is_independent => node['IsIndependent'],
          :is_personal => node['IsPersonal']
        )
      end
      
      fact_types = doc.xpath('//orm:Facts/orm:Fact').map do |node|
        ORM::FactType.new(
          :id => node['id'], 
          :name => node['_Name']
        )
      end
      
      implied_fact_types = doc.xpath('//orm:Facts/orm:ImpliedFact').map do |node|
        ORM::ImpliedFactType.new(
          :id => node['id'], 
          :name => node['_Name']
        )
      end
      
      # TODO: parse the following
      # <xs:element name="SubtypeFact" type="SubtypeFactTypeType"/>
      
      uniqueness_constraints = doc.xpath('//orm:Constraints/orm:UniquenessConstraint').map do |node|
        ORM::UniquenessConstraint.new(
          :id => node['id'], 
          :name => node['Name'],
          :is_internal => node['IsInternal']
        )
      end
      
      mandatory_constraints = doc.xpath('//orm:Constraints/orm:MandatoryConstraint').map do |node|
        ORM::MandatoryConstraint.new(
          :id => node['id'], 
          :name => node['Name'],
          :is_simple => node['IsSimple'],
          :is_implied => node['IsImplied']
        )
      end
      
      # TODO: parse the following
      # <xs:element name="EqualityConstraint" type="EqualityConstraintType"/>
      # <xs:element name="ExclusionConstraint" type="ExclusionConstraintType"/>
      # <xs:element name="SubsetConstraint" type="SubsetConstraintType"/>
      # <xs:element name="FrequencyConstraint" type="FrequencyConstraintType"/>
      # <xs:element name="RingConstraint" type="RingConstraintType"/>
      
      node = doc.at_xpath('//orm:ORMModel')
      ORM::Model.new(
        :id => node['id'],
        :name => node['Name'],
        :object_types => entity_types+value_types+objectified_types,
        :fact_types => fact_types+implied_fact_types,
        :constraints => uniqueness_constraints+mandatory_constraints
      )
    end
  end
end
