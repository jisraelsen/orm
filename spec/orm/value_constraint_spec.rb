require 'spec_helper'

describe ORM::ValueConstraint do
  describe "#initialize" do
    it "assigns @uuid from hashed arguments" do
      value_constraint = ORM::ValueConstraint.new(:uuid => "SOMEUUID")
      value_constraint.uuid.should == "SOMEUUID"
    end
    
    it "assigns @name from hashed arguments" do
      value_constraint = ORM::ValueConstraint.new(:name => "ValueConstraint1337")
      value_constraint.name.should == "ValueConstraint1337"
    end
    
    it "assigns @value_ranges from hashed arguments" do
      value_constraint = ORM::ValueConstraint.new(:value_ranges => [ORM::ValueRange.new])
      value_constraint.value_ranges.first.should be_kind_of(ORM::ValueRange)
    end
    
    context "with no uuid argument provided" do
      it "generates a new UUID" do
        uuid = UUID.generate
        UUID.should_receive(:generate).and_return(uuid)
        
        value_constraint = ORM::ValueConstraint.new
        value_constraint.uuid.should == uuid
      end
    end
  end
end
