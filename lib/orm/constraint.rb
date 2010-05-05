module ORM
  class Constraint
    attr_reader   :uuid
    attr_accessor :name

    def initialize(options={})
      @uuid           = options[:uuid] || UUID.generate
      self.name       = options[:name]
    end
  end
end
