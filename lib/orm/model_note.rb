module ORM
  class ModelNote    
    attr_reader   :uuid
    attr_accessor :model, :text
    
    def initialize(options={})
      @uuid       = options[:uuid] || UUID.generate
      self.model  = options[:model]
      self.text   = options[:text]
    end
  end
end
