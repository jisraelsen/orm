require 'spec_helper'

describe ORM::EntityType do
  
  describe "#initialize" do
    it "assigns @uuid from hashed arguments" do
      entity_type = ORM::EntityType.new(:uuid => "SOMEUUID")
      entity_type.uuid.should == "SOMEUUID"
    end
    
    it "assigns @name from hashed arguments" do
      entity_type = ORM::EntityType.new(:name => "EntityType1337")
      entity_type.name.should == "EntityType1337"
    end
    
    it "assigns @reference_mode from hashed arguments" do
      entity_type = ORM::EntityType.new(:reference_mode => "id")
      entity_type.reference_mode.should == "id"
    end
    
    context "with no uuid argument provided" do
      it "generates a new UUID" do
        uuid = UUID.generate
        UUID.should_receive(:generate).and_return(uuid)
        
        entity_type = ORM::EntityType.new
        entity_type.uuid.should == uuid
      end
    end
  end
  
end
