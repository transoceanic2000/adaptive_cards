# frozen_string_literal: true

module AdaptiveCards
  module Action
    # Adapative Card [action to open a URL](https://adaptivecards.io/explorer/Action.OpenUrl.html)
    class ShowCard < Base
      option :title, required_type: String
      # option :icon_url, required_type: String - v1.1 option
      
      def initialize(card, options = {})
        super options
        raise InvalidContentError,
              "ShowCard action requires an Adaptive Card to show" unless card.is_a?(AdaptiveCards::AdaptiveCard)

        @card = card
      end

      def to_h
        super.merge(card: @card.to_h)
      end
    end
  end
end
