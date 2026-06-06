# frozen_string_literal: true

RSpec.describe Passcraft::StrengthAnalyzer do
  describe "#analyze" do
    it "returns a hash with score, rating, entropy, and feedback" do
      result = Passcraft.strength("Abc123xyz")
      expect(result).to be_a(Hash)
      expect(result).to have_key(:score)
      expect(result).to have_key(:rating)
      expect(result).to have_key(:entropy)
      expect(result).to have_key(:feedback)
    end

    context "with weak passwords" do
      it "evaluates short and simple passwords as weak" do
        weak_passwords = %w[123 abcde AAAAAA]
        weak_passwords.each do |pw|
          result = Passcraft.strength(pw)
          expect(result[:rating]).to eq(:weak)
          expect(result[:score]).to be <= 1
        end
      end
    end

    context "with medium passwords" do
      it "evaluates moderately diverse passwords as medium" do
        result = Passcraft.strength("Pass12345")
        expect(result[:rating]).to eq(:medium)
        expect(result[:score]).to eq(2)
      end
    end

    context "with strong and very strong passwords" do
      it "evaluates long and diverse passwords as strong or very strong" do
        strong = Passcraft.strength("Password12345")
        expect(strong[:rating]).to eq(:strong)

        very_strong = Passcraft.strength("aB3$eF7*iJ0!mN3#")
        expect(very_strong[:rating]).to eq(:very_strong)
        expect(very_strong[:score]).to eq(4)
      end
    end

    context "feedback verification" do
      it "provides correct hints when character types are missing" do
        result = Passcraft.strength("12345678")
        expect(result[:feedback]).to include("Add lowercase letters")
        expect(result[:feedback]).to include("Add uppercase letters")
        expect(result[:feedback]).to include("Add symbols")
      end

      it "provides hints to make password longer if length is short" do
        result = Passcraft.strength("Ab1$")
        expect(result[:feedback]).to include("Make it longer (at least 12 characters)")
      end
    end

    context "entropy calculation" do
      it "returns 0.0 for empty password" do
        result = Passcraft.strength("")
        expect(result[:entropy]).to eq(0.0)
      end

      it "calculates non-zero entropy for valid passwords" do
        result = Passcraft.strength("Password")
        expect(result[:entropy]).to be > 0.0
      end
    end
  end
end
