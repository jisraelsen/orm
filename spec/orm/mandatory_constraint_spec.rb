require 'spec_helper'

describe ORM::MandatoryConstraint do
  
  describe "#initialize" do
    it "assigns @uuid from hashed arguments" do
      mandatory_constraint = ORM::MandatoryConstraint.new(:uuid => "SOMEUUID")
      mandatory_constraint.uuid.should == "SOMEUUID"
    end
    
    it "assigns @name from hashed arguments" do
      mandatory_constraint = ORM::MandatoryConstraint.new(:name => "SimpleMandatoryConstraint1337")
      mandatory_constraint.name.should == "SimpleMandatoryConstraint1337"
    end
    
    it "assigns @role_refs from hashed arguments" do
      mandatory_constraint = ORM::MandatoryConstraint.new(:role_refs => ["SOMEUUID"])
      mandatory_constraint.role_refs.should == ["SOMEUUID"]
    end
    
    it "assigns @is_simple from hashed arguments" do
      mandatory_constraint = ORM::MandatoryConstraint.new(:is_simple => "true")
      mandatory_constraint.is_simple.should == true
      
      mandatory_constraint = ORM::MandatoryConstraint.new(:is_simple => "false")
      mandatory_constraint.is_simple.should == false
    end
    
    it "assigns @is_implied from hashed arguments" do
      mandatory_constraint = ORM::MandatoryConstraint.new(:is_implied => "true")
      mandatory_constraint.is_implied.should == true
      
      mandatory_constraint = ORM::MandatoryConstraint.new(:is_implied => "false")
      mandatory_constraint.is_implied.should == false
    end
    
    it "assigns @implied_by_object_type_ref from hashed arguments" do
      mandatory_constraint = ORM::MandatoryConstraint.new(:implied_by_object_type_ref => "SOMEUUID")
      mandatory_constraint.implied_by_object_type_ref.should == "SOMEUUID"
    end
    
    context "with no uuid argument provided" do
      it "generates a new UUID" do
        uuid = UUID.generate
        UUID.should_receive(:generate).and_return(uuid)
        
        mandatory_constraint = ORM::MandatoryConstraint.new
        mandatory_constraint.uuid.should == uuid
      end
    end
  end
  
  describe "#implied_by_object_type" do
    it "returns the ORM::ObjectType with @uuid = @implied_by_object_type_ref" do
      implied_by_object_type_ref = UUID.generate
      object_types = [
        ORM::EntityType.new, 
        ORM::ValueType.new(:uuid => implied_by_object_type_ref)
      ]
      mandatory_constraint = ORM::MandatoryConstraint.new(
        :model => mock(ORM::Model, :object_types => object_types),
        :implied_by_object_type_ref => implied_by_object_type_ref
      )
      mandatory_constraint.implied_by_object_type.should == object_types[1]
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
      mandatory_constraint = ORM::MandatoryConstraint.new(
        :model => mock(ORM::Model, :fact_types => fact_types),
        :role_refs => role_refs
      )
      mandatory_constraint.roles[0].should == fact_types[1].roles[0]
      mandatory_constraint.roles[1].should == fact_types[1].roles[1]
    end
  end
  
end
