require "irozuku"

module Irozuku
  module Validation
    class ValidationError < StandardError
      def initialize(msg)
        super
      end
    end
  end
end
