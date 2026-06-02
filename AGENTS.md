# Sigma-Discipline — planning rules for agents

This project keeps two planning documents at its root. Maintain them as you work. Codex and
OpenCode load this file automatically; Claude Code users: mirror this into `CLAUDE.md`.

## The two documents

- **`WISHLIST.md`** — the capture inbox. Anything worth remembering but **not** being built right
  now: deferrals, future enhancements, raw ideas, and bugs/optimizations found out of scope.
- **`ROADMAP.md`** — the priority-ordered plan of what to build next, as **phases**. Only scoped,
  sequenced, committed work with named deliverables and a testable definition of done.

Full detail lives in the `/wishlist` and `/roadmap` commands (this repo's `skills/*/SKILL.md`).

## When to use which

| Situation | Action |
|---|---|
| Idea / deferral / "someday" / out-of-scope bug spotted | **WISHLIST** — append a bullet under the right bucket |
| Recording a review/audit index | **WISHLIST** — dated `## 🔬 Deep review findings (YYYY-MM-DD)`, `file:line`-cited |
| Scoped, sequenced "what we build next" | **ROADMAP** — add a `## Phase N` with the full 7-part block |
| A wishlist item just got scoped | Promote: add the ROADMAP phase, mark the wishlist item promoted (strike-through, don't delete) |
| "We chose A over B" | **ROADMAP** — append an ADR (Decision / Context / Consequences) |
| Work you're doing **right now** | Just do it — neither doc |

## Core rules

**WISHLIST**
- **Append, never rewrite.** Add items; don't restructure or delete others' entries.
- One idea = one bullet, with the *why*. For code: `file:line` + the concrete fix; for bugs: severity + effort.
- Promote (don't delete) when scoped: `~~item~~ → promoted to ROADMAP Phase N (date)`.
- Create `WISHLIST.md` from the scaffold (see `/wishlist`) if it doesn't exist.

**ROADMAP**
- **Every phase uses the same 7-part block, in order:** `Goal → Deliverables → Why now → Scope → Findings + recommendation → Risks → Definition of done`.
- **Goal** is an outcome, not an activity. **Deliverables** are concrete named nouns. **Scope** carries `file:line` pointers. **Definition of done** is observable/testable — if you can't write one, it's not scoped yet → it belongs in WISHLIST.
- **Bugs first:** a hotlist table before feature phases. Order phases by value/effort; call out prerequisites. Close with an effort/impact table.
- Create `ROADMAP.md` from the scaffold (see `/roadmap`) if it doesn't exist.

## Guardrail

If a parallel session/instance has `WISHLIST.md` or `ROADMAP.md` staged mid-edit, wait — don't clobber it.
