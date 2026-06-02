---
name: wishlist
description: Use when capturing, parking, or triaging an idea, deferral, nice-to-have, observed-but-unscheduled bug, or review/audit finding that is NOT being built right now — "add to the wishlist", "park this for later", "note this down", "remember we want X", "someday", or recording deep-review findings. Maintains WISHLIST.md at the repo root (creates it if missing). For sequenced, phased "what we build next" work use the roadmap skill instead.
---

# Wishlist — the project capture inbox

## Overview

`WISHLIST.md` (repo root) is the **low-ceremony capture inbox** for anything worth remembering but not currently scheduled: consciously-deferred choices, future enhancements, raw untriaged ideas, and bugs/optimizations spotted out-of-scope. Its one job is **lossless capture** — nothing good gets forgotten. Sequenced, committed work lives in `ROADMAP.md` (see the **roadmap** skill); the wishlist stays a parking lot.

**Core rule: append, never rewrite.** Add items; don't restructure or delete other people's entries. When an item gets scoped into a phase it is **promoted** to the roadmap and marked promoted here (struck through, not deleted — kept as history).

## When to use

- "Add to wishlist", "park this", "note for later", "don't forget X", "someday".
- You find a bug / smell / optimization that is out of scope for the current task.
- A capability is consciously deferred ("not now, by design").
- Recording the index of a review/audit (the full phased plan goes to ROADMAP; the cited index lands here).

**Do NOT use for:** work being built now (just do it), or scoped/sequenced multi-step plans → that's the **roadmap** skill.

## If WISHLIST.md does not exist — create it

Scaffold at the repo root with this skeleton, then add the item:

```markdown
# <Project> — Wishlist

> **Capture inbox for future / nice-to-have / explicitly-deferred items.** Low ceremony.
> Promote an item into [ROADMAP.md](ROADMAP.md) when it gets scoped into a phase.
>
> Buckets: **Deferred by design** (consciously out of scope) and **Future enhancements**
> (planned-later upgrades). **New ideas** is the untriaged inbox.

---

## 🚫 Deferred by design (out of scope for now)

_(consciously NOT built — each is a separate track or a non-goal, not a gap)_

---

## ✨ Future enhancements (planned-later upgrades)

_(real upgrades to build once the current system is production-grade)_

---

## 🆕 New ideas (untriaged)

_(raw ideas land here; promote to ROADMAP.md once scoped into a phase)_
```

(Replace `<Project>` with the repo's name.)

## How to fill it out

One idea = one bullet, under the right bucket.

- **🚫 Deferred by design** — deliberately not built (non-goals, separate tracks). State *what* and *why it's deferred*.
- **✨ Future enhancements** — upgrades for later. State *what*, *why it helps*, and the trigger ("build when …").
- **🆕 New ideas** — raw, untriaged. Drop it here; sort into a bucket later.
- **🔬 Review findings** — when recording an audit, add a dated `## 🔬 Deep review findings (YYYY-MM-DD)` section with sub-lists (Confirmed bugs / Optimizations / Features), each item **`file:line`-cited**, and link the full plan in ROADMAP.md.

### Item template

```markdown
- **[<area>] <one-line what>** — <why it matters / what it unlocks>.
  <For code: `path/to/file.ext:line` + the concrete fix.>
  <For bugs: severity [low|medium|high|critical] + effort [S|M|L|XL].>
  <For enhancements: the trigger — "build when <condition>".>
```

Examples:
```markdown
- **[deploy] one-command worker join** — non-experts can add a host without the runbook. Build when onboarding the 2nd host.
- 🐞 **[high] missing input gate lets a stale job churn forever** — `src/worker.py:195-212`; fix: add the guard clause. Effort: S.
```

## Why fill it out

- **Nothing is lost.** Ideas surface mid-task and vanish unless captured the moment they appear.
- **Keeps ROADMAP clean.** ROADMAP holds only scoped, sequenced, committed work; everything speculative parks here first.
- **Triage is cheap later.** A dated, bucketed, `file:line`-cited inbox becomes a roadmap phase in minutes.

## Promoting an item to the roadmap

When an item gets scoped into a phase: invoke the **roadmap** skill to add the phase, then mark the wishlist item promoted (keep it, don't delete):

```markdown
- ~~**[deploy] one-command worker join**~~ → **promoted to ROADMAP Phase 10** (YYYY-MM-DD).
```

## Quick reference

| Situation | Bucket |
|---|---|
| Deliberately not building it | 🚫 Deferred by design |
| Want it eventually, known trigger | ✨ Future enhancements |
| Raw idea, not yet triaged | 🆕 New ideas |
| Bug/optimization found out-of-scope | 🔬 Review findings (`file:line` + sev/effort) |
| Now scoped into a phase | Promote → ROADMAP, mark promoted here |

## Common mistakes

- **Rewriting the file.** Append only; never restructure or drop existing entries.
- **Deleting promoted items.** Strike-through + "promoted to ROADMAP Phase N" — keep the history.
- **Vague bullets.** Always include the *why*; for code, the *`file:line`* and the *fix*.
- **Putting sequenced plans here.** Multi-step ordered work belongs in ROADMAP — use the roadmap skill.
- **Editing while another session/instance has the file staged.** If a parallel session is mid-edit, wait.
