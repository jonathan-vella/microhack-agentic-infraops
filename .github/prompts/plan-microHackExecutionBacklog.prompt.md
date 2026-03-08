# Plan: MicroHack Execution Backlog

Convert the approved review into a delivery backlog that starts with workshop safety and operational resilience, then fixes participant flow and content continuity, then finishes with UX polish and governance. The core principle is sequencing by execution risk: if the event can fail in real time, that work comes before information architecture cleanup or terminology polish.

**Steps**

1. Phase 0: Close operational gaps that can derail or expose a live workshop. This includes permissions clarity, shared-subscription safety, policy propagation verification, cleanup ownership, and secret-handling guidance.
2. Phase 0: Make Challenge 3 to Challenge 4 resilient so the DR curveball still works when a team fails to deploy cleanly.
3. Phase 0: Turn facilitator guidance into a deterministic event runbook for common failures, timing drift, and post-event responsibilities.
4. Phase 1: Rebuild participant onboarding around a clear readiness gate and journey-based entry points.
5. Phase 1: Standardize challenge continuity, page structure, and troubleshooting decision paths.
6. Phase 2: Improve scannability, mobile/print usability, and top-level routing.
7. Phase 3: Lock in terminology, sensitive-content review rules, and maintenance ownership.

**Execution backlog**

## Epic A: Operational safety and workshop resilience

1. Issue: Clarify Azure access model and enforce one-subscription-per-team

- Objective: Define the minimum Azure roles, when Owner is actually required, and state that one subscription per team is the only supported scenario.
- Decision: One subscription per team is the only supported model. Shared subscriptions are not supported. Remove or replace any guidance that implies subscription sharing is acceptable.
- Expected impact: Eliminates RBAC confusion, naming collisions, and accidental cross-team interference.
- Effort: Medium
- Dependencies: None
- Recommended owner type: Security
- Primary files: /workspaces/microhack-agentic-infraops/docs/getting-started/setup.md, /workspaces/microhack-agentic-infraops/facilitator/facilitator-guide.md, /workspaces/microhack-agentic-infraops/docs/reference/governance-scripts.md
- Acceptance criteria: Setup explains role requirements in plain language; all docs state one subscription per team as the only supported model; any shared-subscription language is removed or replaced with an explicit prohibition.

2. Issue: Add policy propagation and verification guidance

- Objective: Make Azure Policy timing explicit and require a verification step before teams rely on policy behavior.
- Expected impact: Reduces surprise policy denials and facilitator guesswork.
- Effort: Low
- Dependencies: Issue A1
- Recommended owner type: Mixed
- Primary files: /workspaces/microhack-agentic-infraops/facilitator/facilitator-guide.md, /workspaces/microhack-agentic-infraops/docs/challenges/challenge-3-implementation.md, /workspaces/microhack-agentic-infraops/scripts/Get-GovernanceStatus.ps1, /workspaces/microhack-agentic-infraops/scripts/Setup-GovernancePolicies.ps1
- Acceptance criteria: Facilitator docs include when to deploy policies, how to verify activation, and what to do if policies are not yet active.

3. Issue: Define cleanup ownership and post-event verification

- Objective: Move cleanup from reminder language to an owned operational task with a deadline and verification step.
- Decision: The team lead is the cleanup owner. Each team lead is responsible for deleting their team's resources and confirming cleanup before leaving.
- Expected impact: Reduces lingering cost and exposure after the event.
- Effort: Low
- Dependencies: None
- Recommended owner type: Facilitator
- Primary files: /workspaces/microhack-agentic-infraops/docs/getting-started/setup.md, /workspaces/microhack-agentic-infraops/docs/guides/quick-reference-card.md, /workspaces/microhack-agentic-infraops/facilitator/facilitator-guide.md, /workspaces/microhack-agentic-infraops/scripts/Remove-GovernancePolicies.ps1
- Acceptance criteria: Team lead is named as cleanup owner; timing is specified; both resources and policies are covered; verification is described.

4. Issue: Add participant secret-handling guidance

- Objective: Prevent participants from putting secrets into prompts, outputs, or committed artifacts.
- Expected impact: Reduces accidental leakage through AI-assisted workflows.
- Effort: Low
- Dependencies: None
- Recommended owner type: Security
- Primary files: /workspaces/microhack-agentic-infraops/docs/getting-started/setup.md, /workspaces/microhack-agentic-infraops/docs/guides/copilot-guide.md, /workspaces/microhack-agentic-infraops/docs/reference/troubleshooting.md
- Acceptance criteria: Participant-facing guidance explicitly says what not to paste into chat, what not to commit, and how to handle placeholders safely.

