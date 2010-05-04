module ORM
  class ModelError
    attr_reader :uuid
    attr_accessor :name
    
    def initialize(options={})
      @uuid     = options[:uuid] || UUID.generate
      self.name = options[:name]
    end
  end
  
  class DataTypeNotSpecifiedError < ModelError
    attr_accessor :conceptual_data_type_ref
    
    def initialize(options={})
      super
      self.conceptual_data_type_ref = options[:conceptual_data_type_ref]
    end
  end
end
