#!/usr/bin/env bash

set -euo pipefail

# Install Homebrew packages in selectable groups.

DEFAULT_GROUPS=(core)
SELECTED_GROUPS=()
DRY_RUN=false
INSTALL_ALL=false

function _get_root_permissions() {
  echo "* getting root permissions once at the start..."
  sudo -v

  # Keep the sudo timestamp alive while brew.sh is running.
  while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
}

function _usage() {
  cat <<'EOF'
Usage: ./brew.sh [--list-groups] [--dry-run] [all|GROUP ...]

Examples:
  ./brew.sh
  ./brew.sh --list-groups
  ./brew.sh core communication
  ./brew.sh languages-modern languages-retro creative game-dev
  ./brew.sh --dry-run all

If no groups are provided, the default groups are installed:
  core
EOF
}

function _list_groups() {
  cat <<'EOF'
Available groups:
  core                Essential CLI tools, editors, search, dotfiles, and basic terminals
  languages-modern    Current mainstream languages and their primary tooling
  languages-retro     Historical and still-used languages
  languages-exotic    Functional, JVM-adjacent, niche, and IF languages
  infra               Networking, HTTP, infra, and local service helpers
  databases           Databases, service daemons, and database clients
  cloud               Cloud, container, and VM tools
  java-api            Java runtimes, build tools, and API clients
  devapps             IDEs, Git GUIs, and desktop developer apps
  communication       Messaging and collaboration apps
  browsers            Browsers and productivity apps
  creative            Media, graphics, and asset-creation tools
  game-dev            Game creation and related tools
  gaming              Game launchers and player-facing gaming apps
  system-utils        System inspection and desktop utility apps
  quicklook           Quick Look plugins
EOF
}

function _parse_args() {
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --help|-h)
        _usage
        exit 0
        ;;
      --list-groups)
        _list_groups
        exit 0
        ;;
      --dry-run)
        DRY_RUN=true
        ;;
      all)
        INSTALL_ALL=true
        ;;
      *)
        SELECTED_GROUPS+=("$1")
        ;;
    esac
    shift
  done

  if [[ "$INSTALL_ALL" == true ]]; then
    SELECTED_GROUPS=(
      core
      languages-modern
      languages-retro
      languages-exotic
      infra
      databases
      cloud
      java-api
      devapps
      communication
      browsers
      creative
      game-dev
      gaming
      system-utils
      quicklook
    )
  elif [[ ${#SELECTED_GROUPS[@]} -eq 0 ]]; then
    SELECTED_GROUPS=("${DEFAULT_GROUPS[@]}")
  fi
}

function _require_brew() {
  if ! command -v brew >/dev/null 2>&1; then
    echo "* install homebrew ..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  else
    echo "* update homebrew ..."
    brew update
  fi

  echo "* checking homebrew ..."
  brew doctor
}

function _taps() {
  local taps=(
    # Keep this array ready for third-party taps when needed.
  )

  for i in "${taps[@]}"; do
    echo "tapping '${i}' ..."
    brew tap "$i"
  done
}

function _maybe_upgrade() {
  echo "Do you wish to upgrade all packages?"
  select yn in "Yes" "No"; do
    case $yn in
      Yes ) echo "* Upgrade all packages"; brew upgrade; break;;
      No ) echo "* Continue without upgrading packages"; break;;
    esac
  done
}

function _append_formulae() {
  FORMULAE+=("$@")
}

function _append_casks() {
  CASKS+=("$@")
}

