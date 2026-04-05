# Operational Patterns Index

Generalizable patterns for any AI agent system.

## Workflows

### [worktree-isolation.yaml](workflows/worktree-isolation.yaml)
**Git Worktree Allocation for Parallel Development**
- Weight: 2.0 (High value)
- Status: Production
- Problem: Multiple agents/tasks cause branch conflicts
- Solution: Isolated worktree "seats" with allocation pool

### [pr-workflow.yaml](workflows/pr-workflow.yaml)
**Pull Request Creation and Management Protocol**
- 4-phase workflow: Implementation → PR Creation → Review Response → Merge
- Structured PR templates and commit message formats
- Safety rules for force push, auto-merge, task linking

### [task-protocol.yaml](workflows/task-protocol.yaml)
**Complete Task Execution Protocol**
- 5-phase checklist: Read → Determine State → Implement → Create PR → Move to Review
- Scenarios: Fresh TODO, Feedback/Rework, No-PR exception
- Zero-tolerance rules for status transitions

## Quality Gates

### [pre-implementation-verification.yaml](quality/pre-implementation-verification.yaml)
**Verify Task Needed Before Coding**
- ROI: 88x (measured across 100+ tasks)
- Time cost: 2-5 minutes
- Time saved: 2-8 hours per false-positive
- Hit rate: 19% of tasks already complete

### [evidence-chain-requirement.yaml](quality/evidence-chain-requirement.yaml)
**Zero-Tolerance Evidence Validation**
- Weight: 3.0 (FOUNDATIONAL)
- Principle: THE EVIDENCE IS THE WORK
- 6-link chain: Commits → Branch → PR → Comment → State → Files
- Prevents 52 documented catastrophic violations

## Deployment

### [three-tier-merge-engine.yaml](deployment/three-tier-merge-engine.yaml)
**Machine/Private/Public Knowledge Organization**
- Machine tier: Local paths, IPs, ports (never promoted)
- Private tier: Personal knowledge (sync across machines)
- Public tier: Shareable patterns (contribute upstream)
- On-demand loading based on task context

## Usage

These patterns are:
- **Anonymized**: No personal info, credentials, or machine-specific details
- **Generalizable**: Applicable to any AI agent system
- **Battle-tested**: Derived from real production incidents and successes
- **Measurable**: Include ROI, time costs, and behavioral validation

Any AI agent can adopt these patterns to improve:
- Development workflow efficiency
- Code quality and safety
- Task completion accuracy
- Knowledge organization

## Contributing

To add new patterns:
1. Ensure complete anonymization (no names, IPs, credentials)
2. Include measurable outcomes (ROI, time saved, error reduction)
3. Document anti-patterns and failure modes
4. Provide behavioral validation tests
