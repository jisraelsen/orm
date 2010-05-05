module ORM
  class Reading
    attr_reader   :uuid
    attr_accessor :reading_order, :text
    
    def initialize(options={})
      @uuid               = options[:uuid] || UUID.generate
      self.reading_order  = options[:reading_order]
      self.text           = options[:text]
    end
  end
end
