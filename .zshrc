# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Powerlevel10k Zsh theme
source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

autoload -Uz compinit
compinit

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(brew colored-man-pages git git-flow kubectl macos z)

source $ZSH/oh-my-zsh.sh

function services_login() {
  echo "AWS SSO Login"
  aws-sso-util login

  echo "Prod ECR Docker Login"
  source awsume Protect-AI.ImagePull
  aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin 268285133770.dkr.ecr.us-west-2.amazonaws.com

  echo "Dev ECR Docker Login"
  source awsume Protect-AI-Playground.AdministratorAccess
  aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin 002690075511.dkr.ecr.us-west-2.amazonaws.com

  echo "Replicated Docker & Helm Login"
  LICENSE_ID=$(op item get "Replicated License - pre-stable-testing" --vault "Palo Alto Networks" --fields password --reveal)

  echo $LICENSE_ID | docker login proxy.platform.protectai.com --username user --password-stdin
  echo $LICENSE_ID | helm registry login registry.platform.protectai.com --username user --password-stdin
}

function claude_login() {
  echo "GCP login"
  gcloud auth application-default login
  gcloud config set project airs-api-test1

  export CLAUDE_CODE_USE_VERTEX=1
  export CLOUD_ML_REGION=us-east5
  export ANTHROPIC_VERTEX_PROJECT_ID=pairs-sharedsvc-prd-wrk-std-cc
  export ANTHROPIC_DEFAULT_HAIKU_MODEL=claude-haiku-4-5@20251001
}

function flush_dns() {
  echo "Flushing DNS cache"
  sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder
}

# iTerm2 Zsh integration
source ~/.iterm2_shell_integration.zsh

source $(brew --prefix)/etc/bash_completion.d/az
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $(brew --prefix)/Caskroom/gcloud-cli/latest/google-cloud-sdk/path.zsh.inc
source $(brew --prefix)/Caskroom/gcloud-cli/latest/google-cloud-sdk/completion.zsh.inc
[[ $(brew --prefix)/bin/fzf ]] && source <(fzf --zsh)
[[ $(brew --prefix)/bin/kubectl ]] && source <(kubectl completion zsh)

eval "$(uv generate-shell-completion zsh)"
eval "$(uvx --generate-shell-completion zsh)"

eval "$(direnv hook zsh)"

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

export PATH="$(brew --prefix)/opt/openssl@3/bin:$PATH"

export PATH="$(brew --prefix)/opt/ruby/bin:$PATH"

# pipx ensurepath
export PATH="$PATH:$HOME/.local/bin"

export DOCKER_DEFAULT_PLATFORM=linux/amd64

export AWS_DEFAULT_SSO_START_URL="https://protect-ai.awsapps.com/start"
export AWS_DEFAULT_SSO_REGION=us-west-2
export AWS_DEFAULT_REGION=us-west-2

alias cat="bat --paging=never --style=plain"

alias k="kubectl"

alias ls='eza -l --group-directories-first --color=auto --git --icons --no-permissions --no-user'
alias ll='eza --color=always --icons=always --group-directories-first -l --git -h'


