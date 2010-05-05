module ORM
  class ReferenceModeKind
    attr_reader   :uuid
    attr_accessor :model, :format_string, :reference_mode_type
    
    def initialize(options={})
      @uuid                     = options[:uuid] || UUID.generate
      self.model                = options[:model]
      self.format_string        = options[:format_string]
      self.reference_mode_type  = options[:reference_mode_type]
    end
  end
end
