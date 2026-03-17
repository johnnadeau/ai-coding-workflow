#!/bin/bash

# oc-task.sh - Execute a single AI coding task in an isolated environment
# Usage: ./oc-task.sh "task-name" "task description"

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if git repo exists
if [ ! -d ".git" ]; then
    echo -e "${RED}Error: This directory is not a git repository${NC}"
    exit 1
fi

# Check arguments
if [ $# -lt 2 ]; then
    echo -e "${RED}Usage: $0 <task-name> <task-description>${NC}"
    echo "Example: $0 \"add-health-endpoint\" \"Add a /health endpoint that returns status info\""
    exit 1
fi

TASK_NAME="$1"
TASK_DESCRIPTION="$2"
BRANCH_NAME="oc-task/${TASK_NAME}"
SUMMARY_FILE=".opencode/task-summaries/${TASK_NAME}.md"

echo -e "${GREEN}Starting task: ${TASK_NAME}${NC}"
echo "Description: ${TASK_DESCRIPTION}"

# Create task summaries directory
mkdir -p .opencode/task-summaries

# Check if branch already exists
if git show-ref --verify --quiet "refs/heads/${BRANCH_NAME}"; then
    echo -e "${YELLOW}Branch ${BRANCH_NAME} already exists. Checking it out.${NC}"
    git checkout "${BRANCH_NAME}"
else
    echo "Creating new branch: ${BRANCH_NAME}"
    git checkout -b "${BRANCH_NAME}"
fi

# Run the orchestrator agent
echo "Running orchestrator agent..."
# In a real implementation, this would call the OpenCode CLI
# For now, we'll simulate the process
echo "Task execution would happen here..."
echo "Agents would collaborate to implement the task..."

# Create a placeholder summary file
cat > "${SUMMARY_FILE}" << EOF
# Task Summary: ${TASK_NAME}

## Description
${TASK_DESCRIPTION}

## Status
Task completed successfully.

## Files Changed
- No files changed (placeholder)

## Validation
- All checks passed

## Notes
This is a placeholder summary. In a real implementation, the agents would generate detailed information here.
EOF

# Check if there are any changes
if ! git diff --quiet; then
    echo "Changes detected. Committing..."
    git add .
    git commit -m "feat: implement ${TASK_NAME}"
    echo -e "${GREEN}Changes committed to branch ${BRANCH_NAME}${NC}"
else
    echo "No changes detected."
fi

echo -e "${GREEN}Task completed!${NC}"
echo "Branch: ${BRANCH_NAME}"
echo "Summary: ${SUMMARY_FILE}"

# Check if gh CLI exists and suggest PR creation
if command -v gh &> /dev/null; then
    echo ""
    echo "To create a PR, run:"
    echo "gh pr create --title \"${TASK_NAME}\" --body \"$(cat ${SUMMARY_FILE} | sed 's/"/\\"/g')\""
fi