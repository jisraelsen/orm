module ORM
  class ModelNote    
    attr_reader   :uuid
    attr_accessor :text
    
    def initialize(options={})
      @uuid     = options[:uuid] || UUID.generate
      self.text = options[:text]
    end
  end
end
