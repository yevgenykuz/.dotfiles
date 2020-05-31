#!/bin/bash

# Use this script to automate initial environment setup.
# It is written for an Ubuntu flavored Linux system, and was test with Linux Mint 19.3.

# https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -xueE -o pipefail

# Install Corsair unofficial driver (https://github.com/ckb-next/ckb-next):
function install_corsair_drivers() {
  sudo add-apt-repository -y ppa:tatokis/ckb-next
  sudo apt-get update
  sudo apt install -y ckb-next
}

# Install Logitech unofficial management software (https://github.com/pwr-Solaar/Solaar):
function install_logitech_software() {
  sudo add-apt-repository -y ppa:solaar-unifying/stable
  sudo apt-get update
  sudo apt install -y solaar
}

# Install Debian packages:
function install_packages() {
  echo "Installing packages with apt"
  local packages=(
    curl wget
    git zsh gnome-terminal
    vim nano man
    build-essential zlib1g-dev x11-utils xz-utils
    zip unzip unrar p7zip-full p7zip-rar gzip pigz bzip2
    python-pip python3-pip python3-dev python3-venv
    pandoc python3-docutils rst2pdf
    g++ clang cmake
    ruby-full
    xclip treaceroute
    silversearcher-ag ack gawk
    htop tree
    dos2unix jq
    ascii screenfetch
    dconf-cli dconf-editor
    tmux xfreerdp2-x11 dbus-x11
    flashplugin-installer ttf-mscorefonts-installer
    docker.io
    # fd-find bat fzf ripgrep - uncomment when moving to an OS version based on >20.04 LTS
  )

  sudo apt-get update
  sudo bash -c 'DEBIAN_FRONTEND=noninteractive apt-get -o DPkg::options::=--force-confdef -o DPkg::options::=--force-confold upgrade -y'
  sudo apt-get install -y "${packages[@]}"
  sudo apt-get autoremove -y
  sudo apt-get autoclean
}

# For Ubuntu < 19 LTS - remove when moving to an OS version based on >20.04 LTS:
function install_bat() {
  local v="0.15.0"
  ! command -v bat &>/dev/null || [[ "$(bat --version)" != *" $v" ]] || return 0
  echo "Installing bat $v"
  local deb
  deb="$(mktemp)"
  curl -fsSL "https://github.com/sharkdp/bat/releases/download/v${v}/bat_${v}_amd64.deb" > "$deb"
  sudo dpkg -i "$deb"
  rm "$deb"
}

# For Ubuntu < 19 LTS - remove when moving to an OS version based on >20.04 LTS:
function install_fd() {
  local v="8.0.0"
  ! command -v fd &>/dev/null || [[ "$(fd --version)" != *" $v" ]] || return 0
  echo "Installing fd-find $v"
  local deb
  deb="$(mktemp)"
  curl -fsSL "https://github.com/sharkdp/fd/releases/download/v${v}/fd_${v}_amd64.deb" > "$deb"
  sudo dpkg -i "$deb"
  rm "$deb"
}

# For Ubuntu < 19 LTS - remove when moving to an OS version based on >20.04 LTS:
function install_ripgrep() {
  local v="11.0.2"
  ! command -v rg &>/dev/null || [[ "$(rg --version)" != *" $v" ]] || return 0
  echo "Installing ripgrep $v"
  local deb
  deb="$(mktemp)"
  curl -fsSL "https://github.com/BurntSushi/ripgrep/releases/download/v${v}/fd_${v}_amd64.deb" > "$deb"
  sudo dpkg -i "$deb"
  rm "$deb"
}

# For Ubuntu < 19 LTS - remove when moving to an OS version based on >20.04 LTS:
function install_fzf() {
  ! command -v fzf &>/dev/null || return 0
  echo "Installing latest fzf"
  FZF_DIR="${HOME}/.fzf"
  rm -rf $FZF_DIR 2>/dev/null || true
  git clone --depth=1 https://github.com/junegunn/fzf.git $FZF_DIR
  $FZF_DIR/install --key-bindings --completion --no-update-rc
}

