# frozen_string_literal: true

module Passcraft
  # StrengthAnalyzer evaluates password strength, entropy, and provides feedback.
  class StrengthAnalyzer
    attr_reader :password

    def initialize(password)
      @password = password.to_s
    end

    # Analyzes the password and returns score, rating, entropy, and feedback hints.
    def analyze
      {
        score: score,
        rating: rating,
        entropy: entropy,
        feedback: feedback
      }
    end

    # Calculates a basic score from 0 (weak) to 4 (very strong).
    def score
      s = 0
      return s if password.empty?

      # Length check
      s += 1 if password.length >= 8
      s += 1 if password.length >= 12

      # Diversity check
      types = count_types
      s += 1 if types >= 3
      s += 1 if types == 4 && password.length >= 10

      # Cap at 4, set to 0 for extremely short passwords
      [[s, 4].min, 0].max
    end

    # Maps score to symbolic rating.
    def rating
      case score
      when 0, 1 then :weak
      when 2 then :medium
      when 3 then :strong
      when 4 then :very_strong
      end
    end

    # Estimates the Shannon information entropy of the password in bits.
    def entropy
      return 0.0 if password.empty?

      pool_size = calculate_pool_size
      return 0.0 if pool_size.zero?

      (password.length * Math.log2(pool_size)).round(2)
    end

    # Provides helpful recommendations for weak password aspects.
    def feedback
      hints = []
      hints << "Add lowercase letters" unless password.match?(/[a-z]/)
      hints << "Add uppercase letters" unless password.match?(/[A-Z]/)
      hints << "Add numbers" unless password.match?(/[0-9]/)
      hints << "Add symbols" unless password.match?(/[^a-zA-Z0-9]/)
      hints << "Make it longer (at least 12 characters)" if password.length < 12
      hints
    end

    private

    def count_types
      types = 0
      types += 1 if password.match?(/[a-z]/)
      types += 1 if password.match?(/[A-Z]/)
      types += 1 if password.match?(/[0-9]/)
      types += 1 if password.match?(/[^a-zA-Z0-9]/)
      types
    end

    def calculate_pool_size
      pool_size = 0
      pool_size += 26 if password.match?(/[a-z]/)
      pool_size += 26 if password.match?(/[A-Z]/)
      pool_size += 10 if password.match?(/[0-9]/)
      pool_size += 33 if password.match?(/[^a-zA-Z0-9]/)
      pool_size
    end
  end
end
