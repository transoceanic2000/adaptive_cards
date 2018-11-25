# frozen_string_literal: true

require 'json'

# Adaptive Card generator to prepare compliant JSON ready for dispatch to an
# AdaptiveCard client (e.g. Microsoft Teams)
module AdaptiveCards
  class NotSupportedError < StandardError; end
  class InvalidElementError < StandardError; end
  class Boolean; end

  require 'adaptive_cards/version'
  require 'adaptive_cards/base'
  require 'adaptive_cards/action/base'
  require 'adaptive_cards/action/open_url'
  require 'adaptive_cards/text_block'
  require 'adaptive_cards/container'
  require 'adaptive_cards/fact_set'
  require 'adaptive_cards/column'
  require 'adaptive_cards/column_set'
  require 'adaptive_cards/adaptive_card'
end
