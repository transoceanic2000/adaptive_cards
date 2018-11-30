# frozen_string_literal: true

module AdaptiveCards
  # An AdaptiveCard [Image](https://adaptivecards.io/explorer/Image.html)
  # for sending to an AdaptiveCard renderer
  class Image < Base
    option :alt_text, required_type: String
    option :horizontal_alignment, valid_values: %w[left center right]
    option :id, required_type: String
    option :image_size, valid_values: %w[auto stretch small medium large]
    option :select_action, required_type: AdaptiveCards::Action::Base,
                           excluded_types: [ AdaptiveCards::Action::ShowCard ]
    option :separator, required_type: AdaptiveCards::Boolean
    option :spacing, valid_values: %w[none small default medium large extraLarge]
    option :style, valid_values: %w[default person]

    attr_accessor :url

    def initialize(url, options = {})
      raise InvalidContentError, 'Must specify a valid URL for an image' unless url.is_a?(String) ||
                                                                                url.is_a?(URI::Generic)
      super options
      @url = url
    end

    def to_h
      super.merge(url: @url)
    end
  end
end
