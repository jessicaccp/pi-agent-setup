# pi agent setup

Portable snapshot of a [pi](https://www.npmjs.com/package/@earendil-works/pi-coding-agent) agent configuration: global settings, a project template, an extension config, and one custom skill. Two scripts: one installs the snapshot on a machine, one refreshes the snapshot from the live files.

Everything under `agent/` and `agents/` mirrors a real live location, so the repo doubles as an example of how pi is configured.

## Install

```bash
git clone <this-repo-url>
cd <repo>
./apply.sh
```

`apply.sh` moves every file it replaces into `~/.pi-agent-backups/<timestamp>/` and asks before overwriting an existing file (`-y` skips the prompts). It never touches `auth.json`, `trust.json`, sessions, or run history. Restart pi afterwards.

## What each file does

| Path in this repo | Installs to | Content |
|---|---|---|
| `agent/settings.json` | `~/.pi/agent/settings.json` | Packages installed on startup, default provider/model/thinking, compaction |
| `agent/AGENTS.md` | `~/.pi/agent/AGENTS.md` | Global instructions loaded in every session |
| `agent/models-store.json` | `~/.pi/agent/models-store.json` | Custom model definitions (endpoint, cost, context window) |
| `agent/templates/AGENTS.project.md` | `~/.pi/agent/templates/AGENTS.project.md` | Template for a project-level `AGENTS.md` |
| `agent/extensions/pi-rtk-optimizer/config.json` | `~/.pi/agent/extensions/pi-rtk-optimizer/config.json` | Runtime config for the `pi-rtk-optimizer` package |
| `agents/skills/academic-research/` | `~/.agents/skills/academic-research/` | Skill for literature research with verified citations |

`apply.sh` also re-creates the `~/.pi/agent/skills/<name>` symlinks that expose skills stored in `~/.agents/skills/`.

## Adjust before using

- `agent/settings.json`: `packages` is the list pi installs on startup; if one fails, run `pi install <package>`. `defaultProvider`, `defaultModel`, and `defaultThinkingLevel` are the defaults for new sessions.
- `agent/models-store.json`: replace with the models you actually use.
- `agent/AGENTS.md`: written in Brazilian Portuguese, for one specific workflow. Rewrite it to match your own conventions; it is loaded in every project.
- `agent/templates/AGENTS.project.md`: fill in per project, then copy it to that project as `AGENTS.md`.

## Credentials

No keys are stored here. Pi reads provider keys from `~/.pi/agent/auth.json` or from environment variables. See `credentials.md`.

## Skills

Only `academic-research` ships here. Third-party skills are not vendored: install them from their own source instead, for example the `mattpocock/skills` collection (MIT) or the `graphify` skill that comes with the `graphifyy` Python package. Anything placed in `~/.agents/skills/` is picked up by pi.

## Fresh machine

`SETUP.md` walks through installing pi, cloning this repo, setting a provider key, restoring the setup, and the first run.

## Not tracked

`auth.json`, `trust.json`, `sessions/`, `run-history.jsonl`, packages under `~/.pi/agent/npm/`, and the agent memory directory `~/.pi/agent/memory/`. Memory and trust are personal to a machine and stay out of the snapshot.

## Refresh the snapshot

On the machine where the configuration changed:

```bash
./snapshot.sh
git diff
git commit -am "chore: refresh agent setup"
git push
```

`snapshot.sh` re-copies the live versions of exactly the paths in the table above. It does not copy memory.
