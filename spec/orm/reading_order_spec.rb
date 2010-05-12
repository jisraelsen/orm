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
  
  describe "#roles" do
    it "returns the ORM::Role with @uuid in @role_refs" do
      role_refs = [UUID.generate, UUID.generate]
      roles = [
        ORM::Role.new,
        ORM::Role.new(:uuid => role_refs[0]), 
        ORM::Role.new(:uuid => role_refs[1]), 
        ORM::Role.new
      ]
      reading_order = ORM::ReadingOrder.new(
        :fact_type => mock(ORM::FactType, :roles => roles),
        :role_refs => role_refs
      )
      reading_order.roles[0].should == roles[1]
      reading_order.roles[1].should == roles[2]
    end
  end
  
  describe "#role_proxies" do
    it "returns the ORM::RoleProxy with @uuid in @role_refs" do
      role_refs = [UUID.generate, UUID.generate]
      role_proxies = [
        ORM::RoleProxy.new,
        ORM::RoleProxy.new(:uuid => role_refs[0]), 
        ORM::RoleProxy.new(:uuid => role_refs[1]), 
        ORM::RoleProxy.new
      ]
      reading_order = ORM::ReadingOrder.new(
        :fact_type => mock(ORM::ImpliedFactType, :role_proxies => role_proxies),
        :role_refs => role_refs
      )
      reading_order.role_proxies[0].should == role_proxies[1]
      reading_order.role_proxies[1].should == role_proxies[2]
    end
  end
  
  describe "#all_roles" do
    it "returns an array of ORM::Role objects from the #roles and #role_proxies methods" do
      role_refs = [UUID.generate, UUID.generate]
      role_proxies = [ORM::RoleProxy.new(:uuid => role_refs[0])]
      role_proxies[0].stub!(:role => mock(ORM::Role))
      roles = [ORM::Role.new(:uuid => role_refs[1])]
      
      reading_order = ORM::ReadingOrder.new(:role_refs => role_refs)
      reading_order.stub!(:roles).and_return(roles)
      reading_order.stub!(:role_proxies).and_return(role_proxies)
      
      reading_order.all_roles.should == role_proxies.map(&:role)+roles
    end
  end
  
  describe "#verbalization" do
    it "returns a string with placeholder values like {0} or {1} replaced with the corresponding role_player (ObjectType) name" do
      reading_order = ORM::ReadingOrder.new(:reading => ORM::Reading.new)
      reading_order.stub!(:all_roles).and_return([
        mock(ORM::Role, :role_player => ORM::EntityType.new(:name => "Foo")),
        mock(ORM::Role, :role_player => ORM::EntityType.new(:name => "Bar")),
        mock(ORM::Role, :role_player => ORM::EntityType.new(:name => "Baz"))
      ])
      
      reading_order.reading.text = "{0}"
      reading_order.verbalization.should == "Foo"
      
      reading_order.reading.text = "{0} has {1}"
      reading_order.verbalization.should == "Foo has Bar"
      
      reading_order.reading.text = "{0} likes {1} with {2}"
      reading_order.verbalization.should == "Foo likes Bar with Baz"      
    end
  end
end
