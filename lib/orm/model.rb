module ORM
  class Model
    attr_reader   :uuid, :object_types, :fact_types, :constraints
    attr_reader   :data_types, :model_notes, :model_errors, :reference_mode_kinds
    attr_accessor :name
    
    def initialize(options={})
      @uuid                     = options[:uuid] || UUID.generate
      self.name                 = options[:name]
      self.object_types         = options[:object_types]
      self.fact_types           = options[:fact_types]
      self.constraints          = options[:constraints]
      self.data_types           = options[:data_types]
      self.model_notes          = options[:model_notes]
      self.model_errors         = options[:model_errors]
      self.reference_mode_kinds = options[:reference_mode_kinds]
    end
    
    def object_types=(others)
      others.each {|o| o.model ||= self} if others
      @object_types = others || []
    end
    
    def fact_types=(others)
      others.each {|o| o.model ||= self} if others
      @fact_types = others || []
    end
    
    def constraints=(others)
      others.each {|o| o.model ||= self} if others
      @constraints = others || []
    end
    
    def data_types=(others)
      others.each {|o| o.model ||= self} if others
      @data_types = others || []
    end
    
    def model_notes=(others)
      others.each {|o| o.model ||= self} if others
      @model_notes = others || []
    end
    
    def model_errors=(others)
      others.each {|o| o.model ||= self} if others
      @model_errors = others || []
    end
    
    def reference_mode_kinds=(others)
      others.each {|o| o.model ||= self} if others
      @reference_mode_kinds = others || []
    end
    
    def objectified_types
      object_types.select{|o| o.kind_of?(ORM::ObjectifiedType)}
    end
    
    def uniqueness_constraints
      constraints.select{|o| o.kind_of?(ORM::UniquenessConstraint)}
    end
  end
end
