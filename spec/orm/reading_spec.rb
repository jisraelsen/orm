require 'spec_helper'

describe ORM::Reading do
  
  describe "#initialize" do
    it "assigns @uuid from hashed arguments" do
      reading = ORM::Reading.new(:uuid => "SOMEUUID")
      reading.uuid.should == "SOMEUUID"
    end
    
    it "assigns @reading from hashed arguments" do
      reading = ORM::Reading.new(:text => "{0} has {1}")
      reading.text.should == "{0} has {1}"
    end
      
    context "with no uuid argument provided" do
      it "generates a new UUID" do
        uuid = UUID.generate
        UUID.should_receive(:generate).and_return(uuid)
        
        reading = ORM::Reading.new
        reading.uuid.should == uuid
      end
    end
  end
  
end
