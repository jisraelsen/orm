require 'spec_helper'

describe ORM::ReferenceModeKind do
  
  describe "#initialize" do
    it "assigns @uuid from hashed arguments" do
      reference_mode_kind = ORM::ReferenceModeKind.new(:uuid => "SOMEUUID")
      reference_mode_kind.uuid.should == "SOMEUUID"
    end
    
    it "assigns @format_string from hashed arguments" do
      reference_mode_kind = ORM::ReferenceModeKind.new(:format_string => "{0}_{1}")
      reference_mode_kind.format_string.should == "{0}_{1}"
    end
    
    it "assigns @reference_mode_type from hashed arguments" do
      reference_mode_kind = ORM::ReferenceModeKind.new(:reference_mode_type => "Popular")
      reference_mode_kind.reference_mode_type.should == "Popular"
    end
    
    context "with no uuid argument provided" do
      it "generates a new UUID" do
        uuid = UUID.generate
        UUID.should_receive(:generate).and_return(uuid)
        
        reference_mode_kind = ORM::ReferenceModeKind.new
        reference_mode_kind.uuid.should == uuid
      end
    end
  end
  
end
