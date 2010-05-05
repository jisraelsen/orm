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
      nested_predicate = ORM::NestedPredicate.new(:is_implied => "true")
      nested_predicate.is_implied.should == true
      
      nested_predicate = ORM::NestedPredicate.new(:is_implied => "false")
      nested_predicate.is_implied.should == false
    end
        
    context "with no uuid argument provided" do
      it "generates a new UUID" do
        uuid = UUID.generate
        UUID.should_receive(:generate).and_return(uuid)
        
        nested_predicate = ORM::NestedPredicate.new
        nested_predicate.uuid.should == uuid
      end
    end
  end
  
  describe "#fact_type" do
    it "returns the ORM::FactType with @uuid = @fact_type_ref" do
      fact_type_ref = UUID.generate
      fact_types = [
        ORM::FactType.new, 
        ORM::FactType.new(:uuid => fact_type_ref)
      ]
      nested_predicate = ORM::NestedPredicate.new(
        :objectified_type => mock(ORM::ObjectifiedType, :model => mock(ORM::Model, :fact_types => fact_types)),
        :fact_type_ref => fact_type_ref
      )
      nested_predicate.fact_type.should == fact_types[1]
    end
  end
end
