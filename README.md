# TrainerOne

An offline workout logger. Plan a session, log every set, rest, and keep the
history on the device.

TrainerOne is a derivative of [RepSet](https://github.com/oscarcrescente/open-repset)
by Oscar Crescente, licensed under [Apache-2.0](LICENSE). The **RepSet** name,
logo, and `assets/icon/brand_mark.png` are not part of that license and are not
used here. See [TRADEMARKS.md](TRADEMARKS.md).

## What stays on the device

- Workouts, templates, history, body weight, and analytics are stored in SQLite.
- The exercise list is the built-in demo catalogue.
- There is no account, purchase SDK, advertising SDK, or remote catalogue client.
- Exercise previews do not load from the network.

Gym Visual exercise GIFs are third-party media used by upstream RepSet. They
are not in this repository and this app does not fetch them. See
[MEDIA_NOTICE.md](MEDIA_NOTICE.md).

## Run locally

Requirements: Flutter with Dart `^3.12.1`.

```bash
flutter pub get
flutter run
```

Quality checks:

```bash
flutter analyze
flutter test
./scripts/check-public-repo.sh
```

`scripts/check-public-repo.sh` only scans tracked files for credential
filenames and patterns. It does not download code or contact a network.
`.github/workflows/public-repo-safety.yml` runs that same script with
`contents: read`. `pubspec.yaml` has no `git:` package sources.

## Project notes

- [SECURITY.md](SECURITY.md) — local data boundary
- [OPEN_SOURCE_OPERATING_MODEL.md](OPEN_SOURCE_OPERATING_MODEL.md) — fork rules
- [DESIGN.md](DESIGN.md) — visual and motion notes from the upstream design
- [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md) — open-source attribution

## License

Source code is licensed under [Apache-2.0](LICENSE). Copyright 2026 Oscar
Crescente. Third-party media and the RepSet brand are excluded.
