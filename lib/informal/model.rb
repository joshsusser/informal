require "informal/model_no_init"

module Informal
  module Model
    def self.included(klass)
      klass.class_eval do
        include ModelNoInit
      end
    end

    def initialize(attrs={})
      self.attributes = attrs
    end
  end
end