function _collect_group_items() {
  local group="$1"

  case "$group" in
    core)
      _append_formulae \
        bash fish bash-completion2 coreutils binutils grep findutils gnu-tar gawk \
        zoxide grc reattach-to-user-namespace tree watch pick pv eza \
        vim vimpager neovim tmux ranger midnight-commander \
        htop pstree ripgrep fd fzf atuin ctags cloc bat jq jsonpp csvkit \
        git subversion mercurial tig lazygit stow \
        cmake python pyenv pyenv-virtualenv uv \
        gpg direnv
      _append_casks \
        ghostty iterm2 visual-studio-code
      ;;
    languages-modern)
      _append_formulae \
        python pyenv pyenv-virtualenv uv node go rust zig lua \
        rbenv ruby-build openjdk gradle v8 zlib \
        qt pyqt
      _append_casks temurin
      ;;
    languages-retro)
      _append_formulae \
        gcc fpc gnu-cobol tcl-tk mono
      ;;
    languages-exotic)
      _append_formulae \
        erlang elixir ocaml sbcl guile racket \
        groovy scala kotlin \
        crystal nim stack logtalk inform
      ;;
    infra)
      _append_formulae \
        httpie wget nginx haproxy watchman watchexec \
        graphviz qcachegrind since zopfli lcov
      ;;
    databases)
      _append_formulae \
        sqlite mysql@8.0 mysql-client redis memcached memcache-top neo4j
      _append_casks \
        mysqlworkbench sequel-ace tableplus datagrip dbvisualizer
      ;;
    cloud)
      _append_casks \
        google-cloud-sdk docker virtualbox tunnelblick vyprvpn
      ;;
    java-api)
      _append_formulae gradle
      _append_casks \
        temurin postman insomnia soapui paw cocoarestclient
      ;;
    devapps)
      _append_casks \
        intellij-idea-ce pycharm-ce visual-studio-code \
        github tower sourcetree gitkraken versions
      ;;
    communication)
      _append_casks \
        discord slack adium telegram signal skype whatsapp
      ;;
    browsers)
      _append_casks \
        firefox libreoffice fantastical macdown
      ;;
    creative)
      _append_formulae \
        libtiff libjpeg webp little-cms2 imagemagick cairo gifsicle
      _append_casks \
        xquartz imageoptim licecap gimp krita inkscape tiled fontforge blender audacity vlc
      ;;
    game-dev)
      _append_casks \
        godot tiled blender krita inkscape audacity
      ;;
    gaming)
      _append_casks \
        steam heroic
      ;;
    system-utils)
      _append_casks \
        alacritty servpane clipy onyx disk-inventory-x jewelrybox \
        beyond-compare deltawalker kaleidoscope
      ;;
    quicklook)
      _append_casks \
        qlmarkdown quicklook-json
      ;;
    *)
      echo "Unknown group: $group" >&2
      echo >&2
      _list_groups >&2
      exit 1
      ;;
  esac
}

function _dedupe_formulae() {
  local deduped=()
  local seen_list=" "
  local item

  for item in "${FORMULAE[@]}"; do
    if [[ "$seen_list" != *" ${item} "* ]]; then
      deduped+=("$item")
      seen_list+="${item} "
    fi
  done

  FORMULAE=("${deduped[@]}")
}

function _dedupe_casks() {
  local deduped=()
  local seen_list=" "
  local item

  for item in "${CASKS[@]}"; do
    if [[ "$seen_list" != *" ${item} "* ]]; then
      deduped+=("$item")
      seen_list+="${item} "
    fi
  done

  CASKS=("${deduped[@]}")
}

function _print_selection_summary() {
  echo "* selected groups: ${SELECTED_GROUPS[*]}"
  echo "* formula count: ${#FORMULAE[@]}"
  echo "* cask count: ${#CASKS[@]}"
}

function _install_formulae() {
  if [[ ${#FORMULAE[@]} -eq 0 ]]; then
    return
  fi

  echo "* installing formulae ..."
  if [[ "$DRY_RUN" == true ]]; then
    printf 'brew install %s\n' "${FORMULAE[@]}"
  else
    brew install "${FORMULAE[@]}"
  fi
}

function _install_casks() {
  if [[ ${#CASKS[@]} -eq 0 ]]; then
    return
  fi

  echo "* installing casks ..."
  if [[ "$DRY_RUN" == true ]]; then
    printf 'brew install --cask %s\n' "${CASKS[@]}"
  else
    brew install --cask "${CASKS[@]}"
  fi
}

function _finalize() {
  if [[ "$DRY_RUN" == true ]]; then
    echo "* dry run complete; no packages were installed."
    return
  fi

  echo "Cleaning Brews..."
  brew cleanup

  if command -v rbenv >/dev/null 2>&1; then
    eval "$(rbenv init -)"
  fi
}

_parse_args "$@"

FORMULAE=()
CASKS=()

for group in "${SELECTED_GROUPS[@]}"; do
  _collect_group_items "$group"
done

_dedupe_formulae
_dedupe_casks

_print_selection_summary

if [[ "$DRY_RUN" == true ]]; then
  echo "* dry run mode enabled"
else
  _get_root_permissions
  _require_brew
  _taps
  _maybe_upgrade
fi

_install_formulae
_install_casks
_finalize
