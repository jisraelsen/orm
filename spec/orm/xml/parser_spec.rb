require 'spec_helper'

describe ORM::XML::Parser do
  before(:each) do
    @orm_file = File.open(File.dirname(__FILE__) + "/../../fixtures/models/cities_and_cinemas.orm")
  end
  
  describe "#initialize" do
    it "reads provided file with Nokogiri and assigns to @doc" do
      parser = ORM::XML::Parser.new(@orm_file)
      parser.doc.should be_kind_of(Nokogiri::XML::Document)
    end
  end
  
  describe ".parse" do
    it "instantiates a new ORM::XML::Parser and calls #parse" do
      parser = ORM::XML::Parser.new(@orm_file)
      
      ORM::XML::Parser.should_receive(:new).and_return(parser)
      parser.should_receive(:parse)
      
      ORM::XML::Parser.parse(@orm_file)
    end
  end
  
  describe "#parse" do
    it "assigns the return value of orm_model to @model" do
      parser = ORM::XML::Parser.new(@orm_file)
      orm_model = mock(ORM::Model)
      
      parser.should_receive(:orm_model).and_return(orm_model)
      parser.parse.model.should == orm_model
    end
    
    it "returns self" do
      parser = ORM::XML::Parser.new(@orm_file)
      parser.parse.should == parser
    end
  end
  
  context "while parsing the ORM document" do
    before(:each) do
      @parser = ORM::XML::Parser.new(@orm_file)
    end
    
    describe "#entity_types" do
      before(:each) do
        @entity_types = @parser.entity_types
      end
      
      it "returns an array of ORM::EntityType objects parsed from orm:EntityType nodes" do        
        @entity_types.size.should == 5
        @entity_types.each {|o| o.should be_kind_of(ORM::EntityType) }
      end
      
      it "parses orm:EntityType[@id]" do
        @entity_types.map(&:uuid).should == [
          "E7E7DC86-1B59-420E-BF1F-DCD569418FAE", "99DF19BF-17FA-4360-90A9-43E2557D7AF1", "8CE75D62-56E6-4742-945B-DF0AA5A5AD9B", 
          "E098001B-496B-4EC9-9360-7C1516BE416A", "F255291E-B15E-48A8-A619-77AD868181BB"
        ]
      end
      
      it "parses orm:EntityType[@Name]" do
        @entity_types.map(&:name).should == ["City", "State", "Cinema", "Movie", "Date"]
      end
      
      it "parses orm:EntityType[@_ReferenceMode]" do
        @entity_types.map(&:reference_mode).should == ["", "code", "name", "nr", "ymd"]
      end
      
      it "parses orm:EntityType//orm:PreferredIdentifier[@ref]" do
        @entity_types.map(&:preferred_identifier_ref).should == [
          "A19A1D33-01CE-473B-BA5F-88B67F904EF8", "DE3ABC29-33D5-4AD0-9454-85F752B80D5D", "0F4C3E33-72A8-4AB9-987A-16217951D6BC", 
          "DD71C742-AB8A-40EB-BC01-C5A97B5DA248", "21B99692-BE07-404D-92A9-3ABCE9C47145"
        ]
      end
      
      it "parses orm:EntityType//orm:PlayedRoles/orm:Role[@ref]" do
        @entity_types.first.played_role_refs.should == [
          "56260498-C99E-4A39-B44D-192D28F84051", "B9677657-C97A-4479-8DDA-D2B83D188F2F", "B1A81F50-1766-45D2-9CF5-6CDA011366A6", 
          "5502152C-EBA3-4B26-9B11-4A480BC2EDEA", "7062D0E1-C6C5-41F3-BE84-65CFA507E2AA"
        ]
      end
    end
    
    describe "#value_types" do
      before(:each) do
        @value_types = @parser.value_types
      end
      
      it "returns an array of ORM::ValueType objects parsed from orm:ValueType nodes" do        
        @value_types.size.should == 9
        @value_types.each {|o| o.should be_kind_of(ORM::ValueType) }
      end
      
      it "parses orm:ValueType[@id]" do
        @value_types.map(&:uuid).should == [
          "D786B948-E508-49B5-85CC-DCEC104F1691", "175FC6E1-FF0D-47A6-9CA3-9A275401974D", "E1AA7376-2E8B-4E61-A46D-4FBC920C9572", 
          "B8F356E3-151B-4D95-BF85-11E0E78C89BC", "D7125E77-F5BF-468F-BC34-025958831116", "35431BC9-D17C-4839-B9E3-BCBD17E18CFF", 
          "CD7B5EBF-B4CE-4336-9C7F-2C34FDCBA345", "D3EF7B05-415A-4C9B-906C-A88E7BFA4904", "FE858076-7D02-4107-8F31-F9C392F42EE1"
        ]
      end
      
      it "parses orm:ValueType[@Name]" do
        @value_types.map(&:name).should == [
          "City is large", "City is small", "State_code", "CityName", "StateName", "Cinema_name", "NrTheaters", "Movie_nr", "ymd"
        ]
      end
      
      it "parses orm:ValueType[@IsImplicitBooleanValue]" do
        @value_types.map(&:is_implicit_boolean_value).should == [true, true, false, false, false, false, false, false, false]
      end
      
      it "parses orm:ValueType//orm:PlayedRoles/orm:Role[@ref]" do
        @value_types.first.played_role_refs.should == ["CD47DA93-BE08-4FB8-B4B0-16D55E92494D"]
      end
      
      it "parses orm:ValueType//orm:ConceptualDataType" do
        conceptual_data_type = @value_types.first.conceptual_data_type
        
        conceptual_data_type.uuid.should == "205B7C72-C99A-439C-9FE4-906D5A11A0EF"
        conceptual_data_type.data_type_ref.should == "E94AC38F-C9E4-4BE5-9A66-F839DFA66DC0"
        conceptual_data_type.scale.should == 0
        conceptual_data_type.length.should == 0
      end
      
      it "parses orm:ValueType//orm:ValueRestriction//orm:ValueConstraint" do
        value_constraint = @value_types.first.value_constraint
        
        value_constraint.uuid.should == "A82F40FE-155D-41CB-A17C-C97B1D2DBC1F"
        value_constraint.name.should == "ValueTypeValueConstraint1"
        
        value_ranges = value_constraint.value_ranges
        value_ranges.map(&:uuid).should == [
          "BEC226C7-17E9-4077-9909-A8E7888DD855", "ECDDBD80-07D6-4A4F-AE91-DFCB7B90D308", "9F411A23-7E55-42AD-91E0-F2812752F9AF"
        ]
        value_ranges.map(&:min_value).should == ["True", "True", "1"]
        value_ranges.map(&:max_value).should == ["True", "True", "20"]
        value_ranges.map(&:min_inclusion).should == ["NotSet", "NotSet", "NotSet"]
        value_ranges.map(&:max_inclusion).should == ["NotSet", "NotSet", "NotSet"]
      end
    end
    
    describe "#objectified_types" do
      before(:each) do
        @objectified_types = @parser.objectified_types
      end
      
      it "returns an array of ORM::ObjectifiedType objects parsed from orm:ObjectifiedType nodes" do        
        @objectified_types.size.should == 1
        @objectified_types.each {|o| o.should be_kind_of(ORM::ObjectifiedType) }
      end
      
      it "parses orm:ObjectifiedType[@id]" do
        @objectified_types.map(&:uuid).should == ["BD4D134B-7912-4DBE-A2C6-2B03448141C5"]
      end
      
      it "parses orm:ObjectifiedType[@Name]" do
        @objectified_types.map(&:name).should == ["CinemaFirstShowedMovieOnDate"]
      end
      
      it "parses orm:ObjectifiedType[@IsIndependent]" do
        @objectified_types.map(&:is_independent).should == [false]
      end
      
      it "parses orm:ObjectifiedType[@IsPersonal]" do
        @objectified_types.map(&:is_personal).should == [false]
      end
      
      it "parses orm:ObjectifiedType//orm:PreferredIdentifier[@ref]" do
        @objectified_types.map(&:preferred_identifier_ref).should == ["2CB354CD-3F09-4A99-8D6A-76A105A38AE0"]
      end
      
      it "parses orm:ObjectifiedType//orm:PlayedRoles/orm:Role[@ref]" do
        @objectified_types.first.played_role_refs.should == [
          "2DC4ECAC-D07A-468B-B7D2-0392422D4DB1", "812101F2-AB02-4510-897C-70EF6D7E9F26", "C76A6F28-A630-4C89-8B84-B6B6F21389E4"
        ]
      end
      
      it "parses orm:ObjectifiedType//orm:NestedPredicate" do
        nested_predicate = @objectified_types.first.nested_predicate
        
        nested_predicate.uuid.should == "115EDD6B-A781-4B59-9269-1E06B86F584E"
        nested_predicate.fact_type_ref.should == "7C096C2E-A2B2-47D6-BBC2-E7205B8C7717"
        nested_predicate.is_implied.should == true
      end
    end
    
    describe "#fact_types" do
      before(:each) do
        @fact_types = @parser.fact_types
      end
      
      it "returns an array of ORM::FactType objects parsed from orm:Fact nodes" do        
        @fact_types.size.should == 12
        @fact_types.each {|o| o.should be_kind_of(ORM::FactType) }
      end
      
      it "parses orm:Fact[@id]" do
        @fact_types.map(&:uuid).should == [
          "23B7CE8B-68E8-4900-9507-0ECF2373A67C", "9A29521B-00D4-42EE-B005-A438ADF5E78F", "2A83F41E-2FAC-4FE2-8BA4-FF869A871D03", 
          "B2416F2D-0A21-49DC-A36B-B02821E9C497", "A16426D2-6AA0-4F82-A763-618FF6BAD7F4", "E300B330-D27A-4EB5-98B3-C2985D26B538", 
          "37678232-46D6-4637-B977-B0AD4ADC06AC", "B8ABBD4F-F015-4523-8AE0-C966484947E1", "AF601010-BB84-4EC6-A87F-39DB8E133A73", 
          "8B024F29-855C-424D-B375-2844B97A353F", "99BD709B-7EC1-4306-B5DA-A4719FA4DD85", "7C096C2E-A2B2-47D6-BBC2-E7205B8C7717"
        ]
      end
      
      it "parses orm:Fact[@_Name]" do
        @fact_types.map(&:name).should == [
          "CityIsLarge", "CityIsSmall", "StateHasState_code", "CityIsInState", "CityHasCityName", "StateHasStateName", 
          "CinemaHasCinema_name", "CinemaIsInCity", "CinemaHasNrTheaters", "MovieHasMovie_nr", "DateHasymd", 
          "CinemaFirstShowedMovieOnDate"
        ]
      end
      
      it "parses orm:Fact//orm:FactRoles/orm:Roles" do
        roles = @fact_types.first.roles
        
        roles.map(&:uuid).should == ["56260498-C99E-4A39-B44D-192D28F84051", "CD47DA93-BE08-4FB8-B4B0-16D55E92494D"]
        roles.map(&:name).should == ["", ""]
        roles.map(&:is_mandatory).should == [false, false]
        roles.map(&:multiplicity).should == ["Unspecified", "Unspecified"]
        roles.map(&:role_player_ref).should == ["E7E7DC86-1B59-420E-BF1F-DCD569418FAE", "D786B948-E508-49B5-85CC-DCEC104F1691"]
      end
      
      it "parses orm:Fact//orm:ReadingOrders/orm:ReadingOrder" do
        reading_orders = @fact_types.first.reading_orders
        
        reading_orders.map(&:uuid).should == ["B5DF2590-52A7-4B60-93B2-6F1B5C58E4FA"]
        reading_orders.map(&:role_refs).should == [["56260498-C99E-4A39-B44D-192D28F84051"]]
        
        reading = reading_orders.first.reading
        reading.uuid.should == "0B6C9C5E-C1CC-4E1B-BB31-C36E38D13538"
        reading.text.should == "{0} is large"
      end
      
      it "parses orm:Fact//orm:InternalConstraints/*" do
        @fact_types.first.internal_constraint_refs.should == ["D08CEEAC-71BC-4621-9292-84824435E84A"]
      end
    end
    
    describe "#implied_fact_types" do
      before(:each) do
        @implied_fact_types = @parser.implied_fact_types
      end
      
      it "returns an array of ORM::ImpliedFactType objects parsed from orm:ImpliedFact nodes" do        
        @implied_fact_types.size.should == 3
        @implied_fact_types.each {|o| o.should be_kind_of(ORM::ImpliedFactType) }
      end
      
      it "parses orm:ImpliedFact[@id]" do
        @implied_fact_types.map(&:uuid).should == [
          "71E8BD15-509B-46B1-9AC2-2C4B80185ED7", "015B1C2F-F39C-406B-BA1B-42A433471785", "F8BC7475-3579-4CA8-8FC9-ED572C3743DA"
        ]
      end
      
      it "parses orm:ImpliedFact[@_Name]" do
        @implied_fact_types.map(&:name).should == [
          "CinemaIsInvolvedInCinemaFirstShowedMovieOnDate", "MovieIsInvolvedInCinemaFirstShowedMovieOnDate", 
          "DateIsInvolvedInCinemaFirstShowedMovieOnDate"
        ]
      end
      
      it "parses orm:ImpliedFact//orm:FactRoles/orm:RoleProxy" do
        role_proxies = @implied_fact_types.first.role_proxies
        
        role_proxies.map(&:uuid).should == ["7C3B6692-859A-47C0-BF89-E062799471F0"]
        role_proxies.map(&:role_ref).should == ["7A913FF3-1F1B-470A-83A8-4DA31CFD7BD7"]
      end
      
      it "parses orm:ImpliedFact//orm:FactRoles/orm:Role" do
        roles = @implied_fact_types.first.roles
        
        roles.map(&:uuid).should == ["2DC4ECAC-D07A-468B-B7D2-0392422D4DB1"]
        roles.map(&:name).should == [""]
        roles.map(&:is_mandatory).should == [true]
        roles.map(&:multiplicity).should == ["ZeroToMany"]
        roles.map(&:role_player_ref).should == ["BD4D134B-7912-4DBE-A2C6-2B03448141C5"]
      end
      
      it "parses orm:ImpliedFact//orm:ReadingOrders/orm:ReadingOrder" do
        reading_orders = @implied_fact_types.first.reading_orders
        
        reading_orders.map(&:uuid).should == ["1047CA32-541F-4B82-A945-3CC0BE5A8C5F", "6DD5D6BA-FC8A-4991-892F-27CA86B7DD0C"]
        reading_orders.map(&:role_refs).should == [
          ["7C3B6692-859A-47C0-BF89-E062799471F0", "2DC4ECAC-D07A-468B-B7D2-0392422D4DB1"], 
          ["2DC4ECAC-D07A-468B-B7D2-0392422D4DB1", "7C3B6692-859A-47C0-BF89-E062799471F0"]
        ]
        
        reading = reading_orders.first.reading
        reading.uuid.should == "01A1E472-86FE-4394-96D3-240D0BC3E1A7"
        reading.text.should == "{0} is involved in {1}"
      end
      
      it "parses orm:ImpliedFact//orm:InternalConstraints/*" do
        @implied_fact_types.first.internal_constraint_refs.should == [
          "397D4D0B-491A-4D7A-B3BE-E257A8B78843", "457EC797-F182-47BA-A28E-E603B46E39CD"
        ]
      end
      
      it "parses orm:ImpliedFact//orm:ImpliedByObjectification[@ref]" do
        @implied_fact_types.first.implied_by_objectification_ref.should == "115EDD6B-A781-4B59-9269-1E06B86F584E"
      end
    end
    
    describe "#uniqueness_constraints" do
      before(:each) do
        @uniqueness_constraints = @parser.uniqueness_constraints
      end
      
      it "returns an array of ORM::UniquenessConstraint objects parsed from orm:UniquenessConstraint nodes" do        
        @uniqueness_constraints.size.should == 21
        @uniqueness_constraints.each {|o| o.should be_kind_of(ORM::UniquenessConstraint) }
      end
      
      it "parses orm:UniquenessConstraint[@id]" do
        @uniqueness_constraints.map(&:uuid).should == [
          "D08CEEAC-71BC-4621-9292-84824435E84A", "94A962AB-B21E-46E4-8D6D-DFA3BF921FE7", "DE3ABC29-33D5-4AD0-9454-85F752B80D5D", 
          "90E5BFBC-513D-4BD5-8AC9-DF19B6B0BCA9", "A19A1D33-01CE-473B-BA5F-88B67F904EF8", "8D36CF8B-DC38-4C54-8DAA-2D3C973E7513", 
          "ECA7433D-9218-409B-B6DA-041EA37F3FD9", "715FDE91-6B5C-45FA-907E-486ABFC0FE79", "5E753470-07F2-4174-ACE9-2C32C3AA536D", 
          "0F4C3E33-72A8-4AB9-987A-16217951D6BC", "0FDAB6FD-CAB1-4FE3-9875-FF1E849C420D", "961FB0CD-9A85-4F3B-9712-AB6BEB95DC53", 
          "233A968C-7883-485A-A0A9-43633F903BFF", "DD71C742-AB8A-40EB-BC01-C5A97B5DA248", "EDA62AC5-0C66-4FCA-A6B5-D93F454B8FB3", 
          "21B99692-BE07-404D-92A9-3ABCE9C47145", "7C2E90D6-3BB3-48F5-9B8F-598EBBFD2171", "457EC797-F182-47BA-A28E-E603B46E39CD", 
          "5B91E2E6-B827-4E5F-9555-586A8C1F1CEC", "CABDBA93-2C78-4B90-9903-E33758E14BAB", "2CB354CD-3F09-4A99-8D6A-76A105A38AE0"
        ]
      end
      
      it "parses orm:UniquenessConstraint[@Name]" do
        @uniqueness_constraints.map(&:name).should == [
          "InternalUniquenessConstraint1", "InternalUniquenessConstraint2", "InternalUniquenessConstraint3", 
          "InternalUniquenessConstraint4", "ExternalUniquenessConstraint1", "InternalUniquenessConstraint5", 
          "InternalUniquenessConstraint6", "InternalUniquenessConstraint7", "InternalUniquenessConstraint8", 
          "InternalUniquenessConstraint9", "InternalUniquenessConstraint10", "InternalUniquenessConstraint11", 
          "InternalUniquenessConstraint12", "InternalUniquenessConstraint13", "InternalUniquenessConstraint14", 
          "InternalUniquenessConstraint15", "InternalUniquenessConstraint16", "InternalUniquenessConstraint17", 
          "InternalUniquenessConstraint18", "InternalUniquenessConstraint19", "InternalUniquenessConstraint20"
        ]
      end
      
      it "parses orm:UniquenessConstraint[@IsInternal]" do
        @uniqueness_constraints.map(&:is_internal).should == [
          true, true, true, true, false, true, true, true, true, true, true, true, true, true, true, true, 
          true, true, true, true, true
        ]
      end
      
      it "parses orm:UniquenessConstraint//orm:RoleSequence/orm:Role[@ref]" do
        @uniqueness_constraints.first.role_refs.should == ["56260498-C99E-4A39-B44D-192D28F84051"]
      end
      
      it "parses orm:UniquenessConstraint/orm:PreferredIdentifierFor[@ref]" do
        @uniqueness_constraints[2].preferred_identifier_for_ref.should == "99DF19BF-17FA-4360-90A9-43E2557D7AF1"
      end
    end
    
    describe "#mandatory_constraints" do
      before(:each) do
        @mandatory_constraints = @parser.mandatory_constraints
      end
      
      it "returns an array of ORM::MandatoryConstraint objects parsed from orm:MandatoryConstraint nodes" do        
        @mandatory_constraints.size.should == 24
        @mandatory_constraints.each {|o| o.should be_kind_of(ORM::MandatoryConstraint) }
      end
      
      it "parses orm:MandatoryConstraint[@id]" do
        @mandatory_constraints.map(&:uuid).should == [
          "3372C8DA-A4BD-450B-9D3F-D6DD599CB07C", "8A911962-6845-4E44-8DB9-958390356C97", "1780E4E0-A29F-46A4-838E-3EF96DBFB906", 
          "249D82BE-4016-4059-A371-24F068DF602B", "B5A06590-7EC5-41FA-A7A8-A16515E2AB13", "940DB345-81A4-4FA2-9B8E-2F39E4E29122", 
          "76FE66D0-895C-438C-B752-0BD741EC1A78", "4FFE5A3F-5A02-41F6-9CEA-59B56F124E32", "0ABB61AC-9412-4AC1-97E1-7FB5907D697F", 
          "450D24DC-5294-4A4F-B486-5A419EBFEC30", "64C2B2D1-3CB8-4FCF-9FBA-7C3D4168E0AA", "D436792A-CBC1-41ED-95B2-A4B00D0489EE", 
          "73E7075C-A87E-45B5-B5D2-F21EFED27BD3", "776CFF14-C1E3-49D7-853F-D7D9684BBD8F", "52003953-4DD3-48BE-A97F-13261CF3A47B", 
          "3B169E24-5357-4D57-870A-1FE163B84EB9", "236026A9-2939-4148-A2C2-B8B865CC4901", "B747432D-0FE0-4754-B053-E36250A55FC2", 
          "056AEC9E-75E3-4F09-ABD9-08399E2ADD95", "EF6A817E-CAC6-461B-A9C8-AA1C79EF4596", "397D4D0B-491A-4D7A-B3BE-E257A8B78843", 
          "3B535C48-0396-4897-B556-BE707DF3CBF7", "681823C4-A3AB-440E-91E6-EE7B0BB79F8B", "54B6DE55-DDC4-4EFF-B372-50DC96EBDD73"
        ]
      end
      
      it "parses orm:MandatoryConstraint[@Name]" do
        @mandatory_constraints.map(&:name).should == [
          "ImpliedMandatoryConstraint2", "ImpliedMandatoryConstraint3", "InclusiveOrConstraint1", "SimpleMandatoryConstraint1", 
          "ImpliedMandatoryConstraint4", "ImpliedMandatoryConstraint5", "SimpleMandatoryConstraint2", "SimpleMandatoryConstraint3", 
          "ImpliedMandatoryConstraint6", "SimpleMandatoryConstraint4", "SimpleMandatoryConstraint5", "ImpliedMandatoryConstraint7", 
          "SimpleMandatoryConstraint6", "ImpliedMandatoryConstraint1", "SimpleMandatoryConstraint7", "SimpleMandatoryConstraint8", 
          "SimpleMandatoryConstraint9", "ImpliedMandatoryConstraint8", "ImpliedMandatoryConstraint9", "ImpliedMandatoryConstraint10", 
          "SimpleMandatoryConstraint10", "SimpleMandatoryConstraint11", "SimpleMandatoryConstraint12", "ImpliedMandatoryConstraint11"
        ]
      end
      
      it "parses orm:MandatoryConstraint[@IsSimple]" do
        @mandatory_constraints.map(&:is_simple).should == [
          false, false, false, true, false, false, true, true, false, true, true, false, true, false, true, true, true, false, 
          false, false, true, true, true, false
        ]
      end
      
      it "parses orm:MandatoryConstraint[@IsImplied]" do
        @mandatory_constraints.map(&:is_implied).should == [
          true, true, false, false, true, true, false, false, true, false, false, true, false, true, false, false, false, true, 
          true, true, false, false, false, true
        ]
      end
      
      it "parses orm:MandatoryConstraint//orm:RoleSequence/orm:Role[@ref]" do
        @mandatory_constraints.first.role_refs.should == ["CD47DA93-BE08-4FB8-B4B0-16D55E92494D"]
      end
      
      it "parses orm:MandatoryConstraint/orm:ImpliedByObjectType[@ref]" do
        @mandatory_constraints.first.implied_by_object_type_ref.should == "D786B948-E508-49B5-85CC-DCEC104F1691"
      end
    end
    
    describe "#data_types" do
      before(:each) do
        @data_types = @parser.data_types
      end
      
      it "returns an array of ORM::DataType objects parsed from orm:DataTypes/* nodes" do        
        @data_types.size.should == 6
        @data_types.each {|o| o.should be_kind_of(ORM::DataType) }
      end
      
      it "parses orm:DataTypes/*[@id]" do
        @data_types.map(&:uuid).should == [
          "7A038864-A0C9-481B-B95C-F8B4E7CCFD37", "CD897BD6-6222-4739-926C-8B433B109C34", "74DC42CE-29AC-469A-8391-5983A1DA8BBA", 
          "A192818D-75C5-4CD7-B4F8-8A479FBC42C1", "33EBE9C9-AF58-4249-8C15-2F2F390E4ADC", "E94AC38F-C9E4-4BE5-9A66-F839DFA66DC0"
        ]
      end
    end
    
    describe "#model_notes" do
      before(:each) do
        @model_notes = @parser.model_notes
      end
      
      it "returns an array of ORM::ModelNote objects parsed from orm:ModelNote nodes" do        
        @model_notes.size.should == 1
        @model_notes.each {|o| o.should be_kind_of(ORM::ModelNote) }
      end
      
      it "parses orm:ModelNote[@id]" do
        @model_notes.map(&:uuid).should == ["0F36E3DA-768F-4064-858A-943E88B863D3"]
      end
      
      it "parses orm:ModelNote//orm:Text" do
        @model_notes.map(&:text).should == ["This is an example note."]
      end
    end
    
    describe "#model_errors" do
      before(:each) do
        @model_errors = @parser.model_errors
      end
      
      it "returns an array of ORM::ModelError objects parsed from orm:ModelError/* nodes" do        
        @model_errors.size.should == 3
        @model_errors.each {|o| o.should be_kind_of(ORM::DataTypeNotSpecifiedError) }
      end
      
      it "parses orm:ModelError/*[@id]" do
        @model_errors.map(&:uuid).should == [
          "1C460C05-FE6B-426D-BD99-37DB6F9B2A85", "77E7EB5B-1AC8-4ED6-9051-410361A56B5E", "3838BFD5-A5B3-49A6-A009-BC0177C21719"
        ]
      end
      
      it "parses orm:ModelError/*[@Name]" do
        @model_errors.map(&:name).should == [
          "A data type must be specified for value type 'CityName' in model 'ORMModel1'.", 
          "A data type must be specified for value type 'StateName' in model 'ORMModel1'.", 
          "A data type must be specified for value type 'ymd' in model 'ORMModel1'."
        ]
      end
      
      it "parses orm:ModelError/orm:DataTypeNotSpecifiedError//orm:ConceptualDataType[@ref]" do
        @model_errors.map(&:conceptual_data_type_ref).should == [
          "33A7DF07-32F6-4F3B-A482-302EDAE2E2E2", "0F8ECE74-C661-439A-8238-D6E14D0E14F7", "3F64A277-73E8-41B4-9438-9D06308317A4"
        ]
      end
    end
    
    describe "#reference_mode_kinds" do
      before(:each) do
        @reference_mode_kinds = @parser.reference_mode_kinds
      end
      
      it "returns an array of ORM::ReferenceModeKind objects parsed from orm:ReferenceModeKind nodes" do        
        @reference_mode_kinds.size.should == 3
        @reference_mode_kinds.each {|o| o.should be_kind_of(ORM::ReferenceModeKind) }
      end
      
      it "parses orm:ReferenceModeKind[@id]" do
        @reference_mode_kinds.map(&:uuid).should == [
          "38BF8DF6-6AA1-453A-BD9C-250E87B04D6B", "9988D95F-FFD5-4C22-88C6-E44FBC2248F1", "53065F29-C414-40AB-962F-7748FCD68D4C"
        ]
      end
      
      it "parses orm:ReferenceModeKind[@FormatString]" do
        @reference_mode_kinds.map(&:format_string).should == ["{1}", "{0}_{1}", "{1}Value"]
      end
      
      it "parses orm:ReferenceModeKind[@ReferenceModeType]" do
        @reference_mode_kinds.map(&:reference_mode_type).should == ["General", "Popular", "UnitBased"]
      end
    end
    
    describe "#orm_model" do
      before(:each) do
        @orm_model = @parser.orm_model
      end
      
      it "returns an ORM::Model object parsed from the orm:Model node" do        
        @orm_model.should be_kind_of(ORM::Model)
      end
      
      it "parses orm:Model[@id]" do
        @orm_model.uuid.should == "D0BE5C03-E27A-4394-87B1-FA54CBFFE8EB"
      end
      
      it "parses orm:Model[@Name]" do
        @orm_model.name.should == "ORMModel1"
      end
      
      it "parses orm:Objects" do
        @orm_model.object_types.size.should == 15
      end
      
      it "parses orm:Facts" do
        @orm_model.fact_types.size.should == 15
      end
      
      it "parses orm:Constraints" do
        @orm_model.constraints.size.should == 45
      end
      
      it "parses orm:DataTypes" do
        @orm_model.data_types.size.should == 6
      end
      
      it "parses orm:ModelNotes" do
        @orm_model.model_notes.size.should == 1
      end
      
      it "parses orm:ModelErrors" do
        @orm_model.model_errors.size.should == 3
      end
      
      it "parses orm:ReferenceModeKinds" do
        @orm_model.model_errors.size.should == 3
      end
    end
  end
end
