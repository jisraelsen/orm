require 'spec_helper'

describe ORM::ImpliedFactType do
  
  describe "#initialize" do
    it "assigns @uuid from hashed arguments" do
      implied_fact_type = ORM::ImpliedFactType.new(:uuid => "SOMEUUID")
      implied_fact_type.uuid.should == "SOMEUUID"
    end
    
    it "assigns @name from hashed arguments" do
      implied_fact_type = ORM::ImpliedFactType.new(:name => "SchoolHasCampus")
      implied_fact_type.name.should == "SchoolHasCampus"
    end
    
    it "assigns @roles from hashed arguments" do
      implied_fact_type = ORM::ImpliedFactType.new(:roles => [ORM::Role.new])
      implied_fact_type.roles.first.should be_kind_of(ORM::Role)
    end
    
    it "assigns @reading_orders from hashed arguments" do
      implied_fact_type = ORM::ImpliedFactType.new(:reading_orders => [ORM::ReadingOrder.new])
      implied_fact_type.reading_orders.first.should be_kind_of(ORM::ReadingOrder)
    end
    
    it "assigns @internal_constraint_refs from hashed arguments" do
      implied_fact_type = ORM::ImpliedFactType.new(:internal_constraint_refs => ["SOMEUUID"])
      implied_fact_type.internal_constraint_refs.should == ["SOMEUUID"]
    end
    
    it "assigns @implied_by_objectification_ref from hashed arguments" do
      implied_fact_type = ORM::ImpliedFactType.new(:implied_by_objectification_ref => "SOMEUUID")
      implied_fact_type.implied_by_objectification_ref.should == "SOMEUUID"
    end
    
    context "with no uuid argument provided" do
      it "generates a new UUID" do
        uuid = UUID.generate
        UUID.should_receive(:generate).and_return(uuid)
        
        implied_fact_type = ORM::ImpliedFactType.new
        implied_fact_type.uuid.should == uuid
      end
    end
  end
  
end
