module ORM
  class ValueConstraint < Constraint
    attr_accessor :value_type, :value_ranges
    
    def initialize(options={})
      super
      self.value_type   = options[:value_type]
      self.value_ranges = options[:value_ranges]
    end    
  end
end
