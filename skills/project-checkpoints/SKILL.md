---
name: project-checkpoints
description: Use when verified project readiness reaches a major milestone, an owner requests a whole-project review, or work resumes after a milestone hold.
---

# Review the whole project

**Decision:** Is the product still on course, what evidence supports its readiness, and what should the owner authorize next?

**Trigger.** Read the agreed release scope, fixed weights, latest verified score and last reviewed milestone. Default gates are 20%, 40%, 60%, 80% and 100% of total maturity. Compare the unrounded score to the next threshold. A jump from 39 to 42 triggers the 40% review at 42. If a worker claims new points, verify the rubric first. If no rubric exists, report observed outcomes and gaps and establish a baseline with the owner before assigning a percentage.

1. **Stop at the safe boundary.** Hold new dispatch. Stop implementation and design workers, including pending launches, retries, monitors and scheduled jobs for this project. Preserve handoffs and failed evidence. Confirm actual stopped state. If you lack access, name the owner and mark shutdown unverified.
2. **Clean across the project.** Inventory temporary builds, listeners, test databases, containers, queues and stale claims. Remove verified disposable project outputs and stop owned compute. Preserve user data, unfinished branches and recovery evidence. Record what was removed, what was retained and why. Flag resources of uncertain ownership for review.
3. **Assess delivery against the vision.** Walk the agreed user journeys across relevant services and clients. Check access boundaries, integrations, regressions, recovery, documentation and remaining release gaps. Reuse evidence tied to current inputs. Run focused regressions where that evidence is stale or missing.
4. **Reconcile and report.** Update the canonical scorecard and current status headline. Report previous and actual points with denominator, milestone crossed, fully accepted journeys separately, significant drift, verified cleanup, unresolved risks and the next recommended outcome. Explain which review changed a decision, what reran and where work waited. Quantify time or cost only when measured.
5. **Hold for explicit owner resume.** Sending the report does not restart work. On resume, check the handoff for changes and continue the authorized plan. At 100%, verify each required journey and the release criteria. Publication requires its own authority.

**Example:** Backend tests bring an estimate to 42%, but the rubric requires student readback on a phone. Keep the verified 39% and identify the missing proof. When phone evidence earns the points, freeze the queue and report the 40% gate at 42%.
