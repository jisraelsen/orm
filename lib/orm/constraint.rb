module ORM
  class Constraint
    attr_reader   :uuid
    attr_accessor :model, :name

    def initialize(options={})
      @uuid       = options[:uuid] || UUID.generate
      self.model  = options[:model]
      self.name   = options[:name]
    end
  end
end
