# frozen_string_literal: true

module AdaptiveCards
  # An AdaptiveCard [Container](https://adaptivecards.io/explorer/Container.html)
  # for sending to an AdaptiveCard renderer
  class Container < Base
    option :id, required_type: String
    option :select_action, required_type: AdaptiveCards::Action::Base,
                           excluded_types: [ AdaptiveCards::Action::ShowCard ]
    option :separator, required_type: AdaptiveCards::Boolean
    option :spacing, valid_values: %w[none small default medium large extraLarge]
    option :style, valid_values: %w[default emphasis]
    option :vertical_content_alignment, valid_values: %w[top]

    attr_accessor :items

    def initialize(options = {})
      super options
      @items = []
    end

    # Add an item to this container
    #
    # @param item [AdaptiveCards::Base] the card element to add to this
    #   container
    # @raise [InvalidContentError] if an invalid element is added
    # @return [Container] self, to allow method chaining
    def add(item)
      if item.is_a?(AdaptiveCards::Base) &&
         !item.is_a?(AdaptiveCards::AdaptiveCard) &&
         !item.is_a?(AdaptiveCards::Action::Base)
        @items << item
      else
        raise InvalidContentError,
              "#{item.class} is not a valid item for a container"
      end
      self
    end
    
    def to_h
      super.merge(items: items.map(&:to_h))
    end
  end
end
