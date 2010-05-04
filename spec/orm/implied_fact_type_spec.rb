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
