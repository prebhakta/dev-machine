# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

This is a macOS development machine configuration repository containing dotfiles, shell configurations, and setup scripts for a DevOps/platform engineering environment focused on Kubernetes, AWS, and Python development. It is NOT a traditional software project with build/test commands.

**This repository is designed for complete machine provisioning - follow the README.md setup steps in order for new machine setup.**

## Repository Structure

- `.zshrc` - Main shell configuration with custom functions for authentication and service logins
- `Brewfile` - Homebrew package definitions for all CLI tools and applications
- `.vimrc` - Minimal vim configuration
- `karabiner/` - Karabiner-Elements keyboard customization configs
- `.ssh/config` - SSH configuration template
- `iterm2-profile.json` - iTerm2 configuration
- `README.md` - Step-by-step setup instructions for new machine provisioning

## Key Shell Functions in .zshrc

The `.zshrc` file contains several critical authentication and login functions that form a credential management chain:

### Authentication Flow
1. `bw_unlock()` (.zshrc:28-50) - Unlocks BitWarden vault using 1Password integration
   - Checks BitWarden status (unauthenticated/locked/unlocked)
   - Uses fallthrough (;& operator) from "unauthenticated" to "locked" case
   - Retrieves BitWarden master password from 1Password vault "Palo Alto Networks"
2. `bw_set_session()` (.zshrc:52-54) - Exports BW_SESSION from 1Password
3. `services_login()` (.zshrc:56-73) - Multi-step authentication for development services
   - AWS SSO login via `aws-sso-util`
   - Docker login to Prod ECR (requires `awsume Protect-AI.ImagePull`)
   - Docker login to Dev ECR (requires `awsume Protect-AI-Playground.AdministratorAccess`)
   - Replicated docker/helm registry login (retrieves license from BitWarden)
4. `claude_login()` (.zshrc:75-83) - GCP authentication and Vertex AI configuration
   - Sets up GCP application-default credentials
   - Configures project: `airs-api-test1` in region `us-east5`
5. `flush_dns()` (.zshrc:85-88) - Flushes macOS DNS cache (requires sudo)

### Critical Dependencies
- **1Password CLI (`op`)** is the primary credential store
- **BitWarden CLI (`bw`)** integrates with 1Password for secondary credential management
- AWS authentication uses `aws-sso-util` and `awsume` for role assumption
- The shell automatically attempts to set `BW_SESSION` on startup (.zshrc:128-130)
- All functions currently lack error handling - see "Modifying .zshrc Functions" section below

## Environment Setup Commands

### Initial Machine Setup
```sh
# Install Homebrew packages
brew bundle install

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Copy shell configuration
cp .zshrc ~/

# Install Python versions
uv python install 3.11 3.12 3.13 3.14

# Install awsume
pipx install awsume
pipx inject awsume setuptools
awsume-configure --shell zsh
```

### Testing Shell Configuration Changes
```sh
# Validate .zshrc syntax
zsh -n .zshrc

# Reload shell configuration
exec zsh -l

# Test specific functions (requires credentials)
bw_unlock
services_login
```

### Configuration File Installation
```sh
# SSH configuration
mkdir -p ~/.ssh/
cp .ssh/config ~/.ssh/
chmod 700 ~/.ssh/
chmod 600 ~/.ssh/config

# Karabiner keyboard customization
mkdir -p ~/.config/karabiner/
cp -r karabiner/ ~/.config/karabiner/

# iTerm2 shell integration
curl -L https://iterm2.com/shell_integration/zsh -o ~/.iterm2_shell_integration.zsh

# Vim configuration
cp .vimrc ~/
```

## AWS Environment
- Default SSO start URL: `https://protect-ai.awsapps.com/start`
- Default region: `us-west-2`
- Two main AWS accounts accessed:
  - `Protect-AI.ImagePull` (Prod ECR: 268285133770)
  - `Protect-AI-Playground.AdministratorAccess` (Dev ECR: 002690075511)

## Python Development
- Uses `uv` for Python version management (replaced pyenv)
- Uses `direnv` for automatic virtual environment activation
- Standard pattern for new projects:
  ```sh
  cd project-dir
  uv venv --python 3.13  # or desired version
  echo "source .venv/bin/activate" > .envrc
  direnv allow
  ```
- Available Python versions: 3.11, 3.12, 3.13, 3.14
- Package management via `pipx` for global CLI tools (installed to `~/.local/bin`)

## Kubernetes Tools
- kubectl with completion enabled
- kubectl plugins via krew: `neat`, `tree`
- k9s for cluster management
- Multiple tools: kind, minikube, helm, helmfile, kustomize, tilt

## Shell Aliases
- `cat` → `bat --paging=never --style=plain`
- `k` → `kubectl`
- `ls` → `eza -l --group-directories-first --color=auto --git --icons --no-permissions --no-user`
- `ll` → `eza --color=always --icons=always --group-directories-first -l --git -h`

## Modifying .zshrc Functions

When editing shell functions in `.zshrc`:
1. **Add proper error handling** - Current functions lack error checking
   - Check command availability with `command -v` before using
   - Validate outputs before using them in subsequent commands
   - Return non-zero status on errors (`return 1`)
2. **Use proper command chaining**
   - Use `&&` instead of `;` for dependent commands
   - Use `||` for error handling and fallbacks
3. **Redirect stderr appropriately**
   - Use `2>/dev/null` to suppress expected errors
   - Use `2>&2` to write errors to stderr
4. **Test before committing**
   - Validate syntax: `zsh -n .zshrc`
   - Test in a new shell: `zsh -c 'source .zshrc'`
5. **External service dependencies**
   - Functions interact with 1Password, BitWarden, AWS, GCP
   - Credentials must be available before running functions
   - Consider adding `command -v` checks at function start

## Additional Tools & Configurations

### Karabiner-Elements
- Custom keyboard mappings in `karabiner/karabiner.json`
- Main feature: PC-style Home/End key behavior (maps to Cmd+Left/Right)
- Excludes: terminal apps, browsers, IDEs, and remote desktop apps from remapping

### SSH Configuration
- Default user: `prebhakta`
- Uses `id_ed25519` key with Keychain integration
- Config applies to all hosts (`Host *`)

### Git Configuration
- User: "Pre Bhakta" `<46793287+prebhakta@users.noreply.github.com>`
- GPG signing key configured (commits should be GPG-signed)
- Beyond Compare set as default diff tool

### Shell Enhancements
- oh-my-zsh plugins: brew, colored-man-pages, git, git-flow, kubectl, macos, z
- Powerlevel10k theme for prompt
- zsh-autosuggestions and zsh-syntax-highlighting enabled
- fzf for fuzzy finding
- bat for enhanced cat with syntax highlighting
