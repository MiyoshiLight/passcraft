# AGENTS.md

This file provides context, instructions, and guidelines for AI agents working on the `passcraft` project.

## Project Overview
`passcraft` is a Ruby gem designed to generate secure and customizable passwords.
It supports customized character sets (uppercase, lowercase, numbers, and symbols), password length, exclusion of similar characters, and custom symbol lists. It uses a cryptographically secure random number generator (`SecureRandom`) to ensure password security.

## Tech Stack
- **Language**: Ruby (Recommended: `>= 3.1.0`, see [passcraft.gemspec](../passcraft.gemspec))
- **Testing**: RSpec
- **Linter**: RuboCop
- **Development Tools**: Rake, IRB

## Setup & Development
The basic steps for developing in this project are as follows:

1. **Install Dependencies**:
   ```bash
   bundle install
   ```
   Or run `bin/setup` to initialize the project environment.

2. **Run Tests**:
   Tests are written and run using RSpec.
   - Run all tests:
     ```bash
     bundle exec rake spec
     ```
     or
     ```bash
     bundle exec rspec
     ```
   - Run a specific test file:
     ```bash
     bundle exec rspec spec/passcraft_spec.rb
     ```

3. **Interactive Console (REPL)**:
   ```bash
   bin/console
   ```
   This will start an IRB session with the current codebase pre-loaded, allowing you to run `Passcraft.generate` interactively.

4. **Local Installation**:
   ```bash
   bundle exec rake install
   ```

## Development Workflow
Before making any changes to the codebase, you must follow this 7-step workflow:
1. **Create a Plan**: Follow [skills/plan.md](../.agents/skills/plan.md) to research the requirements and draft a clear implementation plan first. Do not make code changes yet.
2. **Obtain User Approval**: Present the plan to the user and wait for their explicit approval before proceeding to implementation.
3. **Implement**: Write the code as planned in a clean and maintainable way.
4. **Review**: Follow [skills/review.md](../.agents/skills/review.md) to perform a self-review of your changes.
5. **Run Linter**: Run RuboCop (`bundle exec rubocop`) to ensure the code style complies with project guidelines, and fix any styling issues.
6. **Run Tests**: Execute RSpec (`bundle exec rspec`) to verify that all new and existing tests pass.
7. **Commit Safely**: Follow [skills/commit.md](../.agents/skills/commit.md) to stage files, draft a descriptive commit message, and commit changes after obtaining user approval.

## Git Workflow
When checking out code, developing, and committing, you must adhere to the following branch and commit lifecycle:
1. **Prepare main**: Ensure your local `main` branch is up to date:
   ```bash
   git checkout main
   git pull
   ```
2. **Create a Feature/Fix Branch**: Never work or commit directly on `main`. Create a dedicated branch using the naming convention `feature/<name>` or `fix/<name>`:
   ```bash
   git checkout -b feature/my-new-feature
   ```
3. **Develop & Verify**: Apply the 7-step development workflow (Plan, Approval, Implement, Review, Linter, Test, Commit) on this branch.
4. **Push & Report**: Push your branch to the remote repository and notify the user to create a pull request:
   ```bash
   git push -u origin feature/my-new-feature
   ```

## Slash Commands
AI agents must support the following custom slash commands in the conversation:
- `/plan`: Trigger the planning process. When this command is received, the agent must immediately execute the planning workflow ([workflows/plan.md](../.agents/workflows/plan.md)) to research requirements and propose an implementation plan. No source code changes are allowed during this command.
- `/review`: Trigger the code self-review process. The agent must execute the review workflow ([workflows/review.md](../.agents/workflows/review.md)) to audit the quality and safety of the changes before formatting and testing.
- `/commit`: Trigger the safe commit process. The agent must immediately execute the commit workflow ([workflows/commit.md](../.agents/workflows/commit.md)) to review changes, branch check, update CHANGELOG, and perform a secure commit.

## Rules & Guidelines
To maintain code quality, security, and project consistency, you must follow the rules defined in the `.agents/rules/` directory:
- **Coding & Style**: [rules/coding.md](../.agents/rules/coding.md) - Coding standards, RuboCop guidelines, and design principles.
- **Security**: [rules/security.md](../.agents/rules/security.md) - Rules to prevent credential leaks.
- **Dependencies**: [rules/dependencies.md](../.agents/rules/dependencies.md) - Policy on adding or changing dependencies.

## Skills (Procedural Instructions)
Special skill files are defined in the `.agents/skills/` directory to guide specific operations:
- **Create a Plan**: [skills/plan.md](../.agents/skills/plan.md) - Explains how to research, design, and draft a clear implementation plan before changing any code.
- **Self-Review**: [skills/review.md](../.agents/skills/review.md) - Guides the self-review of code quality and correctness.
- **Git Commit**: [skills/commit.md](../.agents/skills/commit.md) - Explains how to stage files, draft commit messages, and commit safely after verification and approval.

## Workflows (Procedural Instructions)
Special workflow files are defined in the `.agents/workflows/` directory to guide specific operations:
- **Create a Plan (Entrypoint)**: [workflows/plan.md](../.agents/workflows/plan.md) - Workflow file that triggers the planning skill.
- **Run Review (Entrypoint)**: [workflows/review.md](../.agents/workflows/review.md) - Workflow file that triggers the self-review skill.
- **Git Commit (Entrypoint)**: [workflows/commit.md](../.agents/workflows/commit.md) - Workflow file that triggers the commit skill.

## Directory Structure
- `lib/`: Main source directory
  - [lib/passcraft.rb](../lib/passcraft.rb) - Main entrypoint of the gem
  - `lib/passcraft/`: Sub-modules and internal logic
    - [lib/passcraft/generator.rb](../lib/passcraft/generator.rb) - Password generator implementation
    - [lib/passcraft/version.rb](../lib/passcraft/version.rb) - Version definition
- `spec/`: Test suite
  - [spec/passcraft_spec.rb](../spec/passcraft_spec.rb) - Specifications for password generation
  - [spec/spec_helper.rb](../spec/spec_helper.rb) - RSpec configuration
- [passcraft.gemspec](../passcraft.gemspec): Gem specification metadata
- [Gemfile](../Gemfile): Development dependencies configuration