## Epic B: Challenge continuity and recovery

5. Issue: Define Challenge 3 to Challenge 4 fallback rules

- Objective: Preserve the DR learning objective even when a team’s initial deployment fails.
- Decision: Teams that fail deployment pivot to a modified paper exercise for Challenge 4. They design the DR architecture on paper (ADR + diagram) without deploying, preserving the learning objective. No pre-built reference deployment is provided.
- Expected impact: Prevents the workshop's highest-value transition from collapsing under time pressure.
- Effort: Medium
- Dependencies: Issue A1
- Recommended owner type: Facilitator
- Primary files: /workspaces/microhack-agentic-infraops/docs/challenges/challenge-3-implementation.md, /workspaces/microhack-agentic-infraops/docs/challenges/challenge-4-dr-curveball.md, /workspaces/microhack-agentic-infraops/facilitator/facilitator-guide.md, /workspaces/microhack-agentic-infraops/facilitator/solution-reference.md
- Acceptance criteria: Docs state what teams do if deployment succeeded, partially succeeded, or failed; failed-deployment teams have a clear paper-exercise path; facilitators have deterministic fallback rules; scoring rubric accounts for the paper-exercise variant.

6. Issue: Align Challenge 3 and 4 scoring language with actual recovery paths

- Objective: Remove ambiguity between required deployment outcomes, partial credit, and reference-solution fallback usage.
- Expected impact: Makes scoring fairer and easier to apply during live recovery situations.
- Effort: Medium
- Dependencies: Issue B5
- Recommended owner type: Facilitator
- Primary files: /workspaces/microhack-agentic-infraops/facilitator/scoring-rubric.md, /workspaces/microhack-agentic-infraops/docs/challenges/challenge-3-implementation.md, /workspaces/microhack-agentic-infraops/docs/challenges/challenge-4-dr-curveball.md
- Acceptance criteria: Challenge docs and rubric no longer conflict on what counts as success, deployment, and DR completion.

7. Issue: Make artifact handoffs explicit across the challenge sequence

- Objective: Show exactly what output from one challenge feeds the next, using stable file paths and next-step prompts.
- Expected impact: Reduces context loss and repeated facilitator intervention.
- Effort: Medium
- Dependencies: Issue B5
- Recommended owner type: Content
- Primary files: /workspaces/microhack-agentic-infraops/docs/challenges/challenge-1-requirements.md, /workspaces/microhack-agentic-infraops/docs/challenges/challenge-2-architecture.md, /workspaces/microhack-agentic-infraops/docs/challenges/challenge-3-implementation.md, /workspaces/microhack-agentic-infraops/docs/challenges/challenge-4-dr-curveball.md, /workspaces/microhack-agentic-infraops/docs/guides/copilot-guide.md, /workspaces/microhack-agentic-infraops/docs/guides/quick-reference-card.md
- Acceptance criteria: Every challenge after Challenge 1 names its upstream input artifact, its own output artifact, and the next action.

## Epic C: Facilitator operations

8. Issue: Convert facilitator guide into an incident-aware event runbook

- Objective: Add explicit handling for policy delays, Copilot access problems, quota failures, deployment failures, and timing compression.
- Expected impact: Reduces facilitator improvisation and makes multi-facilitator delivery more consistent.
- Effort: High
- Dependencies: Issues A2, A3, B5
- Recommended owner type: Facilitator
- Primary files: /workspaces/microhack-agentic-infraops/facilitator/facilitator-guide.md
- Acceptance criteria: Facilitators can identify the failure class, see the next action, and know whether to unblock, compress, skip, or fall back.

9. Issue: Add a facilitator readiness and go/no-go checklist

- Objective: Give facilitators a pre-event, day-of, and wrap-up checklist that matches the actual repo and workshop constraints.
- Expected impact: Improves reliability before the first participant even starts.
- Effort: Low
- Dependencies: Issues A1, A2, A3
- Recommended owner type: Facilitator
- Primary files: /workspaces/microhack-agentic-infraops/facilitator/facilitator-guide.md
- Acceptance criteria: A facilitator can confirm licensing, Azure access, policies, quotas, room setup, and cleanup responsibilities from one concise section.

10. Issue: Fix scoring workflow expectations

