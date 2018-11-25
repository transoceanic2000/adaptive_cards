# frozen_string_literal: true

module AdaptiveCards
  # An Adaptive Card [Column](https://adaptivecards.io/explorer/Column.html)
  class Column < Base
    ALLOWED_OPTIONS = {
                        id: String,
                        select_action: AdaptiveCards::Action::Base,
                        separator: AdaptiveCards::Boolean,
                        style: %w[default emphasis],
                        spacing: %w[none small default medium large extraLarge],
                        width: %w[auto stretch] # Also need to support numeric widths
                      }.freeze

    attr_accessor *ALLOWED_OPTIONS.keys
    
    attr_accessor :items

    def initialize(options = {})
      @items = []
      setup_options options
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

    def supported_options
      ALLOWED_OPTIONS
    end
  end
end
