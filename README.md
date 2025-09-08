Digit — Multi‑Wallet Double‑Entry Accounting (Flutter)
Digit is a personal, experimental multi‑wallet business accounting app built with Flutter. It uses true double‑entry bookkeeping with a configurable Chart of Accounts, budgets, and basic reporting. The project is a learning playground using Clean Architecture and BLoC.

Platforms: Android, iOS (potential: macOS/web later)
Architecture: Clean Architecture (domain/data/presentation), BLoC, GoRouter, Drift (SQLite)
Key features (MVP): COA + Wallets, double‑entry transactions, dashboard, budgets, local OCR (invoice → draft), CSV export, optional PIN/biometrics
Table of contents
Demo
Roadmap and milestones
Features
Architecture
Data model
Getting started
Development
Testing and CI
Configuration
Security and privacy
Contributing
License
Acknowledgements
Demo
Screenshots or GIFs here (Dashboard, Transactions, COA, Budget, OCR).

/docs/images/dashboard.png
/docs/images/transaction_form.png
/docs/images/coa.png
/docs/images/budget.png
Roadmap and milestones
Tracked in GitHub Issues and Milestones.

MVP (v1.0): COA/Wallets, double‑entry, dashboard, budgets, local OCR, CSV export, PIN/biometric
v1.1: Recurring, period close/lock, P&L and cash flow reports, OCR line items, backup/restore
v2.0: Multi‑currency, cloud sync + web viewer, bank import, advanced dashboards
See Issues for detailed breakdown. Assignments default to @Maizi12.

Features (MVP)
Chart of Accounts (Assets/Liabilities/Equity/Income/Expenses), editable leaf accounts
Wallets mapped to COA accounts with running balances
Double‑entry transactions (expense, income, transfer, journal) with attachments
Dashboard: wallet overview, COA summaries, recent transactions, net worth
Account detail: ledger + balance‑over‑time chart
Budgets: monthly per account with variance
OCR (on‑device): extract date/total/merchant, create draft transaction
Export CSV (accounts, transactions, lines)
Optional PIN/biometric lock
Offline‑first, local persistence
Architecture
Presentation: Flutter + Material 3, BLoC per feature, GoRouter for navigation
Domain: Use‑cases, entities, repositories (interfaces), validation rules (double‑entry)
Data: Drift (SQLite) with DAOs and migrations, local file storage for attachments
DI: get_it
Models/serialization: freezed, json_serializable
Folder structure (example):

lib/
core/ (utils, error handling, theme)
features/
accounts/
wallets/
transactions/
budgets/
dashboard/
ocr/
app/ (router, di, app widget)
data/ (if separated) or lib/features/*/data
test/
Data model (simplified)
Tables:

accounts(id, name, code, type, parentId, isActive)
wallets(id, name, accountId, currency, isActive)
transactions(id, date, memo, reference, createdAt, updatedAt)
transaction_lines(id, transactionId, accountId, walletId?, amount, side: Debit|Credit)
budgets(id, periodStart, periodEnd, accountId or tag, amount, rollover?)
tags(id, name); transaction_tags(txId, tagId)
attachments(id, txId, uri, mimeType)
settings(key, value)
Rules:

sum(Debits) == sum(Credits) per transaction
Post to leaf accounts only
Single base currency in MVP
Getting started
Prerequisites:

Flutter (stable channel)
Dart SDK (bundled with Flutter)
Android Studio/Xcode for platform builds
Setup:

flutter pub get
flutter gen-l10n (if using localization; optional)
dart run build_runner build -d (if using freezed/json_serializable)
Run:

flutter run
For iOS: open ios/Runner.xcworkspace in Xcode if needed
Environment (optional):

Create .env or use build‑time defines for feature flags (e.g., OCR engine).
Development
Conventions:

BLoC per feature with immutable states/events
Use‑cases are thin orchestrators over repositories
Drift for typed queries and migrations
Keep widgets dumb; business logic in BLoCs/use‑cases
Useful scripts:

Format: flutter format .
Analyze: flutter analyze
Build runner: dart run build_runner watch -d
Commits and issues:

Use GitHub issues and milestones (MVP, v1.1, v2.0)
Labels: feature, enhancement, bug, testing, infra, area:* and priority:*
Testing and CI
Run tests:

flutter test --coverage
CI:

.github/workflows/ci.yml runs analyze, format check, and tests on push/PR to main/master.
Coverage artifact uploaded as lcov.info.
Configuration
Settings in‑app:

Currency and locale, date/number format
Feature flags: OCR engine (on‑device vs none), demo data
Export/backup location
Seeding:

On first run, seed a minimal COA; idempotent
Optional demo data toggle in Settings
Security and privacy
Local‑only by default; no network calls unless you enable a cloud OCR engine (future)
Data stored locally (SQLite + attachments)
Optional PIN/biometric lock (platform keystore)
If cloud OCR is added later, disclose what is sent and obtain consent
Contributing
This is primarily a personal learning project, but PRs/issues are welcome.

Open an issue describing change
Follow architecture and testing conventions
Ensure CI passes
Issue templates and labels:

Feature request template in .github/ISSUE_TEMPLATE/feature.md
Default labels provided in repo (see labels.json)
License
Specify your license (e.g., MIT). Include LICENSE file.

Acknowledgements
Flutter, Drift, freezed, BLoC, GoRouter
Google ML Kit (Text Recognition)
Inspiration: standard accounting practices and personal finance apps
Notes for future versions

v1.1: recurring transactions, period close, P&L/Cash Flow, backup/restore, OCR line items
v2.0: multi‑currency, cloud sync, bank import, advanced dashboards
