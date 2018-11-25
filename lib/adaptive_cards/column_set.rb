# frozen_string_literal: true

module AdaptiveCards
  # An Adaptive Card [ColumnSet](https://adaptivecards.io/explorer/ColumnSet.html)
  class ColumnSet < Base
    ALLOWED_OPTIONS = {
                        id: String,
                        select_action: AdaptiveCards::Action::Base,
                        separator: AdaptiveCards::Boolean,
                        spacing: %w[none small default medium large extraLarge padding]
                      }.freeze

    attr_accessor *ALLOWED_OPTIONS.keys
    
    attr_accessor :columns

    def initialize(options = {})
      @columns = []
      setup_options options
    end

    # Add a {Column} to this column set
    #
    # @param column [Column] the column to add to this set
    # @raise [InvalidElementError] if an invalid element is added
    # @return [ColumnSet] self, to allow method chaining
    def add(column)
      if column.is_a?(AdaptiveCards::Column)
        @columns << column
      else
        raise InvalidElementError,
              "#{column.class} is not a column"
      end
      self
    end
    
    # @return [Hash] suitable for conversion to JSON for dispatch to the client
    #
    # Option keys will have been converted to camel-cased strings already
    def to_h
      hash = super
      hash[:columns] = columns.map(&:to_h) unless columns.empty?
      hash
    end

    def supported_options
      ALLOWED_OPTIONS
    end
  end
end
