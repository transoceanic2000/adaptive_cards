# frozen_string_literal: true

module AdaptiveCards
  # An Adaptive Card [TextBlock](https://adaptivecards.io/explorer/TextBlock.html)
  class TextBlock < Base
    option :id, required_type: String
    option :color, valid_values: %w[default dark light accent good warning attention]
    option :horizontal_alignment, valid_values: %w[left center right]
    option :is_subtle, required_type: AdaptiveCards::Boolean
    option :max_lines, required_type: Integer
    option :separator, required_type: AdaptiveCards::Boolean
    option :size, valid_values: %w[small default medium large extraLarge]
    option :spacing, valid_values: %w[none small default medium large extraLarge padding]
    option :weight, valid_values: %w[lighter default bolder]
    option :wrap, required_type: AdaptiveCards::Boolean

    attr_accessor :text

    # Create a new text block with the given text and options
    # @param text [String] the text to include in the text block
    # @param options [Hash] the options to set on the text block,
    #   see the Adaptive Card schema for valid values
    def initialize(text, options = {})
      super options
      @text = text
    end
    
    def to_h
      super.merge( text: text )
    end
  end
end
