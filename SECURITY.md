# Security and privacy

TrainerOne keeps workout data on the device. The app does not offer accounts,
file uploads, photo uploads, document uploads, or a way to submit personal
health records.

## Data boundary

- Workout sessions are stored locally in SQLite (`trainerone.db`).
- The exercise list is the built-in demo catalogue. There is no remote
  catalogue client.
- There is no Firebase, RevenueCat, AdMob, or planning API client.
- Do not add an upload or sync feature for user data without a separate
  privacy review, consent flow, retention policy, and a deletion path.

## Repository safety

Do not commit service-account files, certificates, signing keys, `.env` files,
`.dev.vars`, Wrangler state, database exports, or real user data. The
repository's safety check blocks common secret filenames and credential
patterns. That script reads the git file list and greps text. It does not
execute repository content from the network.

Removing a secret from the latest commit does not remove it from Git history.
If a credential was ever pushed, rotate it and rewrite the affected history
before making the repository public.

Before opening a pull request, run:

```bash
./scripts/check-public-repo.sh
flutter test
```
