#!/bin/sh
set -euxo pipefail

# Homebrew (https://brew.sh/)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/$USER/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

brew autoupdate start --upgrade --cleanup --enable-notification

# Git
brew install git

# iTerm
brew install --cask iterm2

# tmux
brew install tmux

curl -L https://iterm2.com/shell_integration/zsh -o ~/.iterm2_shell_integration.zsh

cp .p10k.zsh ~/
cp .zshrc ~/

# zsh
brew install zsh

# oh-my-zsh (https://ohmyz.sh/#install)
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# powerlevel10k
brew install romkatv/powerlevel10k/powerlevel10k



exit



# configure to install MesloLGS NF font but abandon the configuration
p10k configure

# zsh-autosuggestions
brew install zsh-autosuggestions

# zsh-syntax-highlighting
brew install zsh-syntax-highlighting

# import the iterm2 profile (Preferences > Profiles)

# java
curl -s "https://get.sdkman.io" | bash
source "/Users/pbhakta/.sdkman/bin/sdkman-init.sh"

# carvel tools (https://carvel.dev/)
brew tap vmware-tanzu/carvel
brew install ytt kbld kapp imgpkg kwt vendir kctrl

# pack (https://buildpacks.io/docs/tools/pack/)
brew install buildpacks/tap/pack

# mysql
brew install mysql-client

# node
brew install node

# ollama
brew install ollama

# postgres
brew install postgresql

# python
brew install python
brew install pipx

# ruby
brew install ruby



exec $SHELL



# general tools
brew install curl direnv fzf helm jq kind kubectl kubectx kustomize minikube openssl terraform watch wget yq

# knative cli (https://knative.dev/docs/client/install-kn)
brew install knative/client/kn

# visual studio code
brew install --cask visual-studio-code

# aws cli
brew install awscli

# azure cli
brew install azure-cli

# gcloud cli
brew install --cask google-cloud-sdk

# 1password
brew install --cask 1password/tap/1password-cli

# alfred
brew install --cask alfred

# k9s
brew install derailed/k9s/k9s

# tree
brew install tree

# spring boot
brew tap spring-io/tap
brew install spring-boot

# sourcetree
brew install --cask sourcetree

# tilt
brew install tilt-dev/tap/tilt

# krew (https://krew.sigs.k8s.io/docs/user-guide/setup/install/)
(
  set -x; cd "$(mktemp -d)" &&
  OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
  ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
  KREW="krew-${OS}_${ARCH}" &&
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
  tar zxvf "${KREW}.tar.gz" &&
  ./"${KREW}" install krew
)

# neat (https://github.com/itaysk/kubectl-neat)
kubectl krew install neat

# tree (https://github.com/ahmetb/kubectl-tree)
kubectl krew install tree

# certbot (https://certbot.eff.org/instructions?ws=other&os=pip&tab=wildcard)
pipx install certbot
pipx install certbot-dns-azure
pipx install certbot-dns-google
pipx install certbot-dns-route53

cp karabiner ~/.config/karabiner
