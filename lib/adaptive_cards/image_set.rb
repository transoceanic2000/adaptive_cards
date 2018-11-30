# frozen_string_literal: true

module AdaptiveCards
  # An Adaptive Card [ImageSet](https://adaptivecards.io/explorer/ImageSet.html)
  class ImageSet < Base
    option :id, required_type: String
    option :image_size, valid_values: %w[auto stretch small medium large]
    option :separator, required_type: AdaptiveCards::Boolean
    option :spacing, valid_values: %w[none small default medium large extraLarge padding]

    attr_accessor :images
    
    def initialize(options = {})
      super options
      @images = []
    end

    # Add a {Image} to this column set
    #
    # @param image [Image] the image to add to this set
    # @raise [InvalidContentError] if an invalid element is added
    # @return [ImageSet] self, to allow method chaining
    def add(image)
      if image.is_a?(AdaptiveCards::Image)
        @images << image
      else
        raise InvalidContentError,
              "#{image.class} is not an image"
      end
      self
    end
    
    # @return [Hash] suitable for conversion to JSON for dispatch to the client
    #
    # Option keys will have been converted to camel-cased strings already
    def to_h
      hash = super
      hash[:images] = @images.map(&:to_h)
      hash
    end
  end
end
