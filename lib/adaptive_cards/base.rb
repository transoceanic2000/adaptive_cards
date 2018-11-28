# frozen_string_literal: true

module AdaptiveCards
  # Base class for all Adaptive Card elements
  class Base
    class << self
      attr_accessor :supported_options
    end

    protected
    
    def initialize( options )
      options.each_key do |opt_key|
        self.send("#{opt_key}=", options[opt_key])
      end
    end
    
    def self.option(symbol, options = {})
      self.supported_options ||= {}
      self.supported_options[symbol] = {}
      %i[required_type excluded_types valid_values].each do |option|
        self.supported_options[symbol][option] = options[option]
      end
      
      define_method(symbol) do
        instance_variable_get("@#{symbol}")
      end
      
      define_method("#{symbol}=") do |value|
        if !self.class.supported_options[symbol][:excluded_types].nil? &&
           self.class.supported_options[symbol][:excluded_types].include?( value.class )
          raise NotSupportedError,
                "Cannot use a #{value.class.name} for #{symbol} option on #{self.class.name}"
        end
        
        if !self.class.supported_options[symbol][:required_type].nil? &&
           self.class.supported_options[symbol][:required_type] != AdaptiveCards::Boolean &&
           !value.is_a?(self.class.supported_options[symbol][:required_type])
          raise AdaptiveCards::NotSupportedError,
                "#{symbol} option on #{self.class.name} requires a #{self.class.supported_options[symbol][:required_type]}"
        elsif !self.class.supported_options[symbol][:required_type].nil? &&
              self.class.supported_options[symbol][:required_type] == AdaptiveCards::Boolean
          raise AdaptiveCards::NotSupportedError, "#{option} requires a boolean, not #{value}" unless [true, false].include?(value)
        end
        
        if !self.class.supported_options[symbol][:valid_values].nil? &&
           !self.class.supported_options[symbol][:valid_values].include?( value.to_s )
          raise AdaptiveCards::NotSupportedError,
                "#{value} is not a valid value for #{symbol}"
        end
        
        instance_variable_set("@#{symbol}", value)
      end
    end

    # @return [String] the class name to use as a type argument in the JSON
    def type
      self.class.name.split('::').last
    end

    def to_h
      optional_elements = {}
      self.class.supported_options.each_key do |option_key|
        key = convert_key_to_camel(option_key.to_s)
        unless send(option_key).nil?
          # If the option is another Adaptive Card element we need to convert
          # it too a hash, otherwise we can just set the value directly.
          if send(option_key).class.name.split('::')[0] == 'AdaptiveCards'
            optional_elements[key] = send(option_key).to_h
          else
            optional_elements[key] = send(option_key)
          end
        end
      end

      { type: type }.merge(optional_elements)
    end

    private

    def convert_key_to_camel(key)
      key.gsub(/_([a-z])/) do
        m = Regexp.last_match
        m[1].upcase
      end
    end
  end
end
