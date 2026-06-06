# Rule: Coding and Style Guidelines

This rule defines the coding style, design principles, and linting rules that AI agents must follow when modifying the codebase.

## Code Style & Linting
- **Enforce RuboCop**: Every Ruby file modified or created must comply with the style rules defined in `.rubocop.yml`. Check style with `bundle exec rubocop` and auto-correct using `bundle exec rubocop -A` before committing.
- **No Inline Disables**: Do not use inline comments (e.g., `# rubocop:disable ...`) to bypass warnings unless absolutely necessary. If required, write a clear justification and obtain user approval first.

## Software Design
- **Ruby Design Patterns**: Adhere to standard Ruby conventions and object-oriented design principles. Apply the Single Responsibility Principle (SRP) to keep classes focused and manageable.
- **Secure Randomness**: Password generation logic must rely on cryptographically secure random sources, such as `SecureRandom`. Never use predictable random generators (e.g., `Kernel#rand`).

## API & Versioning
- **Breaking API Changes**: Ask for confirmation before modifying any public API signature or parameters (e.g., `Passcraft.generate`).
- **No Unnecessary Version Bumps**: Do not modify the gem version in `lib/passcraft/version.rb` unless explicitly requested by the user for an official release task.
