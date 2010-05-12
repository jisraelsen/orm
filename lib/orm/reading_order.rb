module ORM
  class ReadingOrder
    attr_reader   :uuid, :reading
    attr_accessor :fact_type, :role_refs
    
    def initialize(options={})
      @uuid           = options[:uuid] || UUID.generate
      self.fact_type  = options[:fact_type]
      self.reading    = options[:reading]
      self.role_refs  = options[:role_refs]
    end
    
    def reading=(other)
      other.reading_order ||= self if other
      @reading = other
    end
    
    def roles
      fact_type ? role_refs.map{|role_ref| fact_type.roles.detect{|o| o.uuid == role_ref }}.compact : []
    end
    
    def role_proxies
      if fact_type && fact_type.respond_to?(:role_proxies)
        role_refs.map{|role_ref| fact_type.role_proxies.detect{|o| o.uuid == role_ref }}.compact
      else
        []
      end
    end
    
    def all_roles
      role_refs.map do |role_ref| 
        r = (roles+role_proxies).detect{|o| o.uuid == role_ref }
        r.respond_to?(:role) ? r.role : r
      end
    end
    
    def verbalization
      reading.text.gsub(/\{(\d+)\}/) {|s| all_roles[$1.to_i].role_player.name }
    end
  end
end
