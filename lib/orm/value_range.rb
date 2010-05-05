module ORM
  class ValueRange
    attr_reader :uuid
    attr_accessor :min_value, :max_value, :min_inclusion, :max_inclusion
    
    def initialize(options={})
      @uuid               = options[:uuid] || UUID.generate
      self.min_value      = options[:min_value]
      self.max_value      = options[:max_value]
      self.min_inclusion  = options[:min_inclusion] # can be Open, Closed, or NotSet
      self.max_inclusion  = options[:max_inclusion] # can be Open, Closed, or NotSet
    end
  end
end