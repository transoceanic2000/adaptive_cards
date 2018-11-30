# frozen_string_literal: true

module AdaptiveCards
  # An Adaptive Card [ColumnSet](https://adaptivecards.io/explorer/ColumnSet.html)
  class ColumnSet < Base
    option :id, required_type: String
    option :select_action,
           required_type: AdaptiveCards::Action::Base,
           excluded_types: [ AdaptiveCards::Action::ShowCard ]
    option :separator, required_type: AdaptiveCards::Boolean
    option :spacing, valid_values: %w[none small default medium large extraLarge padding]

    attr_accessor :columns
    
    def initialize(options = {})
      super options
      @columns = []
    end

    # Add a {Column} to this column set
    #
    # @param column [Column] the column to add to this set
    # @raise [InvalidContentError] if an invalid element is added
    # @return [ColumnSet] self, to allow method chaining
    def add(column)
      if column.is_a?(AdaptiveCards::Column)
        @columns << column
      else
        raise InvalidContentError,
              "#{column.class} is not a column"
      end
      self
    end
    
    # @return [Hash] suitable for conversion to JSON for dispatch to the client
    #
    # Option keys will have been converted to camel-cased strings already
    def to_h
      hash = super
      hash[:columns] = @columns.map(&:to_h) unless @columns.empty?
      hash
    end
  end
end
