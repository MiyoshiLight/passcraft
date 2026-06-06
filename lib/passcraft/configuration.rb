# frozen_string_literal: true

module Passcraft
  # Configuration class responsible for holding password generator settings.
  class Configuration
    DEFAULT_LENGTH = 16

    attr_reader :length, :uppercase, :lowercase, :numbers, :symbols, :exclude_similar, :custom_symbols

    def initialize(
      length: DEFAULT_LENGTH,
      uppercase: true,
      lowercase: true,
      numbers: true,
      symbols: true,
      exclude_similar: false,
      custom_symbols: nil
    )
      @length = length
      @uppercase = uppercase
      @lowercase = lowercase
      @numbers = numbers
      @symbols = symbols
      @exclude_similar = exclude_similar
      @custom_symbols = custom_symbols

      validate_arguments!
    end

    private

    def validate_arguments!
      raise ArgumentError, "Length must be an integer" unless length.is_a?(Integer)
      raise ArgumentError, "Length must be greater than 0" if length <= 0
    end
  end
end
