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
