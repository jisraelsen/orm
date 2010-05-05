require 'spec_helper'

describe ORM::NestedPredicate do
  
  describe "#initialize" do
    it "assigns @uuid from hashed arguments" do
      nested_predicate = ORM::NestedPredicate.new(:uuid => "SOMEUUID")
      nested_predicate.uuid.should == "SOMEUUID"
    end
    
    it "assigns @fact_type_ref from hashed arguments" do
      nested_predicate = ORM::NestedPredicate.new(:fact_type_ref => "SOMEUUID")
      nested_predicate.fact_type_ref.should == "SOMEUUID"
    end
    
    it "assigns @is_implied from hashed arguments" do
      objectified_type = ORM::NestedPredicate.new(:is_implied => "true")
      objectified_type.is_implied.should == true
      
      objectified_type = ORM::NestedPredicate.new(:is_implied => "false")
      objectified_type.is_implied.should == false
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
  
end
