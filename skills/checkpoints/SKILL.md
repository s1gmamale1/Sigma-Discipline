---
name: checkpoints
description: Use when an implementation task, fix or worker handoff has just finished or failed and its outcome needs review before dependent work continues.
---

# Check the completed task

**Decision:** Accept the task, repair it, or record the specific blocker. Pause dependent work while making this decision. Other authorized work can continue.

1. **Compare intent and result.** Find the task's acceptance condition in the plan or product docs. Identify who should be able to do what. Check the changed behavior at its normal entry point, including the relevant failure case and affected callers. If the requirement is a user journey, verify the promised channels before accepting it.
2. **Resolve drift.** Fix behavior that misses the agreed outcome. Correct stale instructions when evidence supports the intended behavior. Surface a proposed scope change to the owner before changing the acceptance bar.
3. **Close the task.** Keep the source/build identifier, results and failed-run diagnostics. Rerun affected checks and reuse valid evidence for unchanged inputs. Stop the scratch processes or databases allocated to this task and verify their exit. Report shared resources under their existing owner. If nothing was allocated, say so.
4. **Report once.** Give the verdict, requirement, evidence, drift or correction, cleanup result and next action. For a blocked check, distinguish what passed from what still needs proof. Continue authorized work after a pass. On failure, fix and recheck before dependent work proceeds.

If the project tracks readiness, pass along the evidence-earned score change, including zero. If it crosses an agreed milestone, hold new dispatch and hand the result to **project-checkpoints**. The milestone report can include this task's verdict.

**Example:** An invoice displayed the wrong rounded total. The receipt now matches the ledger on both half-cent boundary cases. Link the test result and revision, verify the task database stopped, and resume the next approved task. An unrelated team's demo database stays with its owner.
