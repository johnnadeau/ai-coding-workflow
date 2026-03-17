# Multi-Agent Coding System

A reusable, project-agnostic multi-agent coding system for automating software development tasks with human-like collaboration patterns.

## Overview

This repository contains a complete multi-agent system that can be dropped into any codebase to enable AI-assisted development. The system uses specialized agents that collaborate following a strict workflow:

1. **Orchestrator** - Plans work and delegates tasks
2. **Researcher** - Explores the codebase for context
3. **Implementer** - Makes minimal, focused code changes
4. **Tester** - Validates changes with available tooling
5. **Reviewer** - Analyzes diffs for correctness and safety

## Features

- **Project Agnostic**: Works with any language or framework
- **Isolated Execution**: Tasks run in separate branches to prevent conflicts
- **Minimal Changes**: Agents follow strict rules to make only necessary changes
- **Validation First**: Built-in testing and validation before completion
- **PR-Ready Output**: Generates summary files for easy code review
- **Parallel Execution**: Run multiple tasks simultaneously

## Quick Start

1. Clone this repository or copy the files to your project
2. Run a single task:
   ```bash
   ./scripts/oc-task.sh "task-name" "Task description"
   ```
3. Run multiple tasks:
   ```bash
   ./scripts/oc-multi.sh
   ```

## Documentation

See [AI Workflow Documentation](docs/ai-workflow.md) for detailed information on:
- How to run tasks
- How to review results
- How to customize the system
- How to maintain and evolve the setup

## Requirements

- Git
- OpenCode CLI (for actual agent execution)
- Bash (for scripts)
- Optional: tmux (for parallel task execution)

## Repository Structure

```
├── AGENTS.md                 # Core workflow definition
├── .opencode/
│   ├── agents/               # Specialized agent definitions
│   ├── opencode.json         # Configuration file
│   └── tasks.txt             # Example tasks
├── scripts/                  # Execution scripts
│   ├── oc-task.sh            # Single task execution
│   └── oc-multi.sh           # Multiple task execution
└── docs/
    └── ai-workflow.md        # Detailed documentation
```

## Contributing

This system is designed to evolve. Feel free to:
- Improve agent prompts
- Enhance scripts
- Add new capabilities
- Share improvements with the community