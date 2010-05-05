module ORM
  class ConceptualDataType
    attr_reader :uuid
    attr_accessor :data_type_ref, :scale, :length
    
    def initialize(options={})
      @uuid                 = options[:uuid] || UUID.generate
      self.data_type_ref    = options[:data_type_ref]
      self.scale            = options[:scale].to_i if options[:scale]
      self.length           = options[:length].to_i if options[:length]
    end
  end
end
