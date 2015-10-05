# Dotfiles

## Setup

* Execute `brew.sh` in the selected environment and potentially follow instructions
* Execute `os_x.sh` in the selected environment and potentially follow instructions


* Link the environment selected (e.g. `environments/default`)  via:
 <pre>
  ln -s `<your/checkout/path>`/environments/default/.bash_profile ~/.bash_profile
  ln -s `<your/checkout/path>`/environments/default/.gitconfig ~/.gitconfig
  ln -s ~/dev/dotfiles/environments/default/lib/git/.global_gitignore ~/.global_gitignore
  ln -s `<your/checkout/path>`/environments/default/.grc ~/.grc
  ln -s `<your/checkout/path>`/environments/default/.vim ~/.vim
  ln -s `<your/checkout/path>`/environments/default/.tmux/ ~/.tmux
  ln -s ~/.tmux/.tmux.conf ~/.tmux.conf
 </pre>

* initiate git submodules (tbd) for vim-settings and tpm

### tmux

* Install tmux plugins via `Prefix + I` (`CRTL+B` is tmux default but we are using `CTRL-A`)

### vim

* Install all plugins (tbd)