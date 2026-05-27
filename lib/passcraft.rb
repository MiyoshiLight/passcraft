# frozen_string_literal: true

require_relative "passcraft/version"

require_relative "passcraft/generator"

# Passcraft is a secure and customizable password generator library.
module Passcraft
  class Error < StandardError; end

  # Generates a secure random password with the given options.
  # See Passcraft::Generator for details on available options.
  def self.generate(**options)
    Generator.new(**options).generate
  end
end
