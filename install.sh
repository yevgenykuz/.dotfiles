#!/bin/bash

# Use this script to automate initial environment setup.
# It is written for an Ubuntu flavored Linux system, and was tested with Linux Mint 20.04.

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

# Accept EULA for Microsoft fonts before installation:
function accept_ms_eula() {
  echo msttcorefonts msttcorefonts/accepted-mscorefonts-eula select true | sudo debconf-set-selections
}

# Install Debian packages:
function install_packages() {
  echo "Installing packages with apt"
  local packages=(
    curl wget
    git zsh gnome-terminal
    vim nano man feh
    build-essential zlib1g-dev x11-utils xz-utils
    zip unzip unrar p7zip-full p7zip-rar gzip pigz bzip2
    python3-pip python3-dev python3-venv
    pandoc python3-docutils rst2pdf
    g++ clang cmake
    ruby-full
    xclip traceroute
    silversearcher-ag ack gawk
    htop tree blueman
    dos2unix jq thefuck
    ascii screenfetch
    dconf-cli dconf-editor
    tmux freerdp2-x11 dbus-x11
    flashplugin-installer ttf-mscorefonts-installer
    docker.io awscli ec2-ami-tools
    fd-find bat fzf ripgrep
  )

  local packages_to_remove=(
    blueberry
  )

  sudo apt-get update
  sudo bash -c 'DEBIAN_FRONTEND=noninteractive apt-get -o DPkg::options::=--force-confdef -o DPkg::options::=--force-confold upgrade -y'
  sudo apt-get upgrade -y
  sudo apt-get install -y "${packages[@]}" || echo -e " Try cleaning dpkg cache:\n\
  sudo dpkg -i --force-overwrite PROBLEMATIC_PACKAGE_FROM_ERROR_MESSAGE\n\
  To fix broken packages run:\n\
  sudo apt -f install\n\
  Then, run the install.sh script again"
  sudo apt-get remove -y "${packages_to_remove[@]}"
  sudo apt-get autoremove -y
  sudo apt-get autoclean
}

# Change batcat command to bat:
function update_bat_command() {
  mkdir -p ~/.local/bin
  ln -sf /usr/bin/batcat ~/.local/bin/bat
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
  sudo gem install jekyll bundler || echo "Failed installing RUBY gems" && return 
}

# Load dconf configuration files:
function load_dconf_files() {
  echo "Loading dconf configuration files"
  # load key bindings:
  dconf load /org/cinnamon/desktop/keybindings/ < $HOME/.dotfiles/dconf-files/dconf-keybindings-settings.dconf
  # load gnome-terminal profile:
  dconf load /org/gnome/terminal/legacy/profiles:/ < $HOME/.dotfiles/dconf-files/gnome-terminal-profiles.dconf
  # load cinnamon terminal launcher configuration:
  dconf load /org/cinnamon/desktop/applications/terminal/ < $HOME/.dotfiles/dconf-files/cinnamon-gnome-terminal-launcher.dconf
}

# Install SDKMAN and Java JDK and build tools (must be run from zsh):
function install_java() {
  zsh $HOME/.dotfiles/sdkman.sh
}

# Install go:
function install_go() {
  local v=1.15.2
  ! command -v go &>/dev/null || [[ "$(go --version)" != *" $v" ]] || return 0
  echo "Installing Go $v"
  dwfile="go${v}.linux-amd64.tar.gz"
  curl -O "https://storage.googleapis.com/golang/${dwfile}"
  sudo rm -rf /usr/local/go
  sudo tar -C /usr/local -xzf $dwfile
  rm $dwfile
}

# Edit desktop shortcuts to start GNOME terminal and VIM maximized:
function edit_gnome_terminal_shortcuts() {
  echo "Editing gnome-terminal shortcuts"
  mkdir -p $HOME/.local/share/applications
  # Edit system menu shortcut:
  cp /usr/share/applications/org.gnome.Terminal.desktop $HOME/.local/share/applications/gnome-terminal.desktop
  sed -i 's/Exec=gnome-terminal/Exec=gnome-terminal --window --maximize/g' $HOME/.local/share/applications/gnome-terminal.desktop
  # Edit quick-launch panel shortcut:
  cp /usr/share/applications/org.gnome.Terminal.desktop $HOME/.local/share/applications/org.gnome.Terminal.desktop
  perl -i -0777 -pe 's/Name=New Window\nExec=gnome-terminal --window/Name=New Terminal\nExec=gnome-terminal --window --maximize/g' $HOME/.local/share/applications/org.gnome.Terminal.desktop
  perl -i -0777 -pe 's/X-Ubuntu-Gettext-Domain=gnome-terminal/X-Ubuntu-Gettext-Domain=gnome-terminal\nNoDisplay=true\nTerminal=false/g' $HOME/.local/share/applications/org.gnome.Terminal.desktop
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
  yes | cp -fa $HOME/.dotfiles/.local/share/fonts/. $HOME/.local/share/fonts && echo "Done"
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
  src2dest[".p10k.zsh"]="$HOME/.p10k.zsh"
  src2dest[".gitconfig"]="$HOME/.gitconfig"
  src2dest[".ssh/config"]="$HOME/.ssh/config"
  src2dest[".tmux.conf"]="$HOME/.tmux.conf"
  src2dest[".vimrc"]="$HOME/.vimrc"
  
  dir=$(dirname "$0")
  backup_dir=$HOME/.dotfiles_backup
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
  vim +PlugInstall +qall!
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
install_logitech_software
accept_ms_eula
install_packages
update_bat_command
install_tmux_pm
install_ruby_gems_for_jekyll
install_java
install_go
load_dconf_files
edit_gnome_terminal_shortcuts
beautify_shell
copy_custom_fonts
change_shell
create_links
install_vim_plugins

echo "Success"
echo "Please log out and log in again to apply changes"
