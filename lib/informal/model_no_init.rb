require "active_model"
module Informal
  module ModelNoInit
    def self.included(klass)
      klass.class_eval do
        extend  ActiveModel::Naming
        include ActiveModel::Validations
        extend  ClassMethods
      end
    end

    module ClassMethods
      if ActiveModel::VERSION::MINOR > 0
        def informal_model_name(name)
          @_model_name = ActiveModel::Name.new(self, nil, name)
        end
      end

      # Provide a class level cache for #to_partial_path. This is an
      # internal method and should not be accessed directly.
      def _to_partial_path #:nodoc:
        @_to_partial_path ||= begin
          element = ActiveSupport::Inflector.underscore(ActiveSupport::Inflector.demodulize(self))
          collection = ActiveSupport::Inflector.tableize(self)
          "#{collection}/#{element}".freeze
        end
      end
    end

    def attributes=(attrs)
      attrs && attrs.each_pair { |name, value| self.send("#{name}=", value) }
    end

    def persisted?
      false
    end

    def new_record?
      true
    end

    def to_model
      self
    end

    def to_key
      [object_id]
    end

    def to_param
      nil
    end

    def to_partial_path
      self.class._to_partial_path
    end
  end
end
