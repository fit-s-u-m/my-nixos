
{ pkgs, ... }:


with pkgs; [
  cliphist #clipboard manger
  mpvScripts.mpris
  libqalculate # calculater
  youtube-tui # view and download youtube vids in terminal
  yt-dlp # download youtube vids and playlist
  nh # yet another nix helper

  # extraction
  unzip
  zip
  unrar

  #------------ // filemanager  -------------
  lf
  yazi


  #------------ // utils  -------------
  wget # like curl
  git # just git
  killall
  htop # task manger
  ntfs3g # ntfs
  # dunst #  notification daemon
  swaynotificationcenter # notification daemon
  libnotify # send notification from commandline


  #------------ // better  -------------
  eza # better ls
  zoxide # better cd
  bat # better cat
  # terminal muliplexer
  zellij
  tmux
  # finding 
  fzf
  gum
  sesh
  ripgrep

  #------------ // Editor  -------------
  neovim
  vim
  neovide
  vscode
  lazygit

  #------------ // fingerprint  -------------
  usbutils
  fprintd
  libfprint-tod
  libfprint-2-tod1-elan
  libfprint-2-tod1-vfs0090


  #------------ // plugin for zsh  -------------
  carapace
  zplug
  zsh-vi-mode
  atuin # history
  pass # password manager

  stow # manages symbolic links
  tree #shows folder in a tree format

  #------------ //power mangement -------------
  auto-cpufreq # auto utilize cpu
  upower

  # shell
  fish
  nushell
  #------------ // programming  -------------
  docker
  docker-compose
  rustup
  rabbitmq-server
  postgresql
  google-java-format
  jdk17
  maven
  gradle
  # ocaml
  opam
  dune_3
  go
  python3
  # ts
  nodejs_22
  bun

  # compilers
  gcc
  clang
  clang-tools
  meson
  ninja
  gnumake

  fd

  # image viewer for tiling window managers
  imv
  # Conversion between documentation formats
  pandoc

  #sound
  pamixer
  pavucontrol
  #------------ // github commands  -------------
  gh

  #------------ // point less fun commands  -------------
  cowsay # fun cow
  dwt1-shell-color-scripts # shows terminal asci
  cmatrix # make you look nerd 
  parallel # tool for executing jobs in parallel

]
