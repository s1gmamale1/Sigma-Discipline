---
name: roadmap
description: Use when planning, sequencing, or recording what to build next as ordered phases — "make/update the roadmap", "add a phase", "sequence this work", "what do we build next", promoting a scoped wishlist item, or recording an architecture decision (ADR). Maintains ROADMAP.md at the repo root (creates it if missing). For unscheduled idea capture use the wishlist skill instead.
---

# Roadmap — the single source of truth for what to build next

## Overview

`ROADMAP.md` (repo root) is the **authoritative, priority-ordered plan** of what gets built next, expressed as **phases**. Unlike `WISHLIST.md` (a parking lot — see the **wishlist** skill), the roadmap holds only **scoped, sequenced, committed-to** work: every phase is actionable, names concrete deliverables, and has a testable definition of done.

**Core rule: every phase follows the same 7-part block, in the same order.** That consistency is what makes the doc scannable and executable. Phases are ordered by **value/effort**, with prerequisites called out.

## When to use

- "Make a roadmap", "update the roadmap", "add a phase for X", "sequence this".
- Promoting a scoped item out of WISHLIST into committed work.
- Recording an **architecture decision** (add/append an ADR).
- After a review/audit that produced a phased plan.

**Do NOT use for:** raw idea capture or deferrals → that's the **wishlist** skill. Don't put speculative, unscoped wishes here.

## If ROADMAP.md does not exist — create it

Scaffold at the repo root (intro → how-to-read → optional bug hotlist → phases → ADRs → effort/impact table), then add the phase(s):

```markdown
# <Project> — Roadmap

<2-3 sentences: what the system is + its current built state. Name the detailed source of truth, if any.>

This ROADMAP is the single source of truth for what to build next.

---

## How to read this

- **Phases are ordered by value/effort**, with cross-phase prerequisites called out.
- **Effort** is S (≤½ day), M (1–2 days), L (3–5 days), XL (>1 week).
- Confirmed bugs (if any) are fixed before new feature phases.

---

## Confirmed bugs to fix first (hotlist)   ← optional; include only if a review found real bugs

| # | Sev | Bug | Where (file:line) | Effort |
|---|-----|-----|-------------------|--------|

---

## Phase N — <name>

<the 7-part block — see template below>

---

## Architecture decisions (ADRs)

### ADR-001 — <decision title>
**Decision.** … **Context.** … **Consequences.** (+/−) …

---

## Effort / impact table

| Item | Phase | Effort | Impact | Notes |
|------|-------|--------|--------|-------|
```

(Replace `<Project>` with the repo's name.)

## The phase template (use for EVERY phase, in this order)

```markdown
## Phase N — <short imperative name>

**Goal.** <one sentence: the outcome, not the activity.>

**Deliverables.**
- <named artifact 1 — file/endpoint/script/migration the phase produces>
- <named artifact 2 …>   ← concrete, checkable nouns; this is the scannable "what you get"

**Why now.** <why this phase, this slot — the pain it removes or the thing it unblocks.>

**Scope.** <ordered, concrete tasks with file:line pointers; the how.>
- <task 1 …>
- <task 2 …>

**Findings + recommendation.** <evidence / research that backs the approach + the chosen path.>

**Risks.** <what could go wrong + the mitigation.>

**Definition of done.** <observable, testable acceptance — "an operator can …", "X passes", "curl Y returns Z".>
```

**All 7 headings, every phase, in that order:** `Goal → Deliverables → Why now → Scope → Findings + recommendation → Risks → Definition of done`. A reader skims **Goal + Deliverables + Definition of done** to know what a phase produces and when it's finished.

## How to fill each part

- **Goal** — the *outcome* in one line ("any job survives a node disk loss"), never the activity ("work on storage").
- **Deliverables** — concrete named nouns you can tick off (a script, an endpoint, a migration, a CI workflow). This is the at-a-glance contract; keep it a bullet list.
- **Why now** — the pain removed or thing unblocked; justifies the priority slot.
- **Scope** — the ordered work with `file:line` pointers so an engineer with zero context can start.
- **Findings + recommendation** — the evidence (code facts, research, tradeoffs) and the decision.
- **Risks** — failure modes + mitigations (don't omit; "none" is rarely true).
- **Definition of done** — testable acceptance. If you can't write it, the phase isn't scoped yet — it belongs in WISHLIST.

## Sequencing (priority order)

1. **Confirmed bugs first** — a hotlist table before any feature phase; cheap relative to blast radius.
2. **Phases ordered by value/effort** — highest value / lowest effort earlier; flag the foundational phase ("do first").
3. **Call out prerequisites** explicitly ("Phase 13 requires the lease-refresh from Phase 11").
4. **Close with an effort/impact table** (S/M/L/XL × Low/Medium/High) so the whole plan is machine-scannable.

## Recording an architecture decision (ADR)

When a phase encodes a "we chose A over B" verdict, append an ADR — **Decision / Context / Consequences (+ and −)** — and reference it from the phase. ADRs are the durable record; the phase is the build.

## Why fill it out

- **One source of truth** for what's next — no re-deciding mid-stream.
- **Executable by anyone** — named deliverables + `file:line` scope + a testable DoD let an engineer (or a fresh agent) pick up a phase cold.
- **Honest priority** — value/effort ordering + the effort/impact table make tradeoffs explicit instead of vibes.

## Quick reference

| Need | Do |
|---|---|
| New committed work | Add a `## Phase N` with all 7 parts |
| Promote a wishlist item | Add the phase here; mark it **promoted** in WISHLIST |
| Found real bugs in a review | Add/extend the hotlist table (`file:line` + sev + effort) |
| "We chose A over B" | Append an ADR (Decision/Context/Consequences) |
| Re-prioritize | Reorder phases by value/effort; update the effort/impact table |

## Common mistakes

- **Skipping a part of the 7-part block.** Every phase has all seven, in order — especially **Deliverables** and **Definition of done**.
- **Vague deliverables.** "Improve deploy" ✗ → named scripts/files ✓.
- **A goal that's an activity.** "Work on observability" ✗ → "a 3am failure fires an alert automatically" ✓.
- **No `file:line` in Scope.** Pointers are what let someone start cold.
- **Putting unscoped wishes here.** If it has no DoD yet, it belongs in WISHLIST.
- **Forgetting the effort/impact table** at the end — it's the priority at-a-glance.
- **Editing while a parallel session/instance has the file staged.** Wait if another session is mid-edit.
