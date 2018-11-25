# frozen_string_literal: true

module AdaptiveCards
  # An AdaptiveCard [FactSet](https://adaptivecards.io/explorer/FactSet.html) for
  # sending to an AdaptiveCard renderer
  class FactSet < Base
    ALLOWED_OPTIONS = { 
                        spacing: %w[none small default medium large extraLarge],
                        separator: AdaptiveCards::Boolean
                      }.freeze

    attr_accessor *ALLOWED_OPTIONS.keys

    attr_accessor :facts

    def initialize(options = {})
      @facts = []
      setup_options options
    end

    # Add a new fact to the fact set
    # @param title [String] the title of the fact
    # @param value [String] the value of the fact
    # @return [FactSet] self, to allow method chaining
    def add(title, value)
      @facts << { title: title, value: value }
      self
    end

    def supported_options
      ALLOWED_OPTIONS
    end

    def to_h
      super.merge facts: facts
    end
  end
end
