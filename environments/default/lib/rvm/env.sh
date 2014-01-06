# RVM
[[ -r $rvm_path/scripts/completion ]] && . $rvm_path/scripts/completion
# In case we use Jruby we want 1.9 to be the default
export JRUBY_OPTS=--1.9

current_rvm() {
      echo `rvm current`
}
