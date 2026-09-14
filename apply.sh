#!/usr/bin/env bash
# Install this snapshot into ~/.pi/agent and ~/.agents. Anything replaced is
# moved into ~/.pi-agent-backups/<timestamp>/ first; auth.json, trust.json,
# sessions, and run history are never touched.
set -euo pipefail

SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TS="$(date +%Y%m%d-%H%M%S)"
PI_HOME="$HOME/.pi/agent"
AGENTS_HOME="$HOME/.agents"
BACKUP="$HOME/.pi-agent-backups/$TS"
ASSUME_YES=0

case "${1:-}" in
  "") ;;
  -y|--yes) ASSUME_YES=1 ;;
  *) echo "usage: $(basename "$0") [-y|--yes]" >&2; exit 2 ;;
esac

# confirm <path>: called only when the target already exists.
confirm() {
  if [ "$ASSUME_YES" = 1 ]; then
    return 0
  fi
  if [ ! -t 0 ]; then
    echo "refusing to overwrite $1 without confirmation; re-run with -y" >&2
    exit 1
  fi
  read -r -p "overwrite $1? [y/N] " answer
  case "$answer" in
    [yY] | [yY][eE][sS]) return 0 ;;
    *) return 1 ;;
  esac
}

# install_root <src-root> <dst-root>: install every top-level entry of src-root
# into dst-root, backing up any existing dst entry it replaces.
install_root() {
  local sroot="$1" droot="$2" item name bak
  mkdir -p "$droot"
  for item in "$sroot"/* "$sroot"/.[!.]*; do
    [ -e "$item" ] || continue
    name="$(basename "$item")"
    if [ -e "$droot/$name" ]; then
      if ! confirm "$droot/$name"; then
        echo "skipped: $droot/$name"
        continue
      fi
      bak="$BACKUP/${droot#"$HOME"/}/$name"
      mkdir -p "$(dirname "$bak")"
      mv "$droot/$name" "$bak"
      echo "backed up: $droot/$name"
    fi
    cp -a "$item" "$droot/$name"
    echo "installed: $droot/$name"
  done
}

if command -v python3 >/dev/null 2>&1; then
  python3 -m json.tool "$SRC/agent/settings.json" >/dev/null
  python3 -m json.tool "$SRC/agent/models-store.json" >/dev/null
else
  echo "warning: python3 not found, skipping JSON validation" >&2
fi

install_root "$SRC/agent" "$PI_HOME"
install_root "$SRC/agents" "$AGENTS_HOME"

# Re-create the ~/.pi/agent/skills symlinks for skills kept in ~/.agents/skills.
mkdir -p "$PI_HOME/skills"
for d in "$AGENTS_HOME"/skills/*/; do
  [ -d "$d" ] || continue
  name="$(basename "$d")"
  link="$PI_HOME/skills/$name"
  if [ -e "$link" ] || [ -L "$link" ]; then
    echo "exists (skip): $link"
  else
    ln -s "$AGENTS_HOME/skills/$name" "$link"
    echo "linked: $link -> $AGENTS_HOME/skills/$name"
  fi
done

echo
if [ -d "$BACKUP" ]; then
  echo "Replaced files backed up in: $BACKUP"
fi
echo "Restart pi so the restored configuration, skills, and instructions are picked up."
