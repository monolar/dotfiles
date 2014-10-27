# RVM
# In case we use Jruby we want 1.9 to be the default
# export JRUBY_OPTS=--1.9

current_rvm() {
      echo -en `rvm current`
}

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

[[ -r $rvm_path/scripts/completion ]] && . $rvm_path/scripts/completion
