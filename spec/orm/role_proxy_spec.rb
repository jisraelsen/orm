require 'spec_helper'

describe ORM::RoleProxy do
  
  describe "#initialize" do
    it "assigns @uuid from hashed arguments" do
      role_proxy = ORM::RoleProxy.new(:uuid => "SOMEUUID")
      role_proxy.uuid.should == "SOMEUUID"
    end
    
    it "assigns @role_ref from hashed arguments" do
      role_proxy = ORM::RoleProxy.new(:role_ref => "SOMEUUID")
      role_proxy.role_ref.should == "SOMEUUID"
    end
    
    context "with no uuid argument provided" do
      it "generates a new UUID" do
        uuid = UUID.generate
        UUID.should_receive(:generate).and_return(uuid)
        
        role_proxy = ORM::RoleProxy.new
        role_proxy.uuid.should == uuid
      end
    end
  end
  
  describe "#role" do
    it "returns the ORM::Role with @uuid = @role_ref" do
      role_ref = UUID.generate
      roles = [
        ORM::Role.new, ORM::Role.new(:uuid => role_ref)
      ]
      role_proxy = ORM::RoleProxy.new(
        :fact_type => mock(ORM::FactType, :model => mock(ORM::Model, :fact_types => [mock(ORM::FactType, :roles => roles)])),
        :role_ref => role_ref
      )
      role_proxy.role.should == roles[1]
    end
  end
end
