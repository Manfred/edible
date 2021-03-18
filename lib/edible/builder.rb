# frozen_string_literal: true

module Edible
  class Builder
    class InvalidError < StandardError; end

    DEFAULTS = {
      component_data_element_separator: ':',
      data_element_separator: '+',
      # The original decimal mark is actuall a comma, and depending on the UNB segment we must
      # use either a dot, a comma, or either is acceptable. Any choice other than a dot will likely
      # cause interoperability problems.
      decimal_notation: '.',
      release_indicator: '?',
      segment_terminator: "'",

      interchange: nil,
      version: 1,

      newline: "\n"
    }.freeze

    DELIMITERS = %i[
      component_data_element_separator
      data_element_separator
      decimal_notation
      release_indicator
      segment_terminator
    ].freeze

    attr_reader(*DEFAULTS.keys)

    def initialize(out, **settings)
      @out = out
      verify_settings(settings)
      apply_settings(settings)
    end

    def delimiters?
      @delimiters
    end

    def una
      return unless delimiters?

      segment('UNA') do
        @out << component_data_element_separator
        @out << data_element_separator
        @out << decimal_notation
        @out << release_indicator
        @out << ' ' # A nice space that has been reserved since 1987.
      end
    end

    def unb
      return unless interchange

      segment('UNB', [[interchange, version]])
    end

    def segment(segment, *components, &block)
      @out << segment
      instance_eval(&block) if block
      components.each do |component|
        @out << data_element_separator
        @out << format(component)
      end
      @out << segment_terminator
      @out << newline
    end

    def format(data)
      data.is_a?(Enumerable) ? data.join(component_data_element_separator) : data.to_s
    end

    private

    def verify_settings(settings)
      unknown = settings.keys - DEFAULTS.keys
      return if unknown.empty?

      raise(ArgumentError, "unknown keywords: #{unknownmap(&:inspect).join(', ')}")
    end

    def apply_settings(settings)
      @delimiters = !(DELIMITERS & settings.keys).empty?

      DEFAULTS.each do |name, value|
        instance_variable_set("@#{name}", settings.fetch(name, value))
      end
    end
  end
end
