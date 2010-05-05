require 'spec_helper'

describe ORM::UniquenessConstraint do
  
  describe "#initialize" do
    it "assigns @uuid from hashed arguments" do
      uniqueness_constraint = ORM::UniquenessConstraint.new(:uuid => "SOMEUUID")
      uniqueness_constraint.uuid.should == "SOMEUUID"
    end
    
    it "assigns @name from hashed arguments" do
      uniqueness_constraint = ORM::UniquenessConstraint.new(:name => "InternalUniquenessConstraint1337")
      uniqueness_constraint.name.should == "InternalUniquenessConstraint1337"
    end
    
    it "assigns @role_refs from hashed arguments" do
      uniqueness_constraint = ORM::UniquenessConstraint.new(:role_refs => ["SOMEUUID"])
      uniqueness_constraint.role_refs.should == ["SOMEUUID"]
    end
    
    it "assigns @is_internal from hashed arguments" do
      uniqueness_constraint = ORM::UniquenessConstraint.new(:is_internal => "true")
      uniqueness_constraint.is_internal.should == true
      
      uniqueness_constraint = ORM::UniquenessConstraint.new(:is_internal => "false")
      uniqueness_constraint.is_internal.should == false
    end
    
    it "assigns @preferred_identifier_for_ref from hashed arguments" do
      uniqueness_constraint = ORM::UniquenessConstraint.new(:preferred_identifier_for_ref => "SOMEUUID")
      uniqueness_constraint.preferred_identifier_for_ref.should == "SOMEUUID"
    end
    
    context "with no uuid argument provided" do
      it "generates a new UUID" do
        uuid = UUID.generate
        UUID.should_receive(:generate).and_return(uuid)
        
        uniqueness_constraint = ORM::UniquenessConstraint.new
        uniqueness_constraint.uuid.should == uuid
      end
    end
  end
  
  describe "#roles" do
    it "returns the ORM::Role with @uuid in @role_refs" do
      role_refs = [UUID.generate, UUID.generate]
      fact_types = [
        ORM::FactType.new(:roles => [ORM::Role.new, ORM::Role.new]),
        ORM::FactType.new(:roles => [ORM::Role.new(:uuid => role_refs[0]), ORM::Role.new(:uuid => role_refs[1])]), 
        ORM::FactType.new(:roles => [ORM::Role.new, ORM::Role.new])
      ]
      uniqueness_constraint = ORM::UniquenessConstraint.new(
        :model => mock(ORM::Model, :fact_types => fact_types),
        :role_refs => role_refs
      )
      uniqueness_constraint.roles[0].should == fact_types[1].roles[0]
      uniqueness_constraint.roles[1].should == fact_types[1].roles[1]
    end
  end
  
  describe "#preferred_identifier_for" do
    it "returns the ORM::EntityType with @uuid = @implied_by_object_type_ref" do
      preferred_identifier_for_ref = UUID.generate
      object_types = [
        ORM::ObjectifiedType.new,
        ORM::EntityType.new, 
        ORM::EntityType.new(:uuid => preferred_identifier_for_ref)
      ]
      uniqueness_constraint = ORM::UniquenessConstraint.new(
        :model => mock(ORM::Model, :object_types => object_types),
        :preferred_identifier_for_ref => preferred_identifier_for_ref
      )
      uniqueness_constraint.preferred_identifier_for.should == object_types[2]
    end
  end
end
