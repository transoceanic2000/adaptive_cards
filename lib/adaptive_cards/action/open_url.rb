# frozen_string_literal: true

module AdaptiveCards
  module Action
    # Adapative Card [action to open a URL](https://adaptivecards.io/explorer/Action.OpenUrl.html)
    class OpenUrl < Base
      option :title, required_type: String

      # The URL that will be opened if the user triggers this action
      attr_accessor :url

      def initialize(url, options = {})
        super options
        @url = url
      end

      def to_h
        super.merge(url: url)
      end
    end
  end
end
