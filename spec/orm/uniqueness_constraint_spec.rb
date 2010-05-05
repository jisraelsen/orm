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
    
    it "assigns @preferred_identifier_for from hashed arguments" do
      uniqueness_constraint = ORM::UniquenessConstraint.new(:preferred_identifier_for => "SOMEUUID")
      uniqueness_constraint.preferred_identifier_for.should == "SOMEUUID"
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
  
end
