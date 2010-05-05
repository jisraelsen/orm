require 'spec_helper'

describe ORM::Model do
  
  describe "#initialize" do
    it "assigns @uuid from hashed arguments" do
      model = ORM::Model.new(:uuid => "SOMEUUID")
      model.uuid.should == "SOMEUUID"
    end
    
    it "assigns @name from hashed arguments" do
      model = ORM::Model.new(:name => "Model1337")
      model.name.should == "Model1337"
    end
    
    it "assigns @object_types from hashed arguments" do
      model = ORM::Model.new(
        :object_types => [
          ORM::EntityType.new(:name => "EntityType1337"), 
          ORM::ValueType.new(:name => "ValueType1337")
        ]
      )
      model.object_types.first.name.should == "EntityType1337"
      model.object_types.last.name.should == "ValueType1337"
    end
    
    it "assigns @fact_types from hashed arguments" do
      model = ORM::Model.new(
        :fact_types => [
          ORM::FactType.new(:name => "SchoolHasCampus")
        ]
      )
      model.fact_types.first.name.should == "SchoolHasCampus"
    end
    
    it "assigns @constraints from hashed arguments" do
      model = ORM::Model.new(
        :constraints => [
          ORM::UniquenessConstraint.new(:name => "InternalUniquenessConstraint1337"),
          ORM::MandatoryConstraint.new(:name => "SimpleMandatoryConstraint1337")
        ]
      )
      model.constraints.first.name.should == "InternalUniquenessConstraint1337"
      model.constraints.last.name.should == "SimpleMandatoryConstraint1337"
    end
    
    it "assigns @data_types from hashed arguments" do
      model = ORM::Model.new(
        :data_types => [
          ORM::AutoCounterNumericDataType.new,
          ORM::FixedLengthTextDataType.new
        ]
      )
      model.data_types.first.should be_kind_of(ORM::AutoCounterNumericDataType)
      model.data_types.last.should be_kind_of(ORM::FixedLengthTextDataType)
    end
    
    it "assigns @model_notes from hashed arguments" do
      model = ORM::Model.new(
        :model_notes => [
          ORM::ModelNote.new(:text => "This is a model note.")
        ]
      )
      model.model_notes.first.text.should == "This is a model note."
    end
    
    it "assigns @model_errors from hashed arguments" do
      model = ORM::Model.new(
        :model_errors => [
          ORM::DataTypeNotSpecifiedError.new(:name => "This is a model error.")
        ]
      )
      model.model_errors.first.name.should == "This is a model error."
    end
    
    it "assigns @reference_mode_kinds from hashed arguments" do
      model = ORM::Model.new(
        :reference_mode_kinds => [
          ORM::ReferenceModeKind.new(:reference_mode_type => "General"),
          ORM::ReferenceModeKind.new(:reference_mode_type => "Popular"),
          ORM::ReferenceModeKind.new(:reference_mode_type => "UnitBased")
        ]
      )
      model.reference_mode_kinds.first.reference_mode_type.should == "General"
      model.reference_mode_kinds[1].reference_mode_type.should == "Popular"
      model.reference_mode_kinds.last.reference_mode_type.should == "UnitBased"
    end
    
    context "with no uuid argument provided" do
      it "generates a new UUID" do
        uuid = UUID.generate
        UUID.should_receive(:generate).and_return(uuid)
        
        model = ORM::Model.new
        model.uuid.should == uuid
      end
    end
  end
  
  describe "#objectified_types" do
    it "returns object_types of class ORM::ObjectifiedType" do
      model = ORM::Model.new(
        :object_types => [
          ORM::EntityType.new,
          ORM::ValueType.new,
          ORM::ObjectifiedType.new,
          ORM::ObjectifiedType.new
        ]
      )
      model.objectified_types.each{|o| o.should be_kind_of(ORM::ObjectifiedType)}
    end
  end
  
  describe "#uniqueness_constraints" do
    it "returns constraints of class ORM::UniquenessConstraint" do
      model = ORM::Model.new(
        :constraints => [
          ORM::MandatoryConstraint.new,
          ORM::UniquenessConstraint.new,
          ORM::UniquenessConstraint.new
        ]
      )
      model.uniqueness_constraints.each{|o| o.should be_kind_of(ORM::UniquenessConstraint)}
    end
  end
  
end
