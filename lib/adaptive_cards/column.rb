# frozen_string_literal: true

module AdaptiveCards
  # An Adaptive Card [Column](https://adaptivecards.io/explorer/Column.html)
  class Column < Base
    option :id, required_type: String
    option :select_action, required_type: AdaptiveCards::Action::Base,
                           excluded_types: [ AdaptiveCards::Action::ShowCard ]
    option :separator, required_type: AdaptiveCards::Boolean
    option :spacing, valid_values: %w[none small default medium large extraLarge]
    option :style, valid_values: %w[default emphasis]
    option :width, valid_values: %w[auto stretch] # Also need to support numeric widths

    attr_accessor :items

    def initialize(options = {})
      super options
      @items = []
    end

    # Add an item to this column
    #
    # @param item [AdaptiveCards::Base] the card element to add to this
    #   column
    # @raise [InvalidElementError] if an invalid element is added
    # @return [Column] self, to allow method chaining
    def add(item)
      if item.is_a?(AdaptiveCards::Base) &&
         !item.is_a?(AdaptiveCards::AdaptiveCard) &&
         !item.is_a?(AdaptiveCards::Action::Base)
        @items << item
      else
        raise InvalidElementError,
              "#{item.class} is not a valid item for a column"
      end
      self
    end
    
    def to_h
      super.merge(items: items.map(&:to_h))
    end
  end
end
