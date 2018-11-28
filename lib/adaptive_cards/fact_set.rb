# frozen_string_literal: true

module AdaptiveCards
  # An AdaptiveCard [FactSet](https://adaptivecards.io/explorer/FactSet.html) for
  # sending to an AdaptiveCard renderer
  class FactSet < Base
    option :separator, required_type: AdaptiveCards::Boolean
    option :spacing, valid_values: %w[none small default medium large extraLarge]

    attr_accessor :facts

    def initialize(options = {})
      super options
      @facts = []
    end

    # Add a new fact to the fact set
    # @param title [String] the title of the fact
    # @param value [String] the value of the fact
    # @return [FactSet] self, to allow method chaining
    def add(title, value)
      @facts << { title: title, value: value }
      self
    end

    def to_h
      super.merge facts: facts
    end
  end
end