# Install SDKMAN and Java JDK and build tools:
function install_java() {
  echo "Installing SDKMAN! and basic Java dependencies"
  # Install SDKMAN!
  curl -s "https://get.sdkman.io?rcupdate=false" | bash
  source "$HOME/.sdkman/bin/sdkman-init.sh"
  # Install JDKs
  yes | sdk install java 8.0.252.hs-adpt || true
  yes | sdk install java 11.0.7.hs-adpt || true
  sdk default java 11.0.7.hs-adpt || true
  # jdks can be found at: ~/.sdkman/candidates/java
  # Install maven and gradle
  yes | sdk install maven || true
  sdk default maven || true
  # maven can be found at: ~/.sdkman/candidates/maven
  sdk install gradle
  yes | sdk gradle maven || true
  sdk default gradle || true
  # gradle can be found at: ~/.sdkman/candidates/gradle
}

# Install go:
function install_go() {
  local v=1.14.2
  ! command -v go &>/dev/null || [[ "$(go --version)" != *" $v" ]] || return 0
  echo "Installing Go $v"
  dwfile="go${v}.linux-amd64.tar.gz"
  curl -O "https://storage.googleapis.com/golang/${dwfile}"
  sudo rm -rf /usr/local/go
  sudo tar -C /usr/local -xzf $dwfile
  rm $dwfile
}

# Install tmux plugin manager:
function install_tmux_pm() {
  ! command -v tmux &>/dev/null || return 0
  echo "Installing latest tmux plugin manager"
  TMUX_DIR=${HOME}/.tmux
  rm -rf "${TMUX_DIR}/plugins/tpm" 2>/dev/null || true
  git clone --depth=1 https://github.com/tmux-plugins/tpm ${TMUX_DIR}/plugins/tpm
}

# Install RUBY gems for Jekyll for personal github.io page:
function install_ruby_gems_for_jekyll() {
  echo "Installing RUBY gems for Jekyll for personal github.io page"
  gem install jekyll bundler || echo "Failed installing RUBY gems" && return 
}

# Load dconf configuration files:
function load_dconf_files() {
  echo "Loading dconf configuration files"
  # load key bindings:
  dconf load /org/cinnamon/desktop/keybindings/ < $HOME/.dotfiles/dconf-files/dconf-keybindings-settings.conf
  # load gnome-terminal profile:
  dconf load /org/gnome/terminal/legacy/profiles:/ < $HOME/.dotfiles/dconf-files/gnome-terminal-profiles.dconf
  # load cinnamon terminal launcher configuration:
  dconf load /org/cinnamon/desktop/applications/terminal/ < $HOME/.dotfiles/dconf-files/cinnamon-gnome-terminal-launcher.dconf
}

# Edit desktop shortcuts to start GNOME terminal and VIM maximized:
function edit_gnome_terminal_shortcuts() {
  echo "Editing gnome-terminal shortcuts"
  # Edit system menu shortcut:
  cp /usr/share/applications/gnome-terminal.desktop $HOME/.local/share/applications/
  sed -i 's/Exec=gnome-terminal/Exec=gnome-terminal --window --maximize/g' $HOME/.local/share/applications/gnome-terminal.desktop
  # Edit quick-launch panel shortcut:
  cp $HOME/.local/share/applications/gnome-terminal.desktop $HOME/.local/share/applications/org.gnome.Terminal.desktop
  perl -i -0777 -pe 's/Name=New Terminal\nExec=gnome-terminal --window --maximize/Name=New Terminal\nExec=gnome-terminal/g' $HOME/.local/share/applications/org.gnome.terminal.desktop
  perl -i -0777 -pe 's/X-AppStream-Ignore=true/NoDisplay=true\nTerminal=false/g' $HOME/.local/share/applications/org.gnome.terminal.desktop
  # Edit VIM shortcut:
  cp /usr/share/applications/vim.desktop $HOME/.local/share/applications/
  perl -i -0777 -pe "s/Exec=vim %F\nTerminal=true/Exec=gnome-terminal --window --maximize -e 'vim %F'\nTerminal=false/g" $HOME/.local/share/applications/vim.desktop
}

