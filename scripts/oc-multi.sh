#!/bin/bash

# oc-multi.sh - Run multiple AI coding tasks in parallel
# Usage: ./oc-multi.sh [.opencode/tasks.txt]

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

TASKS_FILE="${1:-.opencode/tasks.txt}"

# Check if git repo exists
if [ ! -d ".git" ]; then
    echo -e "${RED}Error: This directory is not a git repository${NC}"
    exit 1
fi

# Check if tasks file exists
if [ ! -f "${TASKS_FILE}" ]; then
    echo -e "${RED}Error: Tasks file not found: ${TASKS_FILE}${NC}"
    echo "Create a file with tasks in the format: task-name|task description"
    exit 1
fi

echo -e "${GREEN}Running multiple tasks from: ${TASKS_FILE}${NC}"

# Function to run a single task
run_task() {
    local line="$1"
    local task_name=$(echo "$line" | cut -d'|' -f1)
    local task_desc=$(echo "$line" | cut -d'|' -f2-)
    
    echo -e "${YELLOW}Starting task: ${task_name}${NC}"
    
    # Run the task script
    ./scripts/oc-task.sh "$task_name" "$task_desc"
    
    echo -e "${GREEN}Completed task: ${task_name}${NC}"
}

export -f run_task

# Check if tmux is available for better parallel execution
if command -v tmux &> /dev/null; then
    echo "Using tmux for parallel execution..."
    
    SESSION_NAME="oc-tasks-$(date +%s)"
    tmux new-session -d -s "$SESSION_NAME"
    
    task_count=0
    while IFS= read -r line; do
        # Skip empty lines and comments
        if [[ -z "$line" || "$line" =~ ^[[:space:]]*# ]]; then
            continue
        fi
        
        task_name=$(echo "$line" | cut -d'|' -f1)
        tmux new-window -t "$SESSION_NAME" -n "$task_name" "./scripts/oc-task.sh $(echo "$line" | sed 's/|/ /')"
        ((task_count++))
    done < "$TASKS_FILE"
    
    echo -e "${GREEN}Started ${task_count} tasks in tmux session: ${SESSION_NAME}${NC}"
    echo "Attach to the session with: tmux attach-session -t ${SESSION_NAME}"
    echo "Or run tasks in foreground with: tmux attach-session -t ${SESSION_NAME} -f"
else
    echo "tmux not available, running tasks sequentially..."
    
    while IFS= read -r line; do
        # Skip empty lines and comments
        if [[ -z "$line" || "$line" =~ ^[[:space:]]*# ]]; then
            continue
        fi
        
        run_task "$line"
    done < "$TASKS_FILE"
    
    echo -e "${GREEN}All tasks completed!${NC}"
fi