#!/usr/bin/env bash

# Agent Self-Learning Framework Installer (Bash version)

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

print_step() {
    echo -e "[${BLUE}INFO${NC}] $1"
}

print_success() {
    echo -e "[${GREEN}SUCCESS${NC}] $1"
}

print_warn() {
    echo -e "[${YELLOW}WARNING${NC}] $1"
}

print_error() {
    echo -e "[${RED}ERROR${NC}] $1"
}

# 1. Setup Project Memory
setup_project_memory() {
    local target_dir="$(pwd)"
    local agent_dir="${target_dir}/.agent"
    local memory_file="${agent_dir}/PROJECT_MEMORY.md"
    
    # Resolve the script directory to find the template
    local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    local template_file="${script_dir}/../.agent/PROJECT_MEMORY_TEMPLATE.md"

    if [ ! -d "$agent_dir" ]; then
        mkdir -p "$agent_dir"
        print_step "Created $agent_dir"
    fi

    if [ ! -f "$memory_file" ]; then
        if [ -f "$template_file" ]; then
            cp "$template_file" "$memory_file"
            print_success "Initialized new PROJECT_MEMORY.md at $memory_file"
        else
            print_error "Template not found at $template_file."
            exit 1
        fi
    else
        print_step "PROJECT_MEMORY.md already exists at $memory_file. Skipping initialization."
    fi
}

# 2. Get Claude Project Path & Establish Softlink
setup_claude_softlink() {
    local claude_projects_dir="${HOME}/.claude/projects"
    
    if [ ! -d "$claude_projects_dir" ]; then
        print_warn "~/.claude/projects/ not found. Are you using Claude Code?"
        return
    fi
    
    echo ""
    echo -e "${YELLOW}-- Claude Code Softlink Registration --${NC}"
    echo "Claude Code stores its memory in an obfuscated hash directory (e.g., ~/.claude/projects/1a2b3c4d...)."
    echo "To establish the softlink, please locate your project's hash directory."
    echo "You can usually find it by running \`ls -lt ~/.claude/projects/\` right after using Claude in your project."
    echo ""
    
    while true; do
        read -p "Enter the 64-char hash folder name for this project (or 'skip'): " hash_input
        # Remove whitespace
        hash_input="$(echo -e "${hash_input}" | tr -d '[:space:]')"

        local hash_lower=$(echo "$hash_input" | tr '[:upper:]' '[:lower:]')
        if [ "$hash_lower" = "skip" ]; then
            print_step "Skipping Claude softlink setup."
            return
        fi
        
        local target_path="${claude_projects_dir}/${hash_input}"
        
        if [ -d "$target_path" ]; then
            print_success "Found Claude project directory: $target_path"
            
            # Establish softlink
            local target_memory_dir="${target_path}/memory"
            local target_memory_file="${target_memory_dir}/MEMORY.md"
            local local_memory_file="$(pwd)/.agent/PROJECT_MEMORY.md"
            
            if [ ! -d "$target_memory_dir" ]; then
                mkdir -p "$target_memory_dir"
                print_step "Created memory directory at $target_memory_dir"
            fi
            
            if [ -f "$target_memory_file" ] || [ -L "$target_memory_file" ]; then
                if [ -L "$target_memory_file" ]; then
                    print_step "Softlink already exists. Recreating to ensure correctness."
                    rm "$target_memory_file"
                else
                    print_warn "An existing standard file was found at $target_memory_file."
                    local backup_file="${target_memory_dir}/MEMORY.md.bak"
                    mv "$target_memory_file" "$backup_file"
                    print_step "Backed up existing memory to $backup_file"
                fi
            fi
            
            ln -s "$local_memory_file" "$target_memory_file"
            print_success "Successfully linked $local_memory_file \n       -> $target_memory_file"
            break
        else
            print_error "Directory not found: $target_path"
        fi
    done
}

# 3. Install Stop Hook
install_stop_hook() {
    local git_dir="$(pwd)/.git"
    
    if [ ! -d "$git_dir" ]; then
        print_warn "Not a git repository. Skipping hook installation."
        return
    fi
    
    local hook_dir="$(pwd)/.claude/hooks"
    if [ ! -d "$hook_dir" ]; then
        mkdir -p "$hook_dir"
    fi
    
    local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    local template_hook="${script_dir}/../.claude/hooks/post-command"
    local target_hook="${hook_dir}/post-command"
    
    if [ -f "$template_hook" ]; then
        cp "$template_hook" "$target_hook"
        chmod 755 "$target_hook"
        print_success "Installed memory reminder hook at $target_hook"
        print_step "Claude Code will now execute this hook automatically."
    else
        print_warn "Template hook not found. Skipping hook installation."
    fi
}

echo "=================================================="
echo "🧠 Agent Self-Learning Framework Installer"
echo "=================================================="

setup_project_memory
setup_claude_softlink
install_stop_hook

echo ""
echo -e "${GREEN}Installation Complete!${NC}"
echo "From now on:"
echo " 1. Edit .agent/PROJECT_MEMORY.md to define architecture and rules."
echo " 2. Have your AI agent call \`/memory_capture\` to log robust engineering lessons."
