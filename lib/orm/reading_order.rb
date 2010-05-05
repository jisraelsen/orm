module ORM
  class ReadingOrder
    attr_reader   :uuid
    attr_accessor :reading, :role_refs
    
    def initialize(options={})
      @uuid           = options[:uuid] || UUID.generate
      self.reading    = options[:reading]
      self.role_refs  = options[:role_refs]
    end
  end
end
