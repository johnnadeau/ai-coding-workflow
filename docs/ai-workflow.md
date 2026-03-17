# AI Workflow Documentation

This repository uses a multi-agent AI system to automate software development tasks with human-like collaboration patterns.

## What is this system?

The AI workflow system consists of multiple specialized agents that work together to:

1. Plan and research tasks
2. Implement focused code changes
3. Validate changes with testing
4. Review for correctness and safety
5. Generate PR-ready summaries

All work happens in isolated branches to prevent conflicts and maintain a clean working directory.

## How to run a single task

To run a single task:

```bash
./scripts/oc-task.sh "task-name" "Task description"
```

Example:
```bash
./scripts/oc-task.sh "add-health-endpoint" "Add a /health endpoint that returns status info"
```

This will:
1. Create an isolated branch `oc-task/add-health-endpoint`
2. Run the multi-agent workflow
3. Commit changes if any are made
4. Generate a summary in `.opencode/task-summaries/add-health-endpoint.md`

## How to run multiple tasks

To run multiple tasks from a file:

```bash
./scripts/oc-multi.sh [.opencode/tasks.txt]
```

If `tmux` is available, tasks will run in parallel sessions. Otherwise, they run sequentially.

The tasks file should contain lines in the format:
```
task-name|Task description
```

## How to review results

After tasks complete:

1. Check the generated summary files in `.opencode/task-summaries/`
2. Review changes in the task branches:
   ```bash
   git branch | grep oc-task
   git checkout oc-task/task-name
   git diff main
   ```
3. If satisfied, create a PR:
   ```bash
   gh pr create --title "Task title" --body "Task summary"
   ```

## How to swap models

Models are configured in `.opencode/opencode.json`:

- `default_model`: Used for most agent operations
- `small_model`: Used for lighter-weight tasks

To change models, edit the configuration file:
```json
{
  "default_model": "openrouter/qwen/qwen3-coder",
  "small_model": "openrouter/google/gemini-3-flash-preview"
}
```

## How to debug failures

If a task fails:

1. Check the branch for partial work:
   ```bash
   git branch | grep oc-task
   ```

2. Check any generated summary files for error information

3. Review the specific agent logs (if available)

4. Manually inspect the changes and continue manually if needed

Common issues:
- Insufficient context for the task
- Missing dependencies or tools
- Conflicts with existing code
- Validation failures

## Agent Roles

- **Orchestrator**: Plans work and coordinates agents
- **Researcher**: Explores codebase for context
- **Implementer**: Makes focused code changes
- **Tester**: Validates changes with testing
- **Reviewer**: Analyzes diffs for correctness

Each agent follows strict rules to ensure quality and safety.