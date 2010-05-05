require 'spec_helper'

describe ORM::ObjectifiedType do
  
  describe "#initialize" do
    it "assigns @uuid from hashed arguments" do
      objectified_type = ORM::ObjectifiedType.new(:uuid => "SOMEUUID")
      objectified_type.uuid.should == "SOMEUUID"
    end
    
    it "assigns @name from hashed arguments" do
      objectified_type = ORM::ObjectifiedType.new(:name => "ObjectifiedType1337")
      objectified_type.name.should == "ObjectifiedType1337"
    end
    
    it "assigns @is_independent from hashed arguments" do
      objectified_type = ORM::ObjectifiedType.new(:is_independent => "true")
      objectified_type.is_independent.should == true
      
      objectified_type = ORM::ObjectifiedType.new(:is_independent => "false")
      objectified_type.is_independent.should == false
    end
    
    it "assigns @is_external from hashed arguments" do
      objectified_type = ORM::ObjectifiedType.new(:is_external => "true")
      objectified_type.is_external.should == true
      
      objectified_type = ORM::ObjectifiedType.new(:is_external => "false")
      objectified_type.is_external.should == false
    end
    
    it "assigns @is_personal from hashed arguments" do
      objectified_type = ORM::ObjectifiedType.new(:is_personal => "true")
      objectified_type.is_personal.should == true
      
      objectified_type = ORM::ObjectifiedType.new(:is_personal => "false")
      objectified_type.is_personal.should == false
    end
    
    it "assigns @played_role_refs from hashed arguments" do
      objectified_type = ORM::ObjectifiedType.new(:played_role_refs => ["SOMEUUID"])
      objectified_type.played_role_refs.should == ["SOMEUUID"]
    end
    
    it "assigns @preferred_identifier_ref from hashed arguments" do
      objectified_type = ORM::ObjectifiedType.new(:preferred_identifier_ref => "SOMEUUID")
      objectified_type.preferred_identifier_ref.should == "SOMEUUID"
    end
    
    it "assigns @nested_predicate from hashed arguments" do
      objectified_type = ORM::ObjectifiedType.new(:nested_predicate => ORM::NestedPredicate.new)
      objectified_type.nested_predicate.should be_kind_of(ORM::NestedPredicate)
    end
    
    context "with no uuid argument provided" do
      it "generates a new UUID" do
        uuid = UUID.generate
        UUID.should_receive(:generate).and_return(uuid)
        
        objectified_type = ORM::ObjectifiedType.new
        objectified_type.uuid.should == uuid
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
      objectified_type = ORM::ObjectifiedType.new(
        :model => mock(ORM::Model, :uniqueness_constraints => uniqueness_constraints),
        :preferred_identifier_ref => preferred_identifier_ref
      )
      objectified_type.preferred_identifier.should == uniqueness_constraints[1]
    end
  end
end
