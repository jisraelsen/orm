require 'spec_helper'

describe ORM::ObjectifiedType do
  
  describe "#initialize" do
    it "assigns @uuid from hashed arguments" do
      objectified_type = ORM::ObjectifiedType.new(:uuid => "SOMEUUID")
      objectified_type.uuid.should == "SOMEUUID"
    end
    
    it "assigns @name from hashed arguments" do
      objectified_type = ORM::ObjectifiedType.new(:name => "ObjectifiedType1337")
      objectified_type.name.should == "ObjectifiedType1337"
    end
    
    it "assigns @is_independent from hashed arguments" do
      objectified_type = ORM::ObjectifiedType.new(:is_independent => "true")
      objectified_type.is_independent.should == true
      
      objectified_type = ORM::ObjectifiedType.new(:is_independent => "false")
      objectified_type.is_independent.should == false
    end
    
    it "assigns @is_personal from hashed arguments" do
      objectified_type = ORM::ObjectifiedType.new(:is_personal => "true")
      objectified_type.is_personal.should == true
      
      objectified_type = ORM::ObjectifiedType.new(:is_personal => "false")
      objectified_type.is_personal.should == false
    end
    
    context "with no uuid argument provided" do
      it "generates a new UUID" do
        uuid = UUID.generate
        UUID.should_receive(:generate).and_return(uuid)
        
        objectified_type = ORM::ObjectifiedType.new
        objectified_type.uuid.should == uuid
      end
    end
  end
  
end
