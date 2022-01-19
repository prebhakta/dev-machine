set -euxo pipefail

# Homebrew (https://brew.sh/)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Git
brew install git

# iTerm
brew cask install iterm2

# zsh
brew install zsh

# oh-my-zsh (https://ohmyz.sh/#install)
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# zsh-syntax-highlighting
brew install zsh-syntax-highlighting

# Font (https://github.com/ryanoasis/nerd-fonts#option-4-homebrew-fonts)
brew tap homebrew/cask-fonts
brew install --cask font-jetbrains-mono-nerd-font

# change the font in iTerm2 (Preferences > Profiles > Text)
# change the color scheme in iTerm2 to Solarized Dark (Preferences > Profiles > Color)
# change the Bright Black color in iTerm2 to #666666 (Preferences > Profiles > Color)

# java
brew tap homebrew/cask-versions
brew install --cask temurin8 temurin11 temurin # temurin is the latest version

# carvel tools
brew tap vmware-tanzu/carvel
brew install ytt kbld kapp imgpkg kwt vendir

# others
brew install curl direnv helm httpie jq kind kubectl kubectx kustomize minikube openssl terraform watch wget