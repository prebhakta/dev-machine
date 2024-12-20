# dev-machine

## Setup

### karabiner-elements

1. Install (https://karabiner-elements.pqrs.org)
1. Run `cp -r karabiner/ ~/.config/karabiner/`
1. Open the app
1. Verify keyboard settings

### Logitech Options

NOTE: do not install Logitech Options+

1. Install (https://www.logitech.com/en-us/software/options.html)
1. Setup side button for Mission Control

### xcode-select

1. Run `xcode-select --install`
1. Follow prompts to install

### Homebrew

1. Install (https://brew.sh)
    ```sh
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ```
1. Add to shell env
    ```sh
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
    ```
1. Install bundle
    ```sh
    brew bundle install
    ```

### Non-brew

1. iTerm Zsh Integration
    ```sh
    curl -L https://iterm2.com/shell_integration/zsh -o ~/.iterm2_shell_integration.zsh
    ```
1. oh-my-zsh (https://ohmyz.sh/#install)
    ```sh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    ```
1. krew (https://krew.sigs.k8s.io/docs/user-guide/setup/install)
    ```sh
    (
    set -x; cd "$(mktemp -d)" &&
    OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
    ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
    KREW="krew-${OS}_${ARCH}" &&
    curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
    tar zxvf "${KREW}.tar.gz" &&
    ./"${KREW}" install krew
    )

   export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

   exec "$SHELL"
   ```
1. neat (https://github.com/itaysk/kubectl-neat)
    ```sh
    kubectl krew install neat
    ```
1. tree (https://github.com/ahmetb/kubectl-tree)
    ```sh
    kubectl krew install tree
    ```

### iTerm2

#### Set Default Terminal

1. Open iTerm2
1. Click iTerm from the menu
1. Click "Make iTerm2 the default Term

#### Import Profile

1. Open Settings > Profiles
1. Import the profile iterm2-profile.json
1. Delete the old default profile

#### Set Global Hotkey

1. Open Settings > Keys > Hotkey
1. Set Hotkey to "Command + i"

### Powerlevel10k Configuration

1. Run `source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme`
1. Answer Yes when asked whether to install Meslo Nerd Font
1. Answer the remaining questions

### Zsh Configuration

1. Run `cp .zshrc ~/`