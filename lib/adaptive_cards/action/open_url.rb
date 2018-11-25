# frozen_string_literal: true

module AdaptiveCards
  module Action
    # Adapative Card [action to open a URL](https://adaptivecards.io/explorer/Action.OpenUrl.html)
    class OpenUrl < Base
      ALLOWED_OPTIONS = {
                          title: String
                        }.freeze

      attr_accessor *ALLOWED_OPTIONS.keys

      # The URL that will be opened if the user triggers this action
      attr_accessor :url

      def initialize(url, options = {})
        @url = url
        setup_options options
      end

      def to_h
        super.merge(url: url)
      end

      def supported_options
        ALLOWED_OPTIONS
      end
    end
  end
end
