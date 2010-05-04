require 'spec_helper'

describe ORM::Constraint do
  
  describe "#initialize" do
    it "assigns @uuid from hashed arguments" do
      constraint = ORM::Constraint.new(:uuid => "SOMEUUID")
      constraint.uuid.should == "SOMEUUID"
    end
    
    it "assigns @name from hashed arguments" do
      constraint = ORM::Constraint.new(:name => "Constraint1337")
      constraint.name.should == "Constraint1337"
    end
    
    context "with no uuid argument provided" do
      it "generates a new UUID" do
        uuid = UUID.generate
        UUID.should_receive(:generate).and_return(uuid)
        
        constraint = ORM::Constraint.new
        constraint.uuid.should == uuid
      end
    end
  end
  
end
