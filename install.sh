#!/usr/bin/env bash

# Use this script to automate initial environment setup.
# It is written for an Ubuntu flavored Linux system, and was tested with Linux Mint 20.04.

# https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -ueE -o pipefail

# Check if SSH key was created
function check_ssh_key() {
  if [[ ! -f $HOME/.ssh/id_rsa || ! -f $HOME/.ssh/id_rsa.pub ]]; then
    echo "$BASH_SOURCE: Please put your ssh keys at ~/.ssh and retry" >&2
    exit 1
  fi
}

# Install Corsair unofficial driver (https://github.com/ckb-next/ckb-next):
function install_corsair_drivers() {
  echo "-----> Install Corsair unofficial driver"
  sudo add-apt-repository -y ppa:tatokis/ckb-next
  sudo apt-get update
  sudo apt install -y ckb-next
}

# Install Logitech unofficial management software (https://github.com/pwr-Solaar/Solaar):
function install_logitech_software() {
  echo "-----> Install Logitech unofficial management software"
  sudo add-apt-repository -y ppa:solaar-unifying/stable
  sudo apt-get update
  sudo apt install -y solaar
}

# Install Spotify (https://www.spotify.com/us/download/linux/):
function install_spotify() {
  echo "-----> Install Spotify"
  curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | sudo apt-key add -
  echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
  sudo apt-get update
  sudo apt install -y spotify-client
}

# Accept EULA for Microsoft fonts before installation:
function accept_ms_eula() {
  echo "-----> Accept EULA for Microsoft fonts"
  echo msttcorefonts msttcorefonts/accepted-mscorefonts-eula select true | \
sudo debconf-set-selections
}

# Install Debian packages:
function install_packages() {
  echo "-----> Install packages with apt"
  local packages=(
    curl wget
    git zsh gnome-terminal
    vim-gtk3 nano man feh
    build-essential zlib1g-dev x11-utils xz-utils
    zip unzip unrar p7zip-full p7zip-rar gzip pigz bzip2
    python3-pip python3-dev python3-venv
    pandoc python3-docutils rst2pdf
    g++ clang cmake
    ruby-full hugo
    xclip traceroute
    silversearcher-ag ack gawk
    htop tree hardinfo blueman
    dos2unix jq thefuck tidy
    ascii screenfetch
    dconf-cli dconf-editor
    tmux freerdp2-x11 dbus-x11
    flashplugin-installer
    ttf-mscorefonts-installer fonts-symbola
    docker.io docker-compose
    awscli ec2-ami-tools
    fd-find bat fzf
    #ripgrep
    gparted deluge bleachbit filezilla
    remmina remmina-plugin-rdp remmina-plugin-vnc
    vlc
    mypaint gimp-plugin-registry
    virtualbox keepassxc
  )

  sudo apt-get update
  sudo bash -c 'DEBIAN_FRONTEND=noninteractive apt-get -o DPkg::options::=--force-confdef \
-o DPkg::options::=--force-confold upgrade -y'
  sudo apt-get upgrade -y
  sudo apt-get install -y "${packages[@]}" || (echo -e " Try cleaning dpkg cache:\n\
sudo dpkg -i --force-overwrite PROBLEMATIC_PACKAGE_FROM_ERROR_MESSAGE\n\
To fix broken packages run:\n\
sudo apt -f install\n\
Then, run the install.sh script again" && return 1)

  sudo apt-get autoremove -y
  sudo apt-get autoclean
}

# Install minimal Debian packages:
function install_minimal_packages() {
  echo "-----> Install minimal packages with apt"
  local packages=(
    curl wget
    git zsh
    vim nano man feh
    build-essential zlib1g-dev xz-utils
    zip unzip unrar p7zip-full p7zip-rar gzip pigz bzip2
    python3-pip python3-dev python3-venv
    pandoc python3-docutils rst2pdf
    g++ clang cmake
    ruby-full hugo
    xclip traceroute
    silversearcher-ag ack gawk
    htop tree hardinfo
    dos2unix jq thefuck tidy
    ascii screenfetch
    dconf-cli dconf-editor
    tmux xdg-utils
    ttf-mscorefonts-installer fonts-symbola
    docker.io docker-compose
    awscli ec2-ami-tools
    fd-find bat fzf
    #ripgrep
  )

  sudo apt-get update
  sudo bash -c 'DEBIAN_FRONTEND=noninteractive apt-get -o DPkg::options::=--force-confdef \
-o DPkg::options::=--force-confold upgrade -y'
  sudo apt-get upgrade -y
  sudo apt-get install -y "${packages[@]}" || (echo -e " Try cleaning dpkg cache:\n\
sudo dpkg -i --force-overwrite PROBLEMATIC_PACKAGE_FROM_ERROR_MESSAGE\n\
To fix broken packages run:\n\
sudo apt -f install\n\
Then, run the install.sh script again" && return 1)

  sudo apt-get autoremove -y
  sudo apt-get autoclean
}

