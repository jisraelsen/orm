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
  
end
