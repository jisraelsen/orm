module ORM
  class ModelNote    
    attr_reader   :model, :uuid
    attr_accessor :text
    
    def initialize(options={})
      @model    = options[:model]
      @uuid     = options[:uuid] || UUID.generate
      self.text = options[:text]
    end
  end
end
