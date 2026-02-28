#!/usr/bin/env bash

# Agent Self-Learning Framework Installer

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

print_step()    { echo -e "[${BLUE}INFO${NC}] $1"; }
print_success() { echo -e "[${GREEN}SUCCESS${NC}] $1"; }
print_warn()    { echo -e "[${YELLOW}WARNING${NC}] $1"; }

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="$(pwd)"
_had_error=false

print_error() {
    echo -e "[${RED}ERROR${NC}] $1"
    _had_error=true
}

# 1. Setup Project Memory
setup_project_memory() {
    local agent_dir="${TARGET_DIR}/.agent"
    local memory_file="${agent_dir}/PROJECT_MEMORY.md"
    local template_file="${SCRIPT_DIR}/../.agent/PROJECT_MEMORY_TEMPLATE.md"

    mkdir -p "$agent_dir" || { print_error "Failed to create directory $agent_dir."; exit 1; }

    if [ ! -f "$memory_file" ]; then
        if [ -f "$template_file" ]; then
            cp "$template_file" "$memory_file" || { print_error "Failed to copy template."; exit 1; }
            print_success "Initialized PROJECT_MEMORY.md at $memory_file"
        else
            print_error "Template not found at $template_file."
            exit 1
        fi
    else
        print_step "PROJECT_MEMORY.md already exists. Skipping."
    fi
}

# 2. Setup Claude Softlink (auto-detect project directory)
setup_claude_softlink() {
    local claude_projects_dir="${HOME}/.claude/projects"

    if [ ! -d "$claude_projects_dir" ]; then
        print_warn "~/.claude/projects/ not found. Skipping Claude softlink."
        return
    fi

    # Claude's project directory name is the project path with all /, spaces, and
    # underscores replaced by -  (e.g. /Users/foo/my app -> -Users-foo-my-app)
    local claude_dir_name
    claude_dir_name="$(echo "$TARGET_DIR" | sed 's|[/ _]|-|g')"
    local target_path="${claude_projects_dir}/${claude_dir_name}"

    if [ ! -d "$target_path" ]; then
        print_warn "Claude project directory not found at $target_path."
        print_step "Open Claude Code in this project first, then re-run the installer."
        return
    fi

    local target_memory_dir="${target_path}/memory"
    local target_memory_file="${target_memory_dir}/MEMORY.md"
    local local_memory_file="${TARGET_DIR}/.agent/PROJECT_MEMORY.md"

    mkdir -p "$target_memory_dir" || { print_error "Failed to create directory $target_memory_dir."; return; }

    if [ -L "$target_memory_file" ]; then
        rm "$target_memory_file" || { print_error "Failed to remove existing softlink."; return; }
        print_step "Removed existing softlink."
    elif [ -f "$target_memory_file" ]; then
        mv "$target_memory_file" "${target_memory_dir}/MEMORY.md.bak" || { print_error "Failed to back up existing memory file."; return; }
        print_step "Backed up existing memory to MEMORY.md.bak"
    fi

    ln -s "$local_memory_file" "$target_memory_file" || { print_error "Failed to create softlink."; return; }
    print_success "Linked: $local_memory_file"
    print_success "    ->  $target_memory_file"
}

# 3. Setup Git Hooks
setup_git_hooks() {
    if [ ! -d "${TARGET_DIR}/.git" ]; then
        print_warn "Not a git repository. Skipping git hooks setup."
        return
    fi

    local hooks_dir="${TARGET_DIR}/.githooks"
    local template_hook="${SCRIPT_DIR}/../.githooks/post-commit"
    local target_hook="${hooks_dir}/post-commit"

    mkdir -p "$hooks_dir" || { print_error "Failed to create directory $hooks_dir."; return; }

    if [ ! -f "$template_hook" ]; then
        print_warn "Hook template not found at $template_hook. Skipping."
        return
    fi

    if [ "$template_hook" -ef "$target_hook" ]; then
        print_step "Hook is already in place. Skipping copy."
    else
        cp "$template_hook" "$target_hook" || { print_error "Failed to copy hook."; return; }
        chmod 755 "$target_hook" || { print_error "Failed to make hook executable."; return; }
    fi

    local existing_hooks_path
    existing_hooks_path="$(git -C "$TARGET_DIR" config core.hooksPath 2>/dev/null)"
    if [ -n "$existing_hooks_path" ] && [ "$existing_hooks_path" != ".githooks" ]; then
        print_warn "core.hooksPath is already set to '$existing_hooks_path'. Skipping to avoid overwriting existing hooks."
        return
    fi

    git -C "$TARGET_DIR" config core.hooksPath .githooks || { print_error "Failed to configure core.hooksPath."; return; }
    print_success "post-commit hook ready at $target_hook"
    print_success "Configured git to use .githooks/"
}

# 4. Setup Bridge Files
add_bridge_reference() {
    local bridge_file="$1"
    local content="$2"

    if grep -q "PROJECT_MEMORY" "$bridge_file" 2>/dev/null; then
        print_step "$bridge_file already references PROJECT_MEMORY.md. Skipping."
        return
    fi

    printf "\n%s\n" "$content" >> "$bridge_file" || { print_error "Failed to write to $bridge_file."; return; }
    print_success "Updated $bridge_file"
}

setup_bridge_files() {
    local reference_content="> Project memory: \`.agent/PROJECT_MEMORY.md\`
> Available skills: \`.agent/skills/\`"

    add_bridge_reference "${TARGET_DIR}/CLAUDE.md"     "$reference_content"
    add_bridge_reference "${TARGET_DIR}/.cursorrules"  "$reference_content"
}

echo "=================================================="
echo "🧠 Agent Self-Learning Framework Installer"
echo "=================================================="

setup_project_memory
setup_claude_softlink
setup_git_hooks
setup_bridge_files

echo ""
if [ "$_had_error" = true ]; then
    echo -e "${YELLOW}Installation completed with errors. Review the output above.${NC}"
    exit 1
else
    echo -e "${GREEN}Installation Complete!${NC}"
fi
echo " 1. Edit .agent/PROJECT_MEMORY.md to define your architecture and rules."
echo " 2. Use /memory_capture to log insights after solving hard problems."
