module ORM
  class ConceptualDataType
    attr_reader   :uuid
    attr_accessor :value_type, :data_type_ref, :scale, :length
    
    def initialize(options={})
      @uuid               = options[:uuid] || UUID.generate
      self.value_type     = options[:value_type]
      self.data_type_ref  = options[:data_type_ref]
      self.scale          = options[:scale].to_i if options[:scale]
      self.length         = options[:length].to_i if options[:length]
    end
    
    def data_type
      value_type.model.data_types.detect{|o| o.uuid == data_type_ref } if value_type && value_type.model
    end
  end
end
