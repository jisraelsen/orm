require 'spec_helper'

describe ORM::EntityType do
  
  describe "#initialize" do
    it "assigns @uuid from hashed arguments" do
      entity_type = ORM::EntityType.new(:uuid => "SOMEUUID")
      entity_type.uuid.should == "SOMEUUID"
    end
    
    it "assigns @name from hashed arguments" do
      entity_type = ORM::EntityType.new(:name => "EntityType1337")
      entity_type.name.should == "EntityType1337"
    end
    
    it "assigns @is_independent from hashed arguments" do
      entity_type = ORM::EntityType.new(:is_independent => "true")
      entity_type.is_independent.should == true
      
      entity_type = ORM::EntityType.new(:is_independent => "false")
      entity_type.is_independent.should == false
    end
    
    it "assigns @is_external from hashed arguments" do
      entity_type = ORM::EntityType.new(:is_external => "true")
      entity_type.is_external.should == true
      
      entity_type = ORM::EntityType.new(:is_external => "false")
      entity_type.is_external.should == false
    end
    
    it "assigns @is_personal from hashed arguments" do
      entity_type = ORM::EntityType.new(:is_personal => "true")
      entity_type.is_personal.should == true
      
      entity_type = ORM::EntityType.new(:is_personal => "false")
      entity_type.is_personal.should == false
    end
    
    it "assigns @played_role_refs from hashed arguments" do
      entity_type = ORM::EntityType.new(:played_role_refs => ["SOMEUUID"])
      entity_type.played_role_refs.should == ["SOMEUUID"]
    end
    
    it "assigns @reference_mode from hashed arguments" do
      entity_type = ORM::EntityType.new(:reference_mode => "id")
      entity_type.reference_mode.should == "id"
    end
    
    it "assigns @preferred_identifier_ref from hashed arguments" do
      entity_type = ORM::EntityType.new(:preferred_identifier_ref => "SOMEUUID")
      entity_type.preferred_identifier_ref.should == "SOMEUUID"
    end
    
    context "with no uuid argument provided" do
      it "generates a new UUID" do
        uuid = UUID.generate
        UUID.should_receive(:generate).and_return(uuid)
        
        entity_type = ORM::EntityType.new
        entity_type.uuid.should == uuid
      end
    end
  end
  
  describe "#preferred_identifier" do
    it "returns the ORM::UniquenessConstraint with @uuid = @preferred_identifier_ref" do
      preferred_identifier_ref = UUID.generate
      uniqueness_constraints = [
        ORM::UniquenessConstraint.new, 
        ORM::UniquenessConstraint.new(:uuid => preferred_identifier_ref)
      ]
      entity_type = ORM::EntityType.new(
        :model => mock(ORM::Model, :uniqueness_constraints => uniqueness_constraints),
        :preferred_identifier_ref => preferred_identifier_ref
      )
      entity_type.preferred_identifier.should == uniqueness_constraints[1]
    end
  end
end
