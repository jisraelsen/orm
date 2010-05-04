require 'spec_helper'

describe ORM::ModelError do
  
  describe "#initialize" do
    it "assigns @uuid from hashed arguments" do
      model_error = ORM::ModelError.new(:uuid => "SOMEUUID")
      model_error.uuid.should == "SOMEUUID"
    end
    
    it "assigns @name from hashed arguments" do
      model_error = ORM::ModelError.new(:name => "This is a model error name.")
      model_error.name.should == "This is a model error name."
    end
    
    context "with no uuid argument provided" do
      it "generates a new UUID" do
        uuid = UUID.generate
        UUID.should_receive(:generate).and_return(uuid)
        
        model_error = ORM::ModelError.new
        model_error.uuid.should == uuid
      end
    end
  end
  
end

describe ORM::DataTypeNotSpecifiedError do
  
  describe "#initialize" do
    it "assigns @uuid from hashed arguments" do
      model_error = ORM::DataTypeNotSpecifiedError.new(:uuid => "SOMEUUID")
      model_error.uuid.should == "SOMEUUID"
    end
    
    it "assigns @name from hashed arguments" do
      model_error = ORM::DataTypeNotSpecifiedError.new(:name => "This is a model error name.")
      model_error.name.should == "This is a model error name."
    end
    
    it "assigns @conceptual_data_type_ref from hashed arguments" do
      model_error = ORM::DataTypeNotSpecifiedError.new(:conceptual_data_type_ref => "SOMEUUID")
      model_error.conceptual_data_type_ref.should == "SOMEUUID"
    end
    
    context "with no uuid argument provided" do
      it "generates a new UUID" do
        uuid = UUID.generate
        UUID.should_receive(:generate).and_return(uuid)
        
        model_error = ORM::DataTypeNotSpecifiedError.new
        model_error.uuid.should == uuid
      end
    end
  end
  
end
