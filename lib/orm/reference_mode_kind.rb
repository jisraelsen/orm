module ORM
  class ReferenceModeKind
    attr_reader   :uuid
    attr_accessor :format_string, :reference_mode_type
    
    def initialize(options={})
      @uuid                     = options[:uuid] || UUID.generate
      self.format_string        = options[:format_string]
      self.reference_mode_type  = options[:reference_mode_type]
    end
  end
end
