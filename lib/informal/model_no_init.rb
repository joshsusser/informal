module Informal
  module ModelNoInit
    def self.included(klass)
      klass.class_eval do
        extend  ActiveModel::Naming
        include ActiveModel::Validations
      end
    end

    def attributes=(attrs)
      attrs.each_pair { |name, value| self.send("#{name}=", value) }
    end

    def new_record?
      true
    end

    def to_key
      [object_id]
    end
  end
end
