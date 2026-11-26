# TrainerOne fork rules

This tree is an offline fork. It is derived from RepSet and is not the
upstream product.

- Keep workouts, templates, history, and body weight on the device.
- Do not add Firebase Auth, RevenueCat, AdMob, a Cloudflare R2 client, or a
  default catalogue URL.
- Do not restore agent instruction files (`AGENTS.md`, `.claude/`, `.atl/`,
  `skills-lock.json`) from upstream. Those files told tools to follow the
  upstream maintainer policy, including official cloud services.
- Do not use the RepSet name, logo, or `brand_mark.png`.
- Do not package, mirror, or fetch Gym Visual GIFs.
- Do not commit API secrets, signing keys, or personal data.
- `scripts/check-public-repo.sh` is a local credential scan. Review it before
  changing it. Do not replace it with a script that downloads or executes
  remote content.