# Install Debian packages of WSL:
function install_packages_in_wsl() {
  echo "-----> Install packages with apt in WSL"
  local packages=(
    curl wget
    git zsh gnome-terminal
    vim-gtk3 nano man feh
    build-essential zlib1g-dev x11-utils xz-utils
    zip unzip unrar p7zip-full p7zip-rar gzip pigz bzip2
    python3-pip python3-dev python3-venv
    pandoc python3-docutils rst2pdf
    g++ clang cmake
    ruby-full hugo
    xclip traceroute
    silversearcher-ag ack gawk
    htop tree hardinfo
    dos2unix jq thefuck tidy
    ascii screenfetch
    dconf-cli xdg-utils
    tmux dbus-x11
    awscli ec2-ami-tools
    fd-find bat fzf
    #ripgrep
  )

  sudo apt-get update
  sudo bash -c 'DEBIAN_FRONTEND=noninteractive apt-get -o DPkg::options::=--force-confdef \
-o DPkg::options::=--force-confold upgrade -y'
  sudo apt-get upgrade -y
  sudo apt-get install -y "${packages[@]}" || (echo -e " Try cleaning dpkg cache:\n\
sudo dpkg -i --force-overwrite PROBLEMATIC_PACKAGE_FROM_ERROR_MESSAGE\n\
To fix broken packages run:\n\
sudo apt -f install\n\
Then, run the install.sh script again" && return 1)
  sudo apt-get autoremove -y
  sudo apt-get autoclean
}

# Install MacOS packages:
function install_macos_packages() {
  echo "-----> Install MacOS packages with brew"
  local packages=(
    python go
    curl wget
    git zsh
    vim nano tldr
    zip unzip gzip pigz bzip2
    pandoc docutils
    make cmake
    ruby hugo
    xclip
    ack gawk
    htop tree
    dos2unix jq thefuck tidy-html5
    ascii screenfetch
    tmux
    ttf-mscorefonts-installer fonts-symbola
    awscli ec2-ami-tools
    fd-find bat fzf ripgrep
    kubernetes-cli helm    
  )

  local casks=(
    rar vlc
    docker intellij-idea
    virtualbox    
    gimp deluge    
  )

  brew update
  brew upgrade
  brew install "${packages[@]}" || (echo -e " Failed to install packages.\n\
Run 'brew doctor' to check brew status.\n\
Try to install failed packages manually.\n\
Then, run the install.sh script again" && return 1)
  brew install --cask "${casks[@]}" || (echo -e " Failed to install casks.\n\
Run 'brew doctor' to check brew status.\n\
Try to install failed packages manually.\n\
Then, run the install.sh script again" && return 1)
  brew tap homebrew/cask-fonts && brew install --cask font-source-code-pro
  brew cleanup
}

# Remove unused packages:
function remove_packages() {
  local packages_to_remove=(
    blueberry rhythmbox transmission-gtk transmission-common
  )

  for pkg in "${packages_to_remove[@]}"; do
    $(dpkg --status $pkg &> /dev/null) || continue
    sudo apt-get remove -y $pkg
  done
  sudo apt-get autoremove -y
  sudo apt-get autoclean
}

# Install custom applets and extensions:
function install_applets_and_extensions() {
  echo "-----> Install custom applets and extensions"
  local applets=(
    multicore-sys-monitor@ccadeptic23 qredshift@quintao SpicesUpdate@claudiux weather@mockturtl
  )
  local extensions=(
    transparent-panels@germanfr
  )
  # applets - download, extract and delete zip:
  pushd ${HOME}/.local/share/cinnamon/applets
  for i in "${applets[@]}"
  do
    [ ! -d "$i" ] && wget "https://cinnamon-spices.linuxmint.com/files/applets/$i.zip" && \
unzip -q "$i.zip" && rm -f "$i.zip" || true
  done
  popd
  # extensions - download, extract and delete zip:
  pushd ${HOME}/.local/share/cinnamon/extensions
  for i in "${extensions[@]}"
  do
    [ ! -d "$i" ] && wget "https://cinnamon-spices.linuxmint.com/files/extensions/$i.zip" && \
unzip -q "$i.zip" && rm -f "$i.zip" || true
  done
  popd
}

# Load dconf configuration files:
function load_dconf_files() {
  echo "-----> Load dconf configuration files"
  # load gnome-terminal profile:
  dconf load /org/gnome/terminal/legacy/profiles:/ < \
$HOME/.dotfiles/dconf-files/gnome-terminal-profiles.dconf
  # load cinnamon configuration (key-bindings, panels, enabled applets, terminal launcher
  # configuration):
  dconf load /org/cinnamon/ < $HOME/.dotfiles/dconf-files/cinnamon.dconf
}