- Objective: Reconcile claims of automated scoring with the current manual review process.
- Expected impact: Prevents operator confusion and under-prepared scoring at the end of the event.
- Effort: Low
- Dependencies: Issue B6
- Recommended owner type: Facilitator
- Primary files: /workspaces/microhack-agentic-infraops/facilitator/scoring-rubric.md, /workspaces/microhack-agentic-infraops/facilitator/facilitator-guide.md, /workspaces/microhack-agentic-infraops/docs/guides/quick-reference-card.md
- Acceptance criteria: Scoring language accurately reflects what is manual, what can be mechanically checked, and what is optional tooling.

## Epic D: Participant onboarding and journey architecture

11. Issue: Add a participant readiness gate

- Objective: Create a short go/no-go path for Copilot tier, Azure auth, quotas, Dev Container health, and repo/template correctness.
- Expected impact: Cuts event-day setup failures and wrong-repo starts.
- Effort: Medium
- Dependencies: Issues A1, A2
- Recommended owner type: Content
- Primary files: /workspaces/microhack-agentic-infraops/docs/getting-started/setup.md, /workspaces/microhack-agentic-infraops/README.md
- Acceptance criteria: A participant can validate readiness in a few minutes and knows what blocks participation versus what is optional.

12. Issue: Restructure getting-started content by user journey

- Objective: Separate before-event prep, first 10 minutes, workshop prep, and troubleshooting entry points.
- Expected impact: Makes the site easier to use under time pressure and for different entry intents.
- Effort: Medium
- Dependencies: Issue D11
- Recommended owner type: Content
- Primary files: /workspaces/microhack-agentic-infraops/docs/index.md, /workspaces/microhack-agentic-infraops/docs/getting-started/index.md, /workspaces/microhack-agentic-infraops/docs/getting-started/setup.md, /workspaces/microhack-agentic-infraops/docs/getting-started/workshop-prep.md
- Acceptance criteria: The main participant journeys are visible from the home page and getting-started section without requiring deep reading.

13. Issue: Clarify template-repo versus source-repo usage

- Objective: Prevent users from starting from the wrong repository or misunderstanding where active work should happen.
- Expected impact: Reduces onboarding mistakes and support overhead.
- Effort: Low
- Dependencies: Issue D11
- Recommended owner type: Content
- Primary files: /workspaces/microhack-agentic-infraops/README.md, /workspaces/microhack-agentic-infraops/docs/getting-started/setup.md, /workspaces/microhack-agentic-infraops/docs/index.md
- Acceptance criteria: The difference between this repo and the working template repo is obvious at first contact.

## Epic E: Challenge UX and troubleshooting

14. Issue: Standardize challenge page template and time language

- Objective: Normalize duration, prerequisites, outputs, success criteria, escalation path, and next-step sections across all challenges.
- Expected impact: Improves scannability and pacing clarity.
- Effort: High
- Dependencies: Issue B7
- Recommended owner type: Content
- Primary files: /workspaces/microhack-agentic-infraops/docs/challenges/\*.md
- Acceptance criteria: All challenge pages use the same operational structure and no challenge header conflicts with the published schedule.

15. Issue: Rework troubleshooting into decision-based flows

- Objective: Separate policy, auth, quota, agent, Bicep, deployment, and load-test failures into distinct recovery paths.
- Expected impact: Speeds self-service and makes facilitator escalation cleaner.
- Effort: Medium
- Dependencies: Issues A1, A2, B5
- Recommended owner type: Mixed
- Primary files: /workspaces/microhack-agentic-infraops/docs/reference/troubleshooting.md, /workspaces/microhack-agentic-infraops/docs/guides/hints-and-tips.md
- Acceptance criteria: Users can identify their failure type and follow a short path to recovery or escalation.

16. Issue: Add policy-error and governance troubleshooting guidance

- Objective: Help users distinguish Azure Policy denials from quota, naming, and runtime deployment failures.
- Expected impact: Reduces one of the most likely high-friction failure modes in the workshop.
- Effort: Medium
- Dependencies: Issues A1, A2
- Recommended owner type: Security
- Primary files: /workspaces/microhack-agentic-infraops/docs/reference/troubleshooting.md, /workspaces/microhack-agentic-infraops/docs/reference/governance-scripts.md, /workspaces/microhack-agentic-infraops/docs/guides/hints-and-tips.md
- Acceptance criteria: Policy failures are called out by symptom, likely cause, and corrective action, with facilitator escalation guidance.

## Epic F: UX polish and usability

17. Issue: Improve page-level scannability and calls to action

- Objective: Add short summaries, checkpoints, and clearer CTA patterns to long pages.
- Expected impact: Reduces reading burden during the event.
- Effort: Medium
- Dependencies: Issues D12, E14
- Recommended owner type: Design
- Primary files: /workspaces/microhack-agentic-infraops/docs/index.md, /workspaces/microhack-agentic-infraops/docs/getting-started/setup.md, /workspaces/microhack-agentic-infraops/docs/challenges/_.md, /workspaces/microhack-agentic-infraops/docs/guides/_.md
- Acceptance criteria: Long pages expose the next action and completion state near the top and bottom of the page.

