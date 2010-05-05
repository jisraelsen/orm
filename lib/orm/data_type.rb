module ORM
  class DataType
    attr_reader   :uuid
    attr_accessor :model
    
    def initialize(options={})
      @uuid       = options[:uuid] || UUID.generate
      self.model  = options[:model]
    end
  end
  
  class UnspecifiedDataType < DataType; end;
	class FixedLengthTextDataType < DataType; end;
	class VariableLengthTextDataType < DataType; end;
	class LargeLengthTextDataType < DataType; end;
	class SignedIntegerNumericDataType < DataType; end;
	class SignedSmallIntegerNumericDataType < DataType; end;
	class SignedLargeIntegerNumericDataType < DataType; end;
	class UnsignedIntegerNumericDataType < DataType; end;
	class UnsignedTinyIntegerNumericDataType < DataType; end;
	class UnsignedSmallIntegerNumericDataType < DataType; end;
	class UnsignedLargeIntegerNumericDataType < DataType; end;
	class AutoCounterNumericDataType < DataType; end;
	class FloatingPointNumericDataType < DataType; end;
	class SinglePrecisionFloatingPointNumericDataType < DataType; end;
	class DoublePrecisionFloatingPointNumericDataType < DataType; end;
	class DecimalNumericDataType < DataType; end;
	class MoneyNumericDataType < DataType; end;
	class FixedLengthRawDataDataType < DataType; end;
	class VariableLengthRawDataDataType < DataType; end;
	class LargeLengthRawDataDataType < DataType; end;
	class PictureRawDataDataType < DataType; end;
	class OleObjectRawDataDataType < DataType; end;
	class AutoTimestampTemporalDataType < DataType; end;
	class TimeTemporalDataType < DataType; end;
	class DateTemporalDataType < DataType; end;
	class DateAndTimeTemporalDataType < DataType; end;
	class TrueOrFalseLogicalDataType < DataType; end;
	class YesOrNoLogicalDataType < DataType; end;
	class RowIdOtherDataType < DataType; end;
	class ObjectIdOtherDataType < DataType; end;
end
