require 'spec_helper'

describe ORM::ObjectType do
  
  describe "#initialize" do
    it "assigns @uuid from hashed arguments" do
      object_type = ORM::ObjectType.new(:uuid => "SOMEUUID")
      object_type.uuid.should == "SOMEUUID"
    end
    
    it "assigns @name from hashed arguments" do
      object_type = ORM::ObjectType.new(:name => "ObjectType1337")
      object_type.name.should == "ObjectType1337"
    end
    
    context "with no uuid argument provided" do
      it "generates a new UUID" do
        uuid = UUID.generate
        UUID.should_receive(:generate).and_return(uuid)
        
        object_type = ORM::ObjectType.new
        object_type.uuid.should == uuid
      end
    end
  end
  
end
