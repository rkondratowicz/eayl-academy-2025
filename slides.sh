#!/usr/bin/env bash

# slides.sh - Interactive presentation launcher using gum
# This script allows you to select and run any presentation from the slides folder

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if gum is installed
if ! command -v gum &> /dev/null; then
    echo -e "${RED}Error: gum is not installed.${NC}"
    echo -e "${YELLOW}Please install gum first:${NC}"
    echo "  macOS/Linux: brew install gum"
    echo "  For other platforms, visit: https://github.com/charmbracelet/gum"
    exit 1
fi

# Check if slidev is installed
if ! command -v npx &> /dev/null; then
    echo -e "${RED}Error: npx is not available (Node.js required).${NC}"
    exit 1
fi

# Get the script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SLIDES_DIR="$SCRIPT_DIR/slides"

# Find all presentation markdown files (excluding README.md)
# Using while-read loop for compatibility with Bash 3.2 (default on macOS)
presentations=()
while IFS= read -r line; do
    presentations+=("$line")
done < <(find "$SLIDES_DIR" -type f -name "*.md" ! -name "README.md" | sort)

if [ ${#presentations[@]} -eq 0 ]; then
    echo -e "${RED}No presentations found in $SLIDES_DIR${NC}"
    exit 1
fi

# Create a list of presentation names (folder/filename)
presentation_names=()
for pres in "${presentations[@]}"; do
    # Get relative path from slides directory
    rel_path="${pres#$SLIDES_DIR/}"
    # Extract the folder name and make it more readable
    folder_name=$(dirname "$rel_path")
    file_name=$(basename "$rel_path" .md)
    
    # Create a friendly display name
    if [ "$folder_name" = "." ]; then
        display_name="$file_name"
    else
        display_name="$folder_name: $file_name"
    fi
    
    presentation_names+=("$display_name")
done

# Use gum to select a presentation
echo -e "${GREEN}Select a presentation to run:${NC}"
selected=$(printf '%s\n' "${presentation_names[@]}" | gum choose --header "Available Presentations" --height 15)

if [ -z "$selected" ]; then
    echo -e "${YELLOW}No presentation selected. Exiting.${NC}"
    exit 0
fi

# Find the corresponding file path
selected_index=-1
for i in "${!presentation_names[@]}"; do
    if [ "${presentation_names[$i]}" = "$selected" ]; then
        selected_index=$i
        break
    fi
done

if [ $selected_index -eq -1 ]; then
    echo -e "${RED}Error: Could not find selected presentation.${NC}"
    exit 1
fi

selected_file="${presentations[$selected_index]}"

# Confirm before running
echo ""
gum style --border normal --padding "1 2" --border-foreground 212 "Starting presentation: $selected"

if gum confirm "Run this presentation?"; then
    echo -e "${GREEN}Starting slidev...${NC}"
    echo ""
    
    # Run slidev with the selected presentation
    cd "$SCRIPT_DIR"
    npx slidev "$selected_file"
else
    echo -e "${YELLOW}Cancelled.${NC}"
    exit 0
fi
