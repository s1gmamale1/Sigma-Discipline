#!/usr/bin/env bash
# Sigma-Discipline installer.
#
# Installs the wishlist + roadmap planning discipline into whichever of
# Claude Code / Codex / OpenCode are present, from the single canonical source
# (skills/<name>/SKILL.md). Derived files are regenerated each run.
#
#   ./install.sh                      auto-detect installed tools, install all found
#   ./install.sh --claude --codex     install only the named tools
#   ./install.sh --opencode
#   ./install.sh --uninstall          remove installed skills/prompts/commands
#                                      (never touches your WISHLIST.md / ROADMAP.md)
set -euo pipefail

REPO="$(cd "$(dirname "$0")" && pwd)"
SKILLS_DIR="$REPO/skills"
NAMES="wishlist roadmap"

CLAUDE_SKILLS="${CLAUDE_CONFIG_DIR:-$HOME/.claude}/skills"
CODEX_PROMPTS="${CODEX_HOME:-$HOME/.codex}/prompts"
OPENCODE_CMDS="${XDG_CONFIG_HOME:-$HOME/.config}/opencode/command"

WANT_CLAUDE=0 WANT_CODEX=0 WANT_OPENCODE=0 UNINSTALL=0 EXPLICIT=0

for arg in "$@"; do
  case "$arg" in
    --claude)    WANT_CLAUDE=1; EXPLICIT=1 ;;
    --codex)     WANT_CODEX=1; EXPLICIT=1 ;;
    --opencode)  WANT_OPENCODE=1; EXPLICIT=1 ;;
    --uninstall) UNINSTALL=1 ;;
    -h|--help)   sed -n '2,12p' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
    *) echo "unknown flag: $arg" >&2; exit 2 ;;
  esac
done

# No tool flags → auto-detect what's installed.
if [ "$EXPLICIT" -eq 0 ]; then
  { [ -d "${CLAUDE_CONFIG_DIR:-$HOME/.claude}" ] || command -v claude >/dev/null 2>&1; } && WANT_CLAUDE=1
  { [ -d "${CODEX_HOME:-$HOME/.codex}" ]        || command -v codex  >/dev/null 2>&1; } && WANT_CODEX=1
  { [ -d "${XDG_CONFIG_HOME:-$HOME/.config}/opencode" ] || command -v opencode >/dev/null 2>&1; } && WANT_OPENCODE=1
fi

# Strip the leading YAML frontmatter block ONLY (preserves body --- rules).
strip_frontmatter() {
  awk 'NR==1 && /^---$/ {fm=1; next} fm==1 && /^---$/ {fm=2; next} fm!=1 {print}' "$1"
}

# Re-point Claude "roadmap/wishlist skill" cross-references to slash-command
# phrasing (bolded body refs + plain refs in prose/descriptions). The backticks
# are literal markdown — single quotes (no expansion) are intentional here.
# shellcheck disable=SC2016
repoint() {
  sed -e 's#\*\*roadmap\*\* skill#`/roadmap` command#g' \
      -e 's#\*\*wishlist\*\* skill#`/wishlist` command#g' \
      -e 's#the roadmap skill#the `/roadmap` command#g' \
      -e 's#the wishlist skill#the `/wishlist` command#g'
}

get_description() {
  grep -m1 '^description:' "$1" | sed 's/^description: *//'
}

did_any=0

install_claude() {
  mkdir -p "$CLAUDE_SKILLS"
  for n in $NAMES; do
    ln -sfn "$SKILLS_DIR/$n" "$CLAUDE_SKILLS/$n"
    echo "  claude   → $CLAUDE_SKILLS/$n  (symlink)"
  done
}

install_codex() {
  mkdir -p "$CODEX_PROMPTS"
  for n in $NAMES; do
    strip_frontmatter "$SKILLS_DIR/$n/SKILL.md" | repoint > "$CODEX_PROMPTS/$n.md"
    echo "  codex    → $CODEX_PROMPTS/$n.md"
  done
}

install_opencode() {
  mkdir -p "$OPENCODE_CMDS"
  for n in $NAMES; do
    desc="$(get_description "$SKILLS_DIR/$n/SKILL.md" | repoint)"
    { printf -- '---\ndescription: %s\n---\n\n' "$desc"
      strip_frontmatter "$SKILLS_DIR/$n/SKILL.md" | repoint
    } > "$OPENCODE_CMDS/$n.md"
    echo "  opencode → $OPENCODE_CMDS/$n.md"
  done
}

uninstall() {
  for n in $NAMES; do
    [ -L "$CLAUDE_SKILLS/$n" ] && rm -f "$CLAUDE_SKILLS/$n" && echo "  removed $CLAUDE_SKILLS/$n"
    [ -f "$CODEX_PROMPTS/$n.md" ] && rm -f "$CODEX_PROMPTS/$n.md" && echo "  removed $CODEX_PROMPTS/$n.md"
    [ -f "$OPENCODE_CMDS/$n.md" ] && rm -f "$OPENCODE_CMDS/$n.md" && echo "  removed $OPENCODE_CMDS/$n.md"
  done
  echo "Uninstalled. Your WISHLIST.md / ROADMAP.md files were not touched."
}

if [ "$UNINSTALL" -eq 1 ]; then
  uninstall
  exit 0
fi

echo "Installing Sigma-Discipline (wishlist + roadmap) from $REPO"
if [ "$WANT_CLAUDE" -eq 1 ];   then install_claude;   did_any=1; fi
if [ "$WANT_CODEX" -eq 1 ];    then install_codex;    did_any=1; fi
if [ "$WANT_OPENCODE" -eq 1 ]; then install_opencode; did_any=1; fi

if [ "$did_any" -eq 0 ]; then
  echo "No target tools detected. Pass --claude / --codex / --opencode explicitly." >&2
  exit 1
fi

cat <<'EOF'

Done. Invoke with /wishlist and /roadmap in any of the installed tools.

Always-on (optional): slash-commands are pull-based. To make the discipline apply
automatically in a project, copy this repo's AGENTS.md into your project root
(Codex + OpenCode auto-load it) or append it to ~/.codex/AGENTS.md. Claude Code:
mirror the same pointer into CLAUDE.md. This installer does not edit those files.
EOF
