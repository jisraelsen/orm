require 'spec_helper'

describe ORM::FactType do
  
  describe "#initialize" do
    it "assigns @uuid from hashed arguments" do
      fact_type = ORM::FactType.new(:uuid => "SOMEUUID")
      fact_type.uuid.should == "SOMEUUID"
    end
    
    it "assigns @name from hashed arguments" do
      fact_type = ORM::FactType.new(:name => "SchoolHasCampus")
      fact_type.name.should == "SchoolHasCampus"
    end
    
    it "assigns @roles from hashed arguments" do
      fact_type = ORM::FactType.new(:roles => [ORM::Role.new])
      fact_type.roles.first.should be_kind_of(ORM::Role)
    end
    
    it "assigns @reading_orders from hashed arguments" do
      fact_type = ORM::FactType.new(:reading_orders => [ORM::ReadingOrder.new])
      fact_type.reading_orders.first.should be_kind_of(ORM::ReadingOrder)
    end
    
    it "assigns @internal_constraint_refs from hashed arguments" do
      fact_type = ORM::FactType.new(:internal_constraint_refs => ["SOMEUUID"])
      fact_type.internal_constraint_refs.should == ["SOMEUUID"]
    end
    
    context "with no uuid argument provided" do
      it "generates a new UUID" do
        uuid = UUID.generate
        UUID.should_receive(:generate).and_return(uuid)
        
        fact_type = ORM::FactType.new
        fact_type.uuid.should == uuid
      end
    end
  end
  
end
