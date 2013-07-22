require "active_model"
require "active_support/core_ext/module/attribute_accessors"

module Informal
  mattr_accessor :suggest_active_model_model
  self.suggest_active_model_model = true

  module ModelNoInit
    def self.included(klass)
      if defined?(ActiveModel::Model) && Informal.suggest_active_model_model
        ActiveSupport::Deprecation.warn("This version of Active Model has ActiveModel::Model, which is very similar to Informal::Model and Informal::ModelNoInit. Consider including ActiveModel::Model instead. You can silence this warning by setting Informal.suggest_active_model_model = false before you include this module.",
                                        caller.reject { |s| s.include? "lib/informal" })
      end

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
  end
end
