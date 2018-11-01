# Dotfiles

## Setup

* Execute `brew.sh` in the selected environment and potentially follow instructions
* Execute `os_x.sh` in the selected environment and potentially follow instructions


* Link the environment selected (e.g. `environments/default`)  via:
 <pre>
  ln -s `&lt;your/checkout/path&gt;`/environments/default/.bash_profile ~/.bash_profile
  ln -s `&lt;your/checkout/path&gt;`/environments/default/.bash_sessions_disable ~/.bash_sessions_disable
  ln -s `&lt;your/checkout/path&gt;`/environments/default/.gitconfig ~/.gitconfig
  ln -s ~/dev/dotfiles/environments/default/lib/git/.global_gitignore ~/.global_gitignore
  ln -s `&lt;your/checkout/path&gt;`/environments/default/.grc ~/.grc
  ln -s `&lt;your/checkout/path&gt;`/environments/default/.vim ~/.vim
  
  ln -s `&lt;your/checkout/path&gt;`/environments/default/.tmux/ ~/.tmux
  ln -s ~/.tmux/.tmux.conf ~/.tmux.conf
 </pre>

* initiate git submodules (`git submodule update --init --recursive`) for vim-settings and tpm

### Bash / Fish

* Default login bash might need to be set via

```
sudo echo /usr/local/bin/bash >> /etc/shells
sudo echo /usr/local/bin/fish >> /etc/shells

# Set default shell to bash...
chsh -s /usr/local/bin/bash
```

### tmux

* Install tmux plugins via `Prefix + I` (`CRTL+B` is tmux default but we are using `CTRL-A`)

### vim

* Install all plugins by calling `:PluginInstall` from within vim (may complain because of missing plugins, like e.g. color-scheme)

* YouCompleteMe may need compilation: `./install.py` (may take quite some time)
