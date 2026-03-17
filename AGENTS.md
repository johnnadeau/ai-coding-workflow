# Multi-Agent Coding System

This repository uses a multi-agent system to automate software development tasks with human-like collaboration patterns.

## Agent Workflow

All work follows a strict pipeline:

1. **Orchestrator** plans the task and delegates work
2. **Researcher** explores the codebase for context
3. **Implementer** makes minimal, focused code changes
4. **Tester** validates changes with available tooling
5. **Reviewer** analyzes diffs for correctness and safety

## Workflow Rules

Agents MUST follow these strict rules:

- **Always inspect before editing** - Never modify files without first understanding context
- **Minimal diffs only** - Make the smallest change that solves the problem
- **No unrelated refactors** - Stay focused on the specific task
- **Test/validate before completion** - Run available validation tools
- **Stop if blocked** - Halt when unclear rather than guess

## Task Execution

Tasks are executed in isolated branches to prevent conflicts:

1. Each task runs in its own git branch named `oc-task/{task-name}`
2. Changes are committed only if they pass validation
3. A PR-ready summary is generated for human review

## PR Summaries

All completed tasks generate a summary file containing:

- Task description and approach
- Files changed with rationale
- Validation results
- Risk assessment

## Code Quality & Safety

Agents prioritize:

- **Correctness** over cleverness
- **Readability** over brevity
- **Safety** over speed
- **Transparency** over automation

Any uncertain situation requires human intervention.