#!/usr/bin/env bash
# Refresh this snapshot from the live locations. Run from the repo root, review
# with 'git diff', then commit. Memory and trust are deliberately not copied.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$ROOT"

refresh() {
  local src="$1" dst="$2"
  if [ -e "$src" ]; then
    rm -rf "$dst"
    mkdir -p "$(dirname "$dst")"
    cp -a "$src" "$dst"
    echo "updated: $dst"
  else
    echo "skip (missing on this machine): $src"
  fi
}

refresh "$HOME/.pi/agent/settings.json" agent/settings.json
refresh "$HOME/.pi/agent/AGENTS.md" agent/AGENTS.md
refresh "$HOME/.pi/agent/models-store.json" agent/models-store.json
refresh "$HOME/.pi/agent/templates/AGENTS.project.md" agent/templates/AGENTS.project.md
refresh "$HOME/.pi/agent/extensions/pi-rtk-optimizer/config.json" agent/extensions/pi-rtk-optimizer/config.json
refresh "$HOME/.agents/skills/academic-research" agents/skills/academic-research

echo "Snapshot refreshed. Review with 'git diff', then commit and push."
