require 'spec_helper'

describe ORM::ImpliedFactType do
  
  describe "#initialize" do
    it "assigns @implied_by_objectification_ref from hashed arguments" do
      implied_fact_type = ORM::ImpliedFactType.new(:implied_by_objectification_ref => "SOMEUUID")
      implied_fact_type.implied_by_objectification_ref.should == "SOMEUUID"
    end
  end
  
  describe "#implied_by_objectification" do
    it "returns the ORM::UniquenessConstraint with @uuid = @implied_by_objectification_ref" do
      implied_by_objectification_ref = UUID.generate
      objectified_types = [
        ORM::ObjectifiedType.new(:nested_predicate => ORM::NestedPredicate.new(:uuid => implied_by_objectification_ref)), 
        ORM::ObjectifiedType.new(:nested_predicate => ORM::NestedPredicate.new)
      ]
      implied_fact_type = ORM::ImpliedFactType.new(
        :model => mock(ORM::Model, :objectified_types => objectified_types),
        :implied_by_objectification_ref => implied_by_objectification_ref
      )
      implied_fact_type.implied_by_objectification.should == objectified_types[0].nested_predicate
    end
  end
  
end
