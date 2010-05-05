require 'spec_helper'

describe ORM::ConceptualDataType do
  
  describe "#initialize" do
    it "assigns @uuid from hashed arguments" do
      conceptual_data_type = ORM::ConceptualDataType.new(:uuid => "SOMEUUID")
      conceptual_data_type.uuid.should == "SOMEUUID"
    end
    
    it "assigns @data_type_ref from hashed arguments" do
      conceptual_data_type = ORM::ConceptualDataType.new(:data_type_ref => "SOMEUUID")
      conceptual_data_type.data_type_ref.should == "SOMEUUID"
    end
    
    it "assigns @scale from hashed arguments" do
      conceptual_data_type = ORM::ConceptualDataType.new(:scale => "1")
      conceptual_data_type.scale.should == 1
    end
    
    it "assigns @length from hashed arguments" do
      conceptual_data_type = ORM::ConceptualDataType.new(:length => "4")
      conceptual_data_type.length.should == 4
    end
    
    context "with no uuid argument provided" do
      it "generates a new UUID" do
        uuid = UUID.generate
        UUID.should_receive(:generate).and_return(uuid)
        
        conceptual_data_type = ORM::ConceptualDataType.new
        conceptual_data_type.uuid.should == uuid
      end
    end
  end
  
  describe "#data_type" do
    it "returns the ORM::DataType with @uuid = @data_type_ref" do
      data_type_ref = UUID.generate
      data_types = [ORM::UnspecifiedDataType.new, ORM::FixedLengthTextDataType.new(:uuid => data_type_ref)]
      conceptual_data_type = ORM::ConceptualDataType.new(
        :value_type => mock(ORM::ValueType, :model => mock(ORM::Model, :data_types => data_types)),
        :data_type_ref => data_type_ref
      )
      conceptual_data_type.data_type.should == data_types[1]
    end
  end
  
end
