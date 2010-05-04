require 'spec_helper'

describe ORM::ModelNote do
  
  describe "#initialize" do
    it "assigns @uuid from hashed arguments" do
      model_note = ORM::ModelNote.new(:uuid => "SOMEUUID")
      model_note.uuid.should == "SOMEUUID"
    end
    
    it "assigns @text from hashed arguments" do
      model_note = ORM::ModelNote.new(:text => "This is a model note.")
      model_note.text.should == "This is a model note."
    end
    
    context "with no uuid argument provided" do
      it "generates a new UUID" do
        uuid = UUID.generate
        UUID.should_receive(:generate).and_return(uuid)
        
        model_note = ORM::ModelNote.new
        model_note.uuid.should == uuid
      end
    end
  end
  
end
