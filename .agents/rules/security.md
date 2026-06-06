# Rule: Security and Credentials

This rule outlines crucial security policies to prevent security leaks and protect the repository.

## Credentials and Secrets
- **No Credentials in Code**: Never hardcode API keys, passwords, personal access tokens, or any sensitive credentials in source code or test files.
- **Safe Testing**: When writing tests, use mock objects or environmental variables for testing behavior, ensuring no actual secrets are exposed to version control.
