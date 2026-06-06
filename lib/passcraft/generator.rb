# frozen_string_literal: true

require "securerandom"
require "forwardable"
require_relative "configuration"

module Passcraft
  # Generator class responsible for building custom, secure passwords.
  class Generator
    extend Forwardable

    UPPERCASE = ("A".."Z").to_a
    LOWERCASE = ("a".."z").to_a
    NUMBERS = ("0".."9").to_a
    DEFAULT_SYMBOLS = "!@\#$%^&*()-_=+[]{}|;:',.<>?/".chars
    SIMILAR_CHARS = %w[1 I l 0 O o].freeze

    def_delegators :@config, :length, :uppercase, :lowercase, :numbers, :symbols, :exclude_similar, :custom_symbols

    def initialize(**options)
      @config = Configuration.new(**options)
    end

    def generate
      pools = build_character_pools
      raise ArgumentError, "At least one character set must be enabled" if pools.empty?

      guaranteed = select_guaranteed_characters(pools)
      remaining = select_remaining_characters(pools, length - guaranteed.size)

      secure_shuffle(guaranteed + remaining).join
    end

    private

    def select_guaranteed_characters(pools)
      guaranteed_chars = pools.map { |pool| sample(pool) }

      if length < guaranteed_chars.size
        raise ArgumentError, "Length must be at least #{guaranteed_chars.size} to include all requested character types"
      end

      guaranteed_chars
    end

    def select_remaining_characters(pools, count)
      combined_pool = pools.flatten
      Array.new(count) { sample(combined_pool) }
    end

    def build_character_pools
      pools = []
      pools << clean_pool(UPPERCASE) if uppercase
      pools << clean_pool(LOWERCASE) if lowercase
      pools << clean_pool(NUMBERS) if numbers
      pools << clean_pool(symbol_pool) if symbols
      pools.reject(&:empty?)
    end

    def symbol_pool
      custom_symbols ? custom_symbols.chars : DEFAULT_SYMBOLS
    end

    def clean_pool(pool)
      return pool unless exclude_similar

      pool.reject { |char| SIMILAR_CHARS.include?(char) }
    end

    # Safe sampling using SecureRandom for high security
    def sample(array)
      array[SecureRandom.random_number(array.size)]
    end

    # Secure shuffle utilizing Fisher-Yates and SecureRandom
    def secure_shuffle(array)
      shuffled = array.dup
      n = shuffled.size
      (n - 1).downto(1) do |i|
        j = SecureRandom.random_number(i + 1)
        shuffled[i], shuffled[j] = shuffled[j], shuffled[i]
      end
      shuffled
    end
  end
end
