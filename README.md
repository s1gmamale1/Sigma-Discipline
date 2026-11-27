# Sigma-Discipline

A portable **planning + shipping discipline** for AI coding agents. The planning half is two
complementary documents kept at every project's root:

- **`WISHLIST.md`** — the low-ceremony **capture inbox**. Ideas, deferrals, nice-to-haves, and
  out-of-scope bugs/findings land here so nothing good is forgotten. Append-only.
- **`ROADMAP.md`** — the authoritative, **priority-ordered plan** of what to build next, as
  phases. Only scoped, sequenced, committed work; every phase has named deliverables and a
  testable definition of done.

The flow: **capture in WISHLIST → triage → promote a scoped item into a ROADMAP phase → build →
record the outcome.** WISHLIST stays a parking lot; ROADMAP stays clean and executable.

Alongside the planning docs, two **shipping discipline** skills close the loop once work is built:

- **`sigma-check`** — the shipper. When a unit of work is finished and the local gate is green, it
  opens the PR, deploys an *independent* reviewer, loops fix→re-review (max 3 rounds), and merges
  autonomously only on a genuinely green gate. Releases/tags/migrations always stop for sign-off.
- **`wrap-up`** — post-ship housekeeping. After work is merged and verified, it cleans junk and
  dead code (allowlisted, never blind — no `git clean -fd`), prunes merged branches, and syncs
  docs/project memory. Only tidies finished work; only deletes what it can name.

Full cycle: **capture → triage → promote → build → `/sigma-check` (ship) → `/wrap-up` (clean).**

This repo packages that discipline as slash-commands / skills for **Claude Code**, **Codex**, and
**OpenCode**, from a single canonical source so the three never drift.

## MVP task and milestone checkpoints

Use [mvp-checkpoint](skills/mvp-checkpoint/SKILL.md) after each implementation task and whenever verified readiness crosses 20%, 40%, 60%, 80% or 100%. It covers plan drift, evidence, cleanup, efficiency and the owner's decision to resume at milestones. It also works in a single-agent project.

From a persistent checkout, select the local agents you use. This command installs only the checkpoint skill. Add `--uninstall` to remove its links.

```sh
./install.sh checkpoint --codex --claude --grok --hermes
```

| Agent | Discovery location | Use in a fresh session |
|---|---|---|
| Codex | `~/.agents/skills/mvp-checkpoint` | `$mvp-checkpoint` |
| Claude Code | `~/.claude/skills/mvp-checkpoint` | `/mvp-checkpoint` |
| Grok Build | `~/.grok/skills/mvp-checkpoint` | Ask for `mvp-checkpoint` by name |
| Hermes Agent | `~/.hermes/skills/mvp-checkpoint` | `/mvp-checkpoint` |

The installer respects `CLAUDE_CONFIG_DIR`, `GROK_HOME` and `HERMES_HOME`. The links follow updates to this checkout. [Grok Build skill discovery](https://docs.x.ai/build/features/skills-plugins-marketplaces) · [Hermes skills](https://hermes-agent.nousresearch.com/docs/guides/work-with-skills)

**Grok Bot** has its own private skill library. Attach the [canonical SKILL.md](skills/mvp-checkpoint/SKILL.md) in a Bot conversation and ask “Save these instructions as a private skill named mvp-checkpoint. Preserve both checkpoint rules and the explicit resume requirement.” Enable it under **Connect apps → Private skills** if needed, then ask the Bot to use it by name. After a repository update, refresh the private copy. [Grok Bot skills](https://docs.x.ai/grok-bot/skills-routines-and-automations)

To check discovery and behavior, ask the agent what it would do if verified readiness moved from 38% to 41% just before a demo. It should report 41%, perform the 40% whole-project review and wait for explicit resume.

## Layout

```
skills/
  wishlist/SKILL.md      ← CANONICAL source (Claude Code skill format)
  roadmap/SKILL.md       ← CANONICAL source
  wrap-up/SKILL.md       ← CANONICAL source (post-ship housekeeping)
  sigma-check/SKILL.md   ← CANONICAL source (review-loop auto-merge shipper)
AGENTS.md                ← condensed always-on planning discipline (Codex + OpenCode auto-read this)
install.sh               ← installs into each tool's native format from the canonical source
```

The `skills/*/SKILL.md` files are the single source of truth. The Codex prompts and OpenCode
commands are **derived** from them at install time (frontmatter rewritten, cross-references
re-pointed) — edit the SKILL.md, re-run install, done.

## Install

```sh
git clone https://github.com/s1gmamale1/Sigma-Discipline.git
cd Sigma-Discipline
./install.sh              # auto-detects which of the three tools are present
# or target specific tools:
./install.sh --claude --codex --opencode
```

| Tool | Mechanism | Lands at | Invoke |
|------|-----------|----------|--------|
| **Claude Code** | skill (symlink) | `~/.claude/skills/{wishlist,roadmap,wrap-up,sigma-check}` | `/wishlist`, `/roadmap`, `/wrap-up`, `/sigma-check` (auto-discovered) |
| **Codex** | prompt | `~/.codex/prompts/{wishlist,roadmap,wrap-up,sigma-check}.md` | same slash-commands |
| **OpenCode** | command | `~/.config/opencode/command/{wishlist,roadmap,wrap-up,sigma-check}.md` | same slash-commands |

Re-running `install.sh` is idempotent (it overwrites the derived files and refreshes the Claude
symlinks). If a skill already exists at the Claude path as a **real directory** (hand-authored or
copied), the installer moves it aside to `<name>.pre-sigma-discipline.bak` before symlinking — it
never deletes your version.

### Always-on (optional, recommended)

Slash-commands are pull-based. To make the discipline *always* apply in a project — so the agent
reaches for WISHLIST/ROADMAP without being asked — copy this repo's [`AGENTS.md`](AGENTS.md) into
your project root (Codex and OpenCode both auto-load `AGENTS.md`), or append its content to your
global `~/.codex/AGENTS.md`. Claude Code users can add the same pointer to `CLAUDE.md`.

`install.sh` prints this reminder; it does **not** modify global `AGENTS.md`/`CLAUDE.md` files for
you (those are yours to own).

## Uninstall

```sh
./install.sh --uninstall   # removes the symlinks / derived files; never touches your WISHLIST/ROADMAP
```

## Updating

`git pull` then `./install.sh`. The Claude skills are symlinks (live-updated by the pull); the
Codex/OpenCode derived files are regenerated by the install run.
