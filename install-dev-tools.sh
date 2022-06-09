set -euxo pipefail

# Xcode
xcode-select --install

# Homebrew (https://brew.sh/)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew autoupdate start --upgrade --cleanup --enable-notification

# Git
brew install git

# iTerm
brew cask install iterm2

curl -L https://iterm2.com/shell_integration/zsh -o ~/.iterm2_shell_integration.zsh

# zsh
brew install zsh

# oh-my-zsh (https://ohmyz.sh/#install)
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# powerlevel10k
brew install romkatv/powerlevel10k/powerlevel10k

# configure to install MesloLGS NF font but abandon the configuration
p10k configure

# zsh-autosuggestions
brew install zsh-autosuggestions

# zsh-syntax-highlighting
brew install zsh-syntax-highlighting

# change the font in iTerm2 to "MesloLGS NF" (Preferences > Profiles > Text)
# change the color scheme in iTerm2 to Solarized Dark (Preferences > Profiles > Color)
# change the Bright Black color in iTerm2 to #666666 (Preferences > Profiles > Color)

# java
brew tap homebrew/cask-versions
brew install --cask temurin8 temurin11 temurin17

# carvel tools (https://carvel.dev/)
brew tap vmware-tanzu/carvel
brew install ytt kbld kapp imgpkg kwt vendir

# python
brew install python

# ruby
brew install ruby

# general tools
brew install certbot curl direnv helm jq kind kubectl kubectx kustomize minikube openssl terraform watch wget

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

# visual studio code
brew cask install visual-studio-code

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

cp .p10k.zsh ~/
cp .zshrc ~/
