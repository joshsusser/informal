require "active_model"
module Informal
  module ModelNoInit
    def self.included(klass)
      klass.class_eval do
        extend  ActiveModel::Naming
        include ActiveModel::Validations
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
