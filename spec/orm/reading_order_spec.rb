require 'spec_helper'

describe ORM::ReadingOrder do
  
  describe "#initialize" do
    it "assigns @uuid from hashed arguments" do
      reading_order = ORM::ReadingOrder.new(:uuid => "SOMEUUID")
      reading_order.uuid.should == "SOMEUUID"
    end
    
    it "assigns @reading from hashed arguments" do
      reading_order = ORM::ReadingOrder.new(:reading => ORM::Reading.new)
      reading_order.reading.should be_kind_of(ORM::Reading)
    end
    
    it "assigns @role_refs from hashed arguments" do
      reading_order = ORM::ReadingOrder.new(:role_refs => ["SOMEUUID"])
      reading_order.role_refs.should == ["SOMEUUID"]
    end
    
    context "with no uuid argument provided" do
      it "generates a new UUID" do
        uuid = UUID.generate
        UUID.should_receive(:generate).and_return(uuid)
        
        reading_order = ORM::ReadingOrder.new
        reading_order.uuid.should == uuid
      end
    end
  end
  
end
