#!/usr/bin/env bash
# Install just mvp-checkpoint from a persistent checkout.
set -euo pipefail
src="$(cd "$(dirname "$0")/../skills/mvp-checkpoint" && pwd)"
remove=0
targets=()
for arg in "$@"; do
  case "$arg" in
    --codex) targets+=("$HOME/.agents/skills") ;;
    --claude) targets+=("${CLAUDE_CONFIG_DIR:-$HOME/.claude}/skills") ;;
    --grok) targets+=("${GROK_HOME:-$HOME/.grok}/skills") ;;
    --hermes) targets+=("${HERMES_HOME:-$HOME/.hermes}/skills") ;;
    --uninstall) remove=1 ;;
    *) echo "Unknown checkpoint option: $arg" >&2; exit 2 ;;
  esac
done
if [ "${#targets[@]}" -eq 0 ]; then
  echo 'Usage: ./install.sh checkpoint [--uninstall] --codex | --claude | --grok | --hermes (combine targets as needed)' >&2
  exit 2
fi
for dir in "${targets[@]}"; do
  dst="$dir/mvp-checkpoint"
  if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
    if [ "$remove" -eq 1 ]; then rm "$dst"; fi
  elif [ -e "$dst" ] || [ -L "$dst" ]; then
    echo "Preserved existing skill at $dst; it belongs to a different installation." >&2
    exit 1
  elif [ "$remove" -eq 0 ]; then
    mkdir -p "$dir"
    ln -s "$src" "$dst"
  fi
done
