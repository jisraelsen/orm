require 'spec_helper'

describe ORM::DataType do
  
  describe "#initialize" do
    it "assigns @uuid from hashed arguments" do
      data_type = ORM::DataType.new(:uuid => "SOMEUUID")
      data_type.uuid.should == "SOMEUUID"
    end
    
    context "with no uuid argument provided" do
      it "generates a new UUID" do
        uuid = UUID.generate
        UUID.should_receive(:generate).and_return(uuid)
        
        data_type = ORM::DataType.new
        data_type.uuid.should == uuid
      end
    end
  end
  
end
