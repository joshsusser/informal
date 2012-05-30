if ActiveModel::VERSION::MINOR == 0
  module Informal
    class ModelName < ActiveModel::Name
      def initialize(name)
        name.instance_eval do
          def name() self; end
        end
        super
      end
    end
  end
end

