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

## Checkpoints

| Skill | Trigger | Decision |
|---|---|---|
| [checkpoints](skills/checkpoints/SKILL.md) | An implementation task finishes or fails | Verify the changed behavior against its requirement, clean up its resources and accept, repair or block the task. |
| [project-checkpoints](skills/project-checkpoints/SKILL.md) | Overall readiness reaches a milestone, or the owner calls a project review | Stop project work, clean up across the project, review journeys and vision, report readiness and wait for explicit resume. |

Install from a persistent checkout. Choose the targets you use.

```sh
./install.sh checkpoints --claude --codex
./install.sh project-checkpoints --grok --hermes
# Both skills on all four local agents (also migrates the old combined link)
./install.sh checkpoint --claude --codex --grok --hermes
```

Add `--uninstall` to remove the selected links. The bundle command retires a legacy `mvp-checkpoint` link owned by this checkout. Installations from other checkouts stay with their original owner.

| Agent | Skill directory | Invocation in a fresh session |
|---|---|---|
| Codex | `~/.agents/skills` | `$checkpoints` or `$project-checkpoints` |
| Claude Code | `~/.claude/skills` | `/checkpoints` or `/project-checkpoints` |
| Grok Build | `~/.grok/skills` | Ask for either skill by name |
| Hermes Agent | `~/.hermes/skills` | `/checkpoints` or `/project-checkpoints` |

The installer respects `CLAUDE_CONFIG_DIR`, `GROK_HOME` and `HERMES_HOME`. [Grok Build discovery](https://docs.x.ai/build/features/skills-plugins-marketplaces) · [Hermes skills](https://hermes-agent.nousresearch.com/docs/guides/work-with-skills)

**Grok Bot** uses private skills. Attach each linked SKILL.md separately and ask the Bot to save its instructions under its frontmatter name. Enable the two entries in **Connect apps → Private skills** and invoke either by name. Refresh those copies after updates. [Grok Bot skills](https://docs.x.ai/grok-bot/skills-routines-and-automations)

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