18. Issue: Rework quick-reference for mobile and print use

- Objective: Make the quick-reference content usable on narrow screens and as a practical handout.
- Expected impact: Improves in-room retrieval for participants and facilitators.
- Effort: Medium
- Dependencies: Issues B7, E14
- Recommended owner type: Design
- Primary files: /workspaces/microhack-agentic-infraops/docs/guides/quick-reference-card.md, /workspaces/microhack-agentic-infraops/docs/\_sass/custom/custom.scss
- Acceptance criteria: Quick-reference content does not rely on wide tables for essential actions and remains useful when printed.

19. Issue: Add text alternatives for dense diagrams and time visuals

- Objective: Ensure critical scheduling and architecture information is understandable without Mermaid rendering or wide screens.
- Expected impact: Improves accessibility and resilience of the docs site.
- Effort: Low
- Dependencies: Issue E14
- Recommended owner type: Design
- Primary files: /workspaces/microhack-agentic-infraops/docs/index.md, /workspaces/microhack-agentic-infraops/docs/challenges/challenge-8-partner-showcase.md, /workspaces/microhack-agentic-infraops/docs/guides/quick-reference-card.md
- Acceptance criteria: Every critical diagram has an equivalent text summary that preserves the operational meaning.

## Epic G: Terminology and governance

20. Issue: Publish canonical vocabulary and naming rules

- Objective: Standardize event, role, challenge, workflow, customer, and Azure product naming.
- Expected impact: Reduces ambiguity across participant and facilitator surfaces.
- Effort: Low
- Dependencies: Issues D12, E14
- Recommended owner type: Content
- Primary files: /workspaces/microhack-agentic-infraops/docs/reference/glossary.md, /workspaces/microhack-agentic-infraops/docs/index.md, /workspaces/microhack-agentic-infraops/docs/getting-started/_.md, /workspaces/microhack-agentic-infraops/facilitator/_.md
- Acceptance criteria: The agreed terms are documented once and applied consistently in the highest-traffic pages.

21. Issue: Add a sensitive-content review checklist

- Objective: Require explicit review for changes involving permissions, policies, costs, cleanup, and real Azure actions.
- Expected impact: Improves long-term safety and accuracy.
- Effort: Low
- Dependencies: Issue G20
- Recommended owner type: Security
- Primary files: /workspaces/microhack-agentic-infraops/README.md or repository contribution guidance location, /workspaces/microhack-agentic-infraops/scripts/_.ps1, /workspaces/microhack-agentic-infraops/docs/reference/_.md
- Acceptance criteria: Maintainers have a lightweight checklist to apply before merging sensitive guidance changes.

~~22. Issue: Define ownership model for docs, facilitator guidance, and scripts~~ — **Removed.** Not required per owner decision.

**Recommended sequencing**

1. Start with A1, A2, A3, B5, and C8.
2. Then complete B6, B7, C9, C10, and D11.
3. Then move to D12, D13, E14, E15, and E16.
4. Finish with F17, F18, F19, G20, and G21.

**Verification**

1. Run a tabletop review of a live event using the updated backlog order: wrong Copilot tier, late policy propagation, Challenge 3 deployment failure, and end-of-day cleanup.
2. Walk the participant path from repository landing to Challenge 1 and confirm there is no ambiguity about the correct repo, required access, or readiness state.
3. Walk the facilitator path from pre-event setup through wrap-up and confirm every common failure has a next action and owner.
4. Review challenge pages and the rubric together to ensure scoring, outputs, and timing are consistent.
5. Validate that terminology and Azure product naming remain consistent after structural updates are complete.

**Decisions**

- Prioritize operational risk over content polish.
- Treat shared-subscription guidance, policy timing, and cleanup as high-sensitivity content.
- Defer non-essential visual polish until the workshop can withstand common live-event failures.
- Apply terminology cleanup after the structural and operational model is stabilized.
- **Subscription model**: One subscription per team is the only supported scenario. Shared subscriptions are not supported.
- **Cleanup owner**: The team lead owns post-event resource and policy cleanup.
- **Challenge 3→4 fallback**: Teams that fail deployment pivot to a paper exercise (ADR + diagram, no deployment). No pre-built reference deployment is provided.
- **Ownership model (Issue 22)**: Not required. Removed from the backlog.
