# frozen_string_literal: true

RSpec.describe Passcraft do
  it "has a version number" do
    expect(Passcraft::VERSION).not_to be nil
  end

  describe ".generate" do
    it "generates a password of the default length (16)" do
      password = Passcraft.generate
      expect(password.length).to eq(16)
    end

    it "generates a password with a custom length" do
      password = Passcraft.generate(length: 24)
      expect(password.length).to eq(24)
    end

    context "with specific character types enabled/disabled" do
      it "does not contain uppercase letters if disabled" do
        10.times do
          password = Passcraft.generate(uppercase: false)
          expect(password).not_to match(/[A-Z]/)
        end
      end

      it "does not contain lowercase letters if disabled" do
        10.times do
          password = Passcraft.generate(lowercase: false)
          expect(password).not_to match(/[a-z]/)
        end
      end

      it "does not contain numbers if disabled" do
        10.times do
          password = Passcraft.generate(numbers: false)
          expect(password).not_to match(/[0-9]/)
        end
      end

      it "does not contain symbols if disabled" do
        10.times do
          password = Passcraft.generate(symbols: false)
          # We check against our default symbol list
          expect(password).not_to match(%r{[!@\#$%^&*()\- _=+\[\]{}|;:',.<>?/]})
        end
      end
    end

    context "guaranteeing presence of requested character types" do
      it "always contains at least one of each requested type even with small lengths" do
        # When generating a 4-character password with all 4 types enabled,
        # it must contain exactly 1 uppercase, 1 lowercase, 1 number, and 1 symbol.
        password = Passcraft.generate(length: 4, uppercase: true, lowercase: true, numbers: true, symbols: true)
        expect(password).to match(/[A-Z]/)
        expect(password).to match(/[a-z]/)
        expect(password).to match(/[0-9]/)
        expect(password).to match(%r{[!@\#$%^&*()\- _=+\[\]{}|;:',.<>?/]})
      end
    end

    context "with similar character exclusion" do
      it "excludes similar characters (1, I, l, 0, O, o) when exclude_similar is true" do
        10.times do
          password = Passcraft.generate(exclude_similar: true)
          expect(password).not_to match(/[1Il0Oo]/)
        end
      end
    end

    context "with custom symbols" do
      it "uses only custom symbols when provided" do
        custom = "@#"
        10.times do
          password = Passcraft.generate(
            length: 20,
            uppercase: false,
            lowercase: false,
            numbers: false,
            symbols: true,
            custom_symbols: custom
          )
          # Since all other pools are disabled, it should only consist of custom symbols
          expect(password.chars.uniq.sort).to eq(["#", "@"].sort)
        end
      end
    end

    context "validation and edge cases" do
      it "raises ArgumentError when length is not an integer" do
        expect { Passcraft.generate(length: "16") }.to raise_error(ArgumentError)
      end

      it "raises ArgumentError when length is less than or equal to 0" do
        expect { Passcraft.generate(length: 0) }.to raise_error(ArgumentError)
      end

      it "raises ArgumentError when all pools are disabled" do
        expect do
          Passcraft.generate(uppercase: false, lowercase: false, numbers: false, symbols: false)
        end.to raise_error(ArgumentError)
      end

      it "raises ArgumentError when length is shorter than active categories" do
        expect do
          Passcraft.generate(length: 3, uppercase: true, lowercase: true, numbers: true, symbols: true)
        end.to raise_error(ArgumentError)
      end
    end
  end
end
