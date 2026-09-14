# Fresh machine setup

Install and configure pi from zero using this repo.

## 1. Install pi

Pi is an npm package. With Node.js and npm available:

```bash
npm install -g --ignore-scripts @earendil-works/pi-coding-agent
pi --version
```

## 2. Clone this repo

```bash
git clone <this-repo-url>
cd <repo>
```

## 3. Provider credentials

Pi reads API keys from `~/.pi/agent/auth.json` or from environment variables. Pick one:

- Export the key in your shell profile (`~/.bashrc`, `~/.zshrc`), then start pi from a new shell. For the DeepSeek provider used by the bundled `settings.json`:

  ```bash
  export DEEPSEEK_API_KEY=sk-...
  ```

- Or start pi, run `/login`, and select the API-key provider; pi stores the key in `~/.pi/agent/auth.json`.

See `credentials.md`.

## 4. Restore the setup

```bash
./apply.sh
```

It backs up whatever it replaces into `~/.pi-agent-backups/<timestamp>/`, installs `agent/` into `~/.pi/agent/` and `agents/` into `~/.agents/`, re-creates the `~/.pi/agent/skills/<name>` symlinks, and leaves `auth.json`, `trust.json`, sessions, and run history alone.

## 5. First run

Start pi in a project folder:

```bash
cd ~/code/some-project
pi
```

- The packages listed in `settings.json` are installed on startup. If one is missing afterwards, run `pi install <package>` for that entry.
- Check the model with `/model` and the thinking level with `/thinking`; both come from `settings.json`.
- The global instructions are loaded from `~/.pi/agent/AGENTS.md` on startup. After editing that file, run `/reload`.

## 6. What pi recreates on its own

`trust.json` (asked per project on first access), `sessions/`, `run-history.jsonl`, and installed packages under `~/.pi/agent/npm/`. Nothing to restore.

## Update later

Run `./snapshot.sh` on the machine where you changed something, then review, commit, and push. See `README.md`.
