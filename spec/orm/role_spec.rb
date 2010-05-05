require 'spec_helper'

describe ORM::Role do
  
  describe "#initialize" do
    it "assigns @uuid from hashed arguments" do
      role = ORM::Role.new(:uuid => "SOMEUUID")
      role.uuid.should == "SOMEUUID"
    end
    
    it "assigns @name from hashed arguments" do
      role = ORM::Role.new(:name => "Role1337")
      role.name.should == "Role1337"
    end
    
    it "assigns @is_mandatory from hashed arguments" do
      role = ORM::Role.new(:is_mandatory => "true")
      role.is_mandatory.should == true
      
      role = ORM::Role.new(:is_mandatory => "false")
      role.is_mandatory.should == false
    end
    
    it "assigns @multiplicity from hashed arguments" do
      role = ORM::Role.new(:multiplicity => "ZeroToMany")
      role.multiplicity.should == "ZeroToMany"
    end
    
    it "assigns @role_player_ref from hashed arguments" do
      role = ORM::Role.new(:role_player_ref => "SOMEUUID")
      role.role_player_ref.should == "SOMEUUID"
    end
    
    context "with no uuid argument provided" do
      it "generates a new UUID" do
        uuid = UUID.generate
        UUID.should_receive(:generate).and_return(uuid)
        
        role = ORM::Role.new
        role.uuid.should == uuid
      end
    end
  end
  
  describe "#role_player" do
    it "returns the ORM::ObjectType with @uuid = @role_player_ref" do
      role_player_ref = UUID.generate
      object_types = [
        ORM::EntityType.new, ORM::ValueType.new(:uuid => role_player_ref)
      ]
      role = ORM::Role.new(
        :fact_type => mock(ORM::FactType, :model => mock(ORM::Model, :object_types => object_types)),
        :role_player_ref => role_player_ref
      )
      role.role_player.should == object_types[1]
    end
  end
end
