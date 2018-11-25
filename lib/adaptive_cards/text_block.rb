# frozen_string_literal: true

module AdaptiveCards
  # An Adaptive Card [TextBlock](https://adaptivecards.io/explorer/TextBlock.html)
  class TextBlock < Base
    ALLOWED_OPTIONS = { 
                        horizontal_alignment: %w[left center right],
                        color: %w[default dark light accent good warning attention],
                        subtle: AdaptiveCards::Boolean,
                        max_lines: Integer,
                        size: %w[small default medium large extraLarge],
                        weight: %w[lighter default bolder],
                        wrap: AdaptiveCards::Boolean,
                        spacing: %w[none small default medium large extraLarge],
                        separator: AdaptiveCards::Boolean
                      }.freeze

    attr_accessor *ALLOWED_OPTIONS.keys

    attr_accessor :text

    # Create a new text block with the given text and options
    # @param text [String] the text to include in the text block
    # @param options [Hash] the options to set on the text block,
    #   see the Adaptive Card schema for valid values
    def initialize(text, options = {})
      @text = text
      setup_options options
    end
    
    def to_h
      super.merge( text: text )
    end

    def supported_options
      ALLOWED_OPTIONS
    end
  end
end
