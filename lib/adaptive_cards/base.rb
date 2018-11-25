# frozen_string_literal: true

module AdaptiveCards
  # Base class for all Adaptive Card elements
  class Base
    protected

    # @return [String] the class name to use as a type argument in the JSON
    def type
      self.class.name.split('::').last
    end

    # Set the specified option for this element
    # @param option [Symbol] the option to set
    # @param value the value of the option
    # @raise [NotSupportedError] if the option is not supported for this element
    #   or the option value is not valid for the option
    def set_option(option, value)
      if supported_options[option].nil?
        raise NotSupportedError,
              "#{option} is not a supported option for #{self.class.name}"
      end
      
      if supported_options[option].is_a?(AdaptiveCards::Boolean)
        set_bool_option(option, value)
      elsif supported_options[option] == Integer
        set_int_option(option, value)
      elsif supported_options[option] == String
        set_string_option(option, value)
      else
        set_enum_option(option, value)
      end
    end

    def setup_options(options)
      options.each_pair do |option, value|
        set_option(option, value)
      end
    end

    def to_h
      optional_elements = {}
      supported_options.each_key do |option_key|
        key = convert_key_to_camel(option_key.to_s)
        optional_elements[key] = send(option_key) unless send(option_key).nil?
      end

      { type: type }.merge(optional_elements)
    end

    private

    def set_bool_option(option, value)
      raise NotSupportedError, "#{option} requires a boolean, not #{value}" unless [true, false].include?(value)

      send "#{option}=", value
    end

    def set_int_option(option, value)
      raise NotSupportedError, "#{option} requires an integer, not #{value}" unless value.is_a?(Integer)
      
      send "#{option}=", value
    end

    def set_string_option(option, value)
      send "#{option}=", value.to_s
    end

    def set_enum_option(option, value)
      raise NotSupportedError, "#{value} is not a valid value for #{option}" unless supported_options[option].include?(value.to_s)

      send "#{option}=", value.to_s
    end

    def convert_key_to_camel(key)
      key.gsub(/_([a-z])/) do
        m = Regexp.last_match
        m[1].upcase
      end
    end
  end
end
