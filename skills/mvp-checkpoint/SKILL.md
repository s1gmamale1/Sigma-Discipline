---
name: mvp-checkpoint
description: Use when finishing an implementation task, assessing MVP readiness or delivery efficiency, or approaching a 20 percent project milestone.
---

# MVP checkpoints

A task checkpoint answers “Did this change deliver the intended outcome?” A milestone answers “Does the whole product still support the promised user journeys?” The coordinator owns both decisions, including work completed by another agent.

**Establish the baseline.** Read the product vision, agreed release scope, acceptance rubric, latest verified score and last milestone reviewed. Use this project’s denominator, weights, journeys and supported channels. Keep them fixed across checkpoints. If the accepted-journey count is unavailable, label it unknown. If there is no agreed rubric, report completed outcomes and gaps, and establish the rubric with the owner before assigning percentages. Keep the scorecard and the headline in the delivery docs in sync.

| Trigger | Decision after review |
|---|---|
| A task finishes or fails below the next milestone | Report once. Continue the authorized plan after a pass. Repair a failure and recheck affected paths before dependent work proceeds. |
| The verified score reaches or crosses 20%, 40%, 60%, 80% or 100% | Stop at the first safe boundary. Combine the task and milestone reports. Wait for explicit owner resume. |
| The owner requests a pause earlier | Stop, preserve evidence and hand off at the actual score. |

## After every task

1. Pause dependent work. Compare actual behavior with the documented actor, action and observable outcome. Look for missing channels, regressions, scope creep and stale documentation. Fix an implementation mismatch. If the plan is stale, record the reason and correction. Escalate a change to the promised scope or acceptance bar to the owner.
2. Check the changed build through the relevant entry point and failure path. Link the build or source revision and evidence. Keep failed attempts visible. Reuse valid checks against unchanged inputs and rerun affected checks. Attribute results from separate runs accurately.
3. Preserve diagnostics, stop task-owned compute, verify it stopped and release claims. Protect shared infrastructure, user data and unfinished work. With limited tool access, identify the owner and the outstanding verification.
4. Update the canonical scorecard. Award only rubric-backed points and count fully accepted journeys separately. Record zero movement when appropriate. Compare the unrounded score with the next threshold before dispatch.

**Send one concise update:** outcome and verdict → requirement and evidence → drift, correction or gap → cleanup → previous and current score, accepted journeys and next action. Combine worker handoffs in this report.

## At a milestone

Stop implementation and design workers. Cancel queued launches, retries and monitors. Verify actual shutdown and cleanup. Review the release scope across server, clients, access boundaries, integrations, documentation and vision. Trace required journeys through their supported channels. Reconcile current docs to the evidence, identify the largest remaining gap and recommend the next deliverable. Report unresolved checks and stay paused. At 100%, check every required journey and the release definition before declaring completion. A checkpoint grants no publication authority.

**Efficiency:** report which review caught a defect or changed a decision, what reran, and where delivery waited. Use measured time or cost when available. Keep estimates labeled. Omit invented savings.

**Example:** A payment form passes Web checks at 38/100. The rubric awards its next three points after staff record a payment and the student reads the persisted result on Web and phone. Report 38/100 while phone evidence is pending. Once that journey passes, record 41/100 and perform the 40% stop before starting another feature.
