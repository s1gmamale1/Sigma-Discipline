#!/usr/bin/env bash
# Install either checkpoint skill, or migrate the former combined installation.
set -euo pipefail
skills="$(cd "$(dirname "$0")/../skills" && pwd)"
selection="$1"
shift
case "$selection" in
  checkpoints|project-checkpoints) names=("$selection") ;;
  checkpoint) names=(checkpoints project-checkpoints) ;;
  *) exit 2 ;;
esac
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
# Check every destination before changing the first one.
for dir in "${targets[@]}"; do
  for name in "${names[@]}"; do
    dst="$dir/$name"
    if [[ -e "$dst" || -L "$dst" ]]; then
      if [[ ! -L "$dst" || "$(readlink "$dst")" != "$skills/$name" ]]; then
        echo "Preserved existing installation at $dst" >&2
        exit 1
      fi
    fi
  done
done
for dir in "${targets[@]}"; do
  for name in "${names[@]}"; do
    dst="$dir/$name"
    if [[ "$remove" == 1 ]]; then
      if [[ -L "$dst" ]]; then rm "$dst"; fi
    elif [[ ! -L "$dst" ]]; then
      mkdir -p "$dir"
      ln -s "$skills/$name" "$dst"
    fi
  done
  old="$dir/mvp-checkpoint"
  if [[ "$selection" == checkpoint && -L "$old" && "$(readlink "$old")" == "$skills/mvp-checkpoint" ]]; then
    rm "$old"
  fi
done
