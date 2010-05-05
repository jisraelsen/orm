module ORM
  class Constraint
    attr_reader   :model, :uuid
    attr_accessor :name

    def initialize(options={})
      @model    = options[:model]
      @uuid     = options[:uuid] || UUID.generate
      self.name = options[:name]
    end
  end
end
