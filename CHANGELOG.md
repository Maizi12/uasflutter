Contributing to Digit
Thanks for your interest in contributing! Digit is a personal learning project exploring Clean Architecture + BLoC with a real accounting domain. PRs and issues are welcome.

Guiding principles

Keep business rules in the domain layer; keep widgets lean.
Enforce double-entry and posting-to-leaf-accounts via domain validations.
Favor small, focused PRs with tests.
Project architecture

Presentation: Flutter + Material 3, BLoC per feature, GoRouter navigation.
Domain: Entities, value objects, repositories (abstract), use-cases, validators.
Data: Drift (SQLite) DAOs, mappers, migrations. Local storage for attachments.
DI: get_it. Codegen: freezed, json_serializable.
Getting started

Fork and clone the repo
Install dependencies:
flutter pub get
dart run build_runner build -d
Run the app:
flutter run
Run checks:
flutter analyze
if [[ -n $(flutter format --set-exit-if-changed -n .) ]]; then flutter format .; fi
flutter test
Issue workflow

Search existing issues first.
Use labels feature, enhancement, bug, testing, infra, area:*.
For new features, include: context, scope, acceptance criteria.
Branching and commits

Branch from main: feature/<short-name>, fix/<short-name>, chore/<short-name>
Descriptive commits; reference issues: “Fixes #123” or “Refs #123”
Keep PRs under ~400 lines of diff when possible.
Code style

Follow Flutter default lints.
Prefer const constructors, final where possible.
Keep widgets small; extract into stateless widgets.
Avoid business logic in UI; use BLoCs/use-cases.
Testing

Unit tests for domain rules (double-entry, validations)
DAO tests for CRUD and queries
Widget tests for critical flows (transaction form, dashboard)
Ensure flutter test passes locally
Data and migrations

Use Drift schema versioning.
For schema changes, add an explicit migration and tests that:
Create vN schema, insert sample data
Migrate to vN+1
Validate data integrity
Security & privacy

No network calls unless explicitly enabled by feature flags.
If adding cloud OCR or external services, document data flows and obtain consent in README.
Submitting a PR

Ensure CI is green (analyze, format, tests)
Provide screenshots/GIFs for UI changes
Update README/docs if behavior or settings change
Fill out PR template (if present)
Conduct

Be respectful and constructive. This is a learning space.
