## [Unreleased]

- Added `Passcraft.strength` API using `Passcraft::StrengthAnalyzer` to evaluate password score, rating, entropy, and provide feedback.
- Refactored `Passcraft::Generator#initialize` to accept keyword options and delegate to a newly extracted `Passcraft::Configuration` class for better single responsibility.

## [0.1.0] - 2026-05-27

- Initial release
