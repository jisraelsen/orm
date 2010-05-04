module ORM
  class DataType
    attr_reader :uuid
    
    def initialize(options={})
      @uuid = options[:uuid] || UUID.generate
    end
  end
  
  class UnspecifiedDataType < DataType; end;
  class FixedLengthTextDataType < DataType; end;
  class VariableLengthTextDataType < DataType; end;
  class SignedIntegerNumericDataType < DataType; end;
  class UnsignedIntegerNumericDataType < DataType; end;
  class TrueOrFalseLogicalDataType < DataType; end;
  class DateTemporalDataType < DataType; end;
  class AutoCounterNumericDataType < DataType; end;
end
