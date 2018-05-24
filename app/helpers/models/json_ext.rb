module Models
  module JsonExt
    module InstanceMethods
      def as_short_json
        return self.to_hash unless self.class.short_attributes.to_a.any?
        self.to_hash.select { |k, v| self.class.short_attributes.include?(k) }
      end
    end

    module ClassMethods
      attr_accessor :short_attributes
      def short_json_attributes(*attrs)
        
        self.short_attributes = attrs.to_a
      end

      def as_short_json
        self.map(&:as_short_json)
      end
    end

    def self.included(base)
      base.extend         ClassMethods
      base.send :include, InstanceMethods
    end
  end
end