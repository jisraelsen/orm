require 'spec_helper'

describe ORM::ValueType do
  
  describe "#initialize" do
    it "assigns @uuid from hashed arguments" do
      value_type = ORM::ValueType.new(:uuid => "SOMEUUID")
      value_type.uuid.should == "SOMEUUID"
    end
    
    it "assigns @name from hashed arguments" do
      value_type = ORM::ValueType.new(:name => "ValueType1337")
      value_type.name.should == "ValueType1337"
    end
    
    it "assigns @is_implicit_boolean_value from hashed arguments" do
      value_type = ORM::ValueType.new(:is_implicit_boolean_value => "true")
      value_type.is_implicit_boolean_value.should == true
      
      value_type = ORM::ValueType.new(:is_implicit_boolean_value => "false")
      value_type.is_implicit_boolean_value.should == false
    end
    
    it "assigns @played_role_refs from hashed arguments" do
      value_type = ORM::ValueType.new(:played_role_refs => ["SOMEUUID"])
      value_type.played_role_refs.should == ["SOMEUUID"]
    end
    
    it "assigns @conceptual_data_type from hashed arguments" do
      value_type = ORM::ValueType.new(:conceptual_data_type => ORM::ConceptualDataType.new)
      value_type.conceptual_data_type.should be_kind_of(ORM::ConceptualDataType)
    end
    
    it "assigns @value_constraint from hashed arguments" do
      value_type = ORM::ValueType.new(:value_constraint => ORM::ValueConstraint.new)
      value_type.value_constraint.should be_kind_of(ORM::ValueConstraint)
    end
    
    context "with no uuid argument provided" do
      it "generates a new UUID" do
        uuid = UUID.generate
        UUID.should_receive(:generate).and_return(uuid)
        
        value_type = ORM::ValueType.new
        value_type.uuid.should == uuid
      end
    end
  end
  
end
