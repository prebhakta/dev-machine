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

function bw_unlock() {
  BW_STATUS=$(bw status | jq -r .status)

  case "${BW_STATUS}" in
    "unauthenticated")
      echo "Logging into BitWarden via apikey"
      bw login --apikey
      ;&
    "locked")
      echo "Unlocking Vault"
      op item edit Bitwarden --vault ProtectAI BW_SESSION=$(bw unlock $(op item get Bitwarden --vault ProtectAI --fields password --reveal) --raw)
      bw_set_session
      ;;
    "unlocked")
      echo "Vault is unlocked"
      ;;
    *)
      echo "Unknown Login Status: ${BW_STATUS}"
      return 1
      ;;
  esac
}

function bw_set_session() {
  echo "Setting BW_SESSION"
  export BW_SESSION=$(op item get Bitwarden --vault ProtectAI --fields BW_SESSION --reveal)
}

# iTerm2 Zsh integration
source ~/.iterm2_shell_integration.zsh

source $(brew --prefix)/etc/bash_completion.d/az
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc
source $(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc
[[ $(brew --prefix)/bin/fzf ]] && source <(fzf --zsh)
[[ $(brew --prefix)/bin/kubectl ]] && source <(kubectl completion zsh)

eval "$(direnv hook zsh)"

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

eval "$(pyenv virtualenv-init -)"

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
alias ll='eza -lahF --group-directories-first --color=auto --git --icons'