# Beautify ZSH:
function beautify_shell() {
  echo "Beautifying shell"
  # Get shell font
  mkdir -p $HOME/.local/share/fonts
  cd $HOME/.local/share/fonts
  curl -fLo "Sauce Code Pro Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/SourceCodePro/Regular/complete/Sauce%20Code%20Pro%20Nerd%20Font%20Complete.ttf?raw=true
  # Install oh-my-zsh
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  # Install Zsh syntax highlighting
  rm -rf $HOME/.oh-my-zsh/plugins/zsh-syntax-highlighting 2>/dev/null || true
  git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/plugins/zsh-syntax-highlighting
  # Install powerlevel10k theme
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/themes/powerlevel10k
}

# Copy custom fonts:
function copy_custom_fonts() {
  echo "Copying custom fonts"
  mkdir -p $HOME/.local/share/fonts
  yes | cp -fa $HOME/.dotfiles/.local/share/fonts/. $HOME/.local/share/fonts
  sudo fc-cache -f -v
}

# Set ZSH as default shell:
function change_shell() {
  echo "Changing shell to zsh"
  chsh -s $(which zsh) || echo "Failed changing shell" && return 
}

# Link $HOME dotfiles to .dotfiles folder:
function create_links() {
  echo "Creating symlinks"
  declare -A src2dest
  src2dest[".bashrc"]="$HOME/.bashrc"
  src2dest[".zshrc"]="$HOME/.zshrc"
  src2dest[".p10k.zsh"]="$HOME/.zsh"
  src2dest[".gitconfig"]="$HOME/.gitconfig"
  src2dest[".ssh/config"]="$HOME/.ssh/config"
  src2dest[".tmux.conf"]="$HOME/.tmux.conf"
  src2dest[".vimrc"]="$HOME/.vimrc"
  
  dir=$(dirname "$0")
  backup_dir=$HOME/dotfiles_backup
  mkdir -p $backup_dir
  for key in "${!src2dest[@]}"; do
    [ -L "${src2dest[$key]}" ] && rm "${src2dest[$key]}"
    if [ -f "${src2dest[$key]}" ] || [ -d "${src2dest[$key]}" ]; then
      echo "Backing up original file at ${src2dest[$key]}"
      temp_dir=$(dirname ${src2dest[$key]})
      mkdir -p "$backup_dir/$temp_dir"
      mv -f "${src2dest[$key]}" "$backup_dir/$temp_dir"
    fi
    ln -sr "$dir/$key" "${src2dest[$key]}" || echo "Can not create symlink. File still exists at ${src2dest[$key]}"
  done
  rmdir $backup_dir || echo Old dotfiles where backed up to $backup_dir
}

# Run vim :PlugInstall to install vim plugins:
function install_vim_plugins() {
  echo "Installing VIM plugins"
  vim +BundleInstall +qall!
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

if [[ ! -f $HOME/.ssh/id_rsa || ! -f $HOME/.ssh/id_rsa.pub ]]; then
  echo "$BASH_SOURCE: Please put your ssh keys at ~/.ssh and retry" >&2
  exit 1
fi

umask g-w,o-w

install_corsair_drivers
install_packages
install_bat
install_fd
install_ripgrep
install_fzf
install_java
install_go
install_tmux_pm
install_ruby_gems_for_jekyll
load_dconf_files
edit_gnome_terminal_shortcuts
beautify_shell
copy_custom_fonts
change_shell
create_links
install_vim_plugins

echo "Success"
echo "Please log out and log in again to apply changes"
