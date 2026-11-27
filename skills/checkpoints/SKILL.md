---
name: checkpoints
description: Use when an implementation task, fix or worker handoff has just finished or failed and its outcome needs review before dependent work continues.
---

# Check the completed task

**Decision:** Accept the task, repair it, or record the specific blocker. Pause dependent work while making this decision. Other authorized work can continue.

1. **Compare intent and result.** Find the task's acceptance condition in the plan or product docs. Identify who should be able to do what. Check the changed behavior at its normal entry point, including the relevant failure case and affected callers. If the requirement is a user journey, verify the promised channels before accepting it.
2. **Resolve drift.** Fix behavior that misses the agreed outcome. Correct stale instructions when evidence supports the intended behavior. Surface a proposed scope change to the owner before changing the acceptance bar.
3. **Close the task.** Keep the source/build identifier, results and failed-run diagnostics. Rerun affected checks and reuse valid evidence for unchanged inputs. Stop task-owned compute, verify its exit, then release its compute claims. Report shared resources under their existing owner. If nothing was allocated, say so.
4. **Record readiness before the next dispatch.** If the project tracks readiness, read the canonical scorecard and recompute the affected rubric criteria from verified evidence. Replace each criterion’s prior value so replaying the same evidence earns zero. Save the previous and current unrounded scores, fixed denominator, change (including zero), evidence references and last reviewed threshold in the scorecard. If the current score reaches or exceeds the next unreviewed threshold, hold dispatch and invoke **project-checkpoints**.
5. **Report once.** Give the verdict, requirement, evidence, drift or correction, cleanup result and next action. The milestone report can include this verdict. For a blocked check, distinguish what passed from what still needs proof. After a pass, continue authorized work if the gate is clear. On failure, fix and recheck before dependent work proceeds.

**Example:** An invoice displayed the wrong rounded total. The receipt now matches the ledger on both half-cent boundary cases. Link the test result and revision, verify the task database stopped, and resume the next approved task. An unrelated team's demo database stays with its owner.
