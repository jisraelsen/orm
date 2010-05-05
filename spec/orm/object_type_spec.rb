require 'spec_helper'

describe ORM::ObjectType do
  
  describe "#initialize" do
    it "assigns @uuid from hashed arguments" do
      object_type = ORM::ObjectType.new(:uuid => "SOMEUUID")
      object_type.uuid.should == "SOMEUUID"
    end
    
    it "assigns @name from hashed arguments" do
      object_type = ORM::ObjectType.new(:name => "ObjectType1337")
      object_type.name.should == "ObjectType1337"
    end
    
    it "assigns @is_independent from hashed arguments" do
      object_type = ORM::ObjectType.new(:is_independent => "true")
      object_type.is_independent.should == true
      
      object_type = ORM::ObjectType.new(:is_independent => "false")
      object_type.is_independent.should == false
    end
    
    it "assigns @is_external from hashed arguments" do
      object_type = ORM::ObjectType.new(:is_external => "true")
      object_type.is_external.should == true
      
      object_type = ORM::ObjectType.new(:is_external => "false")
      object_type.is_external.should == false
    end
    
    it "assigns @is_personal from hashed arguments" do
      object_type = ORM::ObjectType.new(:is_personal => "true")
      object_type.is_personal.should == true
      
      object_type = ORM::ObjectType.new(:is_personal => "false")
      object_type.is_personal.should == false
    end
    
    it "assigns @played_role_refs from hashed arguments" do
      object_type = ORM::ObjectType.new(:played_role_refs => ["SOMEUUID"])
      object_type.played_role_refs.should == ["SOMEUUID"]
    end
    
    context "with no uuid argument provided" do
      it "generates a new UUID" do
        uuid = UUID.generate
        UUID.should_receive(:generate).and_return(uuid)
        
        object_type = ORM::ObjectType.new
        object_type.uuid.should == uuid
      end
    end
  end
  
  describe "#played_roles" do
    it "returns the ORM::Role with @uuid in @played_role_refs" do
      played_role_refs = [UUID.generate, UUID.generate]
      fact_types = [
        ORM::FactType.new(:roles => [ORM::Role.new, ORM::Role.new]),
        ORM::FactType.new(:roles => [ORM::Role.new(:uuid => played_role_refs[0]), ORM::Role.new(:uuid => played_role_refs[1])]), 
        ORM::FactType.new(:roles => [ORM::Role.new, ORM::Role.new])
      ]
      object_type = ORM::ObjectType.new(
        :model => mock(ORM::Model, :fact_types => fact_types),
        :played_role_refs => played_role_refs
      )
      object_type.played_roles[0].should == fact_types[1].roles[0]
      object_type.played_roles[1].should == fact_types[1].roles[1]
    end
  end
  
end
