require 'spec_helper'

describe ORM::ValueRange do
  describe "#initialize" do
    it "assigns @uuid from hashed arguments" do
      value_range = ORM::ValueRange.new(:uuid => "SOMEUUID")
      value_range.uuid.should == "SOMEUUID"
    end
    
    it "assigns @min_value from hashed arguments" do
      value_range = ORM::ValueRange.new(:min_value => "1")
      value_range.min_value.should == "1"
    end
    
    it "assigns @max_value from hashed arguments" do
      value_range = ORM::ValueRange.new(:max_value => "100")
      value_range.max_value.should == "100"
    end
    
    it "assigns @min_inclusion from hashed arguments" do
      value_range = ORM::ValueRange.new(:min_inclusion => "NotSet")
      value_range.min_inclusion.should == "NotSet"
    end
    
    it "assigns @max_inclusion from hashed arguments" do
      value_range = ORM::ValueRange.new(:max_inclusion => "NotSet")
      value_range.max_inclusion.should == "NotSet"
    end
    
    context "with no uuid argument provided" do
      it "generates a new UUID" do
        uuid = UUID.generate
        UUID.should_receive(:generate).and_return(uuid)
        
        value_range = ORM::ValueRange.new
        value_range.uuid.should == uuid
      end
    end
  end
end
