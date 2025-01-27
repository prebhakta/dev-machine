# dev-machine

## Setup

### xcode-select

1. Open Terminal app
1. Install
    ```sh
    xcode-select --install
    ```
1. Follow prompts to install

### SSH Key

1. Copy ssh config
    ```sh
    cp .ssh/config ~/.ssh/
    ```
1. Import public and private key
1. Change permissions
    ```sh
    chmod 700 ~/.ssh/
    chmod 644 ~/.ssh/id_ed25519.pub
    chmod 600 ~/.ssh/id_ed25519
    chmod 600 ~/.ssh/config
    ```
1. Store passphrase in the Keychain
    ```sh
    ssh-add --apple-use-keychain ~/.ssh/id_ed25519
    ```


### GPG Key

1. Import public and private key
    ```sh
    # Download public and private key from 1Password

    gpg --import public.key
    gpg --import public.key
    ```
1. Configure git
    ```sh
    git config --global user.signingkey "A5B36F1B694D802B"
    ```

### karabiner-elements

1. Install (https://karabiner-elements.pqrs.org)
1. Copy config
    ```sh
    cp -r karabiner/ ~/.config/karabiner/
    ```
1. Open the app
1. Verify keyboard settings

### Logitech Options

NOTE: do not install Logitech Options+

1. Install (https://www.logitech.com/en-us/software/options.html)
1. Setup side button for Mission Control

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

1. Install oh-my-zsh (https://ohmyz.sh/#install)
    ```sh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    ```
1. Install krew (https://krew.sigs.k8s.io/docs/user-guide/setup/install)
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
    ```
1. Install neat (https://github.com/itaysk/kubectl-neat)
    ```sh
    kubectl krew install neat
    ```
1. Install tree (https://github.com/ahmetb/kubectl-tree)
    ```sh
    kubectl krew install tree
    ```

### iTerm2

#### Zsh Integration

1. Install iTerm Zsh Integration
    ```sh
    curl -L https://iterm2.com/shell_integration/zsh -o ~/.iterm2_shell_integration.zsh
    ```

#### Set Default Terminal

1. Open iTerm2
1. Click iTerm from the menu
1. Click "Make iTerm2 the default Term

#### Import Settings

1. Open Settings > Settings
1. Import all settings and data with the "iTerm2 State.itermexport" file

### Powerlevel10k Configuration

1. Load theme
    ```sh
    source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
    ```
1. Answer Yes when asked whether to install Meslo Nerd Font
1. Answer the remaining questions

### Python Configuration

1. Install multiple versions
    ```sh
    pyenv install 3.11 3.12 3.13
    ```
1. Set a global version and install pipx
    ```sh
    pyenv global 3.13
    pip install pipx
    ```
1. An example of configuring a virtual environment and pinning a project
    ```sh
    cd project-dir
    pyenv virtualenv 3.11 project-name
    pyenv local project-name
    ```

### awsume

1. Install
    ```sh
    pipx install awsume

    # BUG FIX: https://github.com/trek10inc/awsume/issues/238
    pipx inject awsume setuptools
    ```
1. Configure shell integration
    ```sh
    awsume-configure --shell zsh
    ```

### Zsh Configuration

1. Copy config
    ```sh
    cp .zshrc ~/
    ```
1. Change shell
    ```sh
    chsh -s $(which zsh)
    ```

### GitHub

1. Configure
    ```sh
    git config --global user.name "Pre Bhakta"
    git config --global user.email "46793287+prebhakta@users.noreply.github.com"

    ```

### Beyond Compare

1. Install (https://www.scootersoftware.com/download/v4)
1. Open Beyond Compare
1. "Install command line tools..." from menu 
1. Configure git
    ```sh
    git config --global diff.tool bc
    ```

### Vim

1. Copy config
    ```sh
    cp .vimrc ~/
    ```

### VSCode Integration

1. Sign-in to sync settings
