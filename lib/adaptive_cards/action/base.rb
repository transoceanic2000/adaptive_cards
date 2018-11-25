# frozen_string_literal: true

module AdaptiveCards
  module Action
    # Base class for Adaptive Card actions
    class Base < AdaptiveCards::Base
      # @return [String] the class name to use as a type argument in the JSON
      #
      # Actions use a dotted notation to identify them
      def type
        self.class.name.split('::')[-2..-1].join('.')
      end
    end
  end
end
