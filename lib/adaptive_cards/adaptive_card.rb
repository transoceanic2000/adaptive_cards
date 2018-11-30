# frozen_string_literal: true

module AdaptiveCards
  # An [Adaptive Card](https://docs.microsoft.com/en-us/adaptive-cards/)
  # for sending to an Adaptive Card renderer (e.g. Teams)
  class AdaptiveCard < Base
    option :select_action, required_type: AdaptiveCards::Action::Base,
                           excluded_types: [ AdaptiveCards::Action::ShowCard ]
    option :fallback_text, required_type: String
    option :background_image, required_type: String
    option :speak, required_type: String
    option :lang, required_type: String

    SCHEMA = 'http://adaptivecards.io/schemas/adaptive-card.json'

    # Retrieve the list of elements in the card's body
    attr_reader :body
    
    # Retrieve the list of actions for the card
    attr_reader :actions

    # Setup a new AdapativeCard
    #
    # @param elements option set of AdaptiveCard elements, which will be added
    #   to the appropriate part of the card (body or actions)
    # @param options [Hash] options to set on this
    def initialize(*elements, **options)
      super options
      @actions = []
      @body = []
      elements.each { |e| add e }
    end

    def schema
      SCHEMA
    end

    def version
      '1.0'
    end

    # Add an item (a card element, container or action) to the card
    #
    # @param item [AdaptiveCards::Base,string] the card element to add, or
    #   a string to add in a basic text block
    #
    # Most items are added to the card's body, but actions will get
    # automatically added to the action bar.
    # As a shortcut we will also accept a string and will automatically convert
    # this to a TextBlock.
    def add(item)
      if item.is_a?(Action::Base)
        @actions << item
      elsif item.is_a?(String)
        @body << TextBlock.new(item)
      elsif item.is_a?(AdaptiveCards::Base) &&
            !item.is_a?(AdaptiveCards::AdaptiveCard)
        @body << item
      else
        raise InvalidContentError,
              "#{item.class} is not a valid element of an Adaptive Card"
      end
      self
    end

    def to_h
      hash = {
               '$schema' => schema,
               type: type,
               version: version,
             }.merge super
      hash[:body] = body.map(&:to_h) unless body.empty?
      hash
    end

    def to_json(options = {})
      to_h.to_json(options)
    end
  end
end