# Edit desktop shortcuts to start GNOME terminal and VIM maximized:
function edit_gnome_terminal_shortcuts() {
  echo "-----> Edit gnome-terminal shortcuts"
  mkdir -p $HOME/.local/share/applications
  # Edit system menu shortcut:
  cp /usr/share/applications/org.gnome.Terminal.desktop \
$HOME/.local/share/applications/org.gnome.Terminal.desktop
  sed -i 's/Exec=gnome-terminal/Exec=gnome-terminal --window --maximize/g' \
$HOME/.local/share/applications/org.gnome.Terminal.desktop
  # Edit VIM shortcut:
  cp /usr/share/applications/vim.desktop $HOME/.local/share/applications/
  perl -i -0777 -pe "s/Exec=vim %F\nTerminal=true/Exec=gnome-terminal --window --maximize -e \
'vim %F'\nTerminal=false/g" $HOME/.local/share/applications/vim.desktop
}

# Install SDKMAN and Java JDK and build tools (must be run from zsh):
function install_java() {
  echo "-----> Install SDKMAN and Java JDK and build tools"
  zsh $HOME/.dotfiles/sdkman.sh
  sudo ln -s $HOME/.sdkman/candidates/java/current/bin/* /usr/bin/ 2>/dev/null || true
}

# Install go:
function install_go() {
  local v=1.17.2
  ! command -v go &>/dev/null || [[ "$(go version)" != *"$v"* ]] || return 0
  echo "-----> Install Golang $v"
  dwfile="go${v}.linux-amd64.tar.gz"
  curl -O "https://storage.googleapis.com/golang/${dwfile}"
  sudo rm -rf /usr/local/go
  sudo tar -C /usr/local -xzf $dwfile
  rm $dwfile
}

# Copy custom fonts:
function copy_custom_fonts() {
  echo "-----> Copy custom fonts"
  # Get shell font
  mkdir -p $HOME/.local/share/fonts
  curl -fLo "$HOME/.local/share/fonts/Sauce Code Pro Nerd Font Complete.ttf" \
https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/SourceCodePro/Regular/complete\
/Sauce%20Code%20Pro%20Nerd%20Font%20Complete.ttf?raw=true
  yes | cp -fa $HOME/.dotfiles/.local/share/fonts/. $HOME/.local/share/fonts && echo "Done"
  sudo fc-cache -f -v
}

# Beautify ZSH:
function beautify_shell() {
  echo "-----> Beautify shell"
  # Install oh-my-zsh
  [ ! -d "$HOME/.oh-my-zsh" ] && \
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" \
"" --unattended || true
  # Install Zsh syntax highlighting
  rm -rf $HOME/.oh-my-zsh/plugins/zsh-syntax-highlighting 2>/dev/null || true
  git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git \
$HOME/.oh-my-zsh/plugins/zsh-syntax-highlighting
  # Install powerlevel10k theme
  [ ! -d "$HOME/.oh-my-zsh/themes/powerlevel10k" ] && git clone --depth=1 \
https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/themes/powerlevel10k || true
}

# Set ZSH as default shell:
function change_shell() {
  echo "-----> Change shell to zsh"
  chsh -s $(which zsh) || echo "Failed changing shell" && return
}

# Link $HOME dotfiles to .dotfiles folder:
function create_links() {
  echo "-----> Create symlinks"
  declare -A src2dest
  src2dest[".bashrc"]="$HOME/.bashrc"
  src2dest[".zshrc"]="$HOME/.zshrc"
  src2dest[".p10k.zsh"]="$HOME/.p10k.zsh"
  src2dest[".gitconfig"]="$HOME/.gitconfig"
  src2dest[".ssh/config"]="$HOME/.ssh/config"
  src2dest[".tmux.conf"]="$HOME/.tmux.conf"
  src2dest[".vimrc"]="$HOME/.vimrc"

  dir=$(dirname "$0")
  backup_dir=$HOME/.dotfiles_backup
  rm -rf $backup_dir
  mkdir -p $backup_dir
  for key in "${!src2dest[@]}"; do
    [ -L "${src2dest[$key]}" ] && rm "${src2dest[$key]}"
    if [ -f "${src2dest[$key]}" ] || [ -d "${src2dest[$key]}" ]; then
      echo "Backing up original file: ${src2dest[$key]}"
      temp_dir=$(dirname ${src2dest[$key]})
      mkdir -p "$backup_dir/$temp_dir"
      mv -f "${src2dest[$key]}" "$backup_dir/$temp_dir"
    fi
    ln -sr "$dir/$key" "${src2dest[$key]}" || echo "Can not create symlink. File still exists at \
${src2dest[$key]}"
  done
  rmdir $backup_dir || echo "Old dotfiles where backed up to $backup_dir"
}

# Install nvm and then npm and yarn:
function install_nvm_npm_yarn() {
  local node_version=14
  ! command -v node &>/dev/null || [[ "$(node -v)" != *"$node_version"* ]] || return 0
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
  source ~/.nvm/nvm.sh
  nvm install ${node_version}
  nvm alias default
  nvm use default
  npm install --global yarn
}

# Create vim undo directory for temporary vim files:
function create_vim_undo_dir() {
  echo "-----> Create vim undo directory"
  mkdir -p "$HOME/.vim/undodir"
}

# Run vim :PlugInstall to install vim plugins:
function install_vim_plugins() {
  echo "-----> Install vim plugins"
  vim +PlugInstall +qall!
}

# Install tmux plugin manager and plugins on initial setup:
function install_tmux_plugins() {
  if [[ -v TMUX && "$TMUX" != "" ]]; then
    return 0;
  fi
  echo "-----> Install tmux plugin manager"
  TMUX_DIR=${HOME}/.tmux
  rm -rf "${TMUX_DIR}/plugins/tpm" 2>/dev/null || true
  git clone --depth=1 https://github.com/tmux-plugins/tpm ${TMUX_DIR}/plugins/tpm && \
bash ${TMUX_DIR}/plugins/tpm/bin/install_plugins
}

# Manually install ripgrep until https://bugs.launchpad.net/ubuntu/+source/rust-bat/+bug/1868517 is solved
function install_ripgrep() {
  apt-get download ripgrep
  sudo dpkg --force-overwrite -i ripgrep*.deb
  rm -f ripgrep*
}

# Force generate en_GB and en_US locales
function generate_locale() {
  sudo locale-gen en_GB.UTF-8 en_US.UTF-8
}

# Run script:
if [[ "$(id -u)" == 0 ]]; then
  echo "$BASH_SOURCE: Please run as non-root" >&2
  exit 1
fi

if [ ! -d $HOME ]; then
  echo "Home directory doesn't exist or \$HOME variable not set"
  exit 1
fi

umask g-w,o-w

if [[ "$(</proc/version)" == *[Mm]icrosoft* ]] 2>/dev/null; then # Check if WSL
  echo "WSL detected"
  install_packages_in_wsl
  remove_packages
  install_java
  install_go
  copy_custom_fonts
  beautify_shell
  change_shell
  create_links
  install_nvm_npm_yarn
  create_vim_undo_dir
  install_vim_plugins
  install_tmux_plugins
  install_ripgrep
elif [[ "$(uname -s)" == *[Ll]inux* ]] 2>/dev/null; then # Check if Linux or Darwin (MacOS)
  echo "Linux detected"
  # Selection menu:
  COLUMNS=1
  echo "Options:"
  PS3="Please select a number and press Enter: "
  options=(
  "Full installation, visual aspects like applets and themes, i/o drivers, cinnamon configuration"
  "Minimal installation, suitable for virtual machines"
  "Exit")
  select opt in "${options[@]}"
  do
    case $opt in
      "Full installation, visual aspects like applets and themes, i/o drivers, cinnamon configuration")
        echo "Full installation"
        check_ssh_key
        install_corsair_drivers
        install_logitech_software
        install_spotify
        accept_ms_eula
        install_packages
        remove_packages
        install_applets_and_extensions
        load_dconf_files
        edit_gnome_terminal_shortcuts
        install_java
        install_go
        copy_custom_fonts
        beautify_shell
        change_shell
        create_links
        install_nvm_npm_yarn
        create_vim_undo_dir
        install_vim_plugins
        install_tmux_plugins
        install_ripgrep
        break
        ;;
      "Minimal installation, suitable for virtual machines")
        echo "Minimal installation"
        accept_ms_eula
        install_minimal_packages
        remove_packages
        install_java
        install_go
        copy_custom_fonts
        beautify_shell
        change_shell
        create_links
        install_nvm_npm_yarn
        create_vim_undo_dir
        install_vim_plugins
        install_tmux_plugins
        install_ripgrep
        generate_locale
        break
        ;;
      "Exit")
        exit 0
        ;;
      *) echo "Invalid option $REPLY";;
    esac
  done
else
  echo "MacOS detected"
  check_ssh_key
  install_macos_packages
  install_java
  beautify_shell
  create_links
  install_nvm_npm_yarn
  create_vim_undo_dir
  install_vim_plugins
  install_tmux_plugins
fi

echo "Success"
echo "Please reboot to apply all changes"
