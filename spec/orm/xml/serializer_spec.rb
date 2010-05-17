require 'spec_helper'

describe ORM::XML::Serializer do
  before(:each) do
    @model = ORM::XML::Parser.parse(File.open(File.dirname(__FILE__) + "/../../fixtures/models/cities_and_cinemas.orm")).model
  end
  
  describe "#initialize" do
    it "assigns passed in model to @model" do
      serializer = ORM::XML::Serializer.new(@model)
      serializer.model.should == @model
    end
  end
  
  describe ".serialize" do
    it "instantiates a new ORM::XML::Serializer and calls #serialize" do
      serializer = ORM::XML::Serializer.new(@model)
      
      ORM::XML::Serializer.should_receive(:new).and_return(serializer)
      serializer.should_receive(:serialize)
      
      ORM::XML::Serializer.serialize(@model)
    end
  end
  
  describe "#serialize" do
    it "assigns the return value of orm_xml to @xml" do
      serializer = ORM::XML::Serializer.new(@model)
      orm_xml = "SOME XML"
      
      serializer.should_receive(:orm_xml).and_return(orm_xml)
      serializer.serialize.xml.should == orm_xml
    end
    
    it "returns self" do
      serializer = ORM::XML::Serializer.new(@model)
      serializer.serialize.should == serializer
    end
  end
end
