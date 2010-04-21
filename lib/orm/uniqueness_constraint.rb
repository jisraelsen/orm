module ORM
  class UniquenessConstraint < Constraint
    attr_reader   :id
    attr_accessor :name, :is_internal
    
    # TODO: implement the following:
    # <xs:element name="PreferredIdentifierFor" type="ObjectTypeRef" minOccurs="0"/>
    # <xs:element name="Extensions" type="ExtensionsType" minOccurs="0"/>
    
    def initialize(options={})
      super
      self.is_internal  = options[:is_internal] == "true" ? true : false
    end
  end
end
