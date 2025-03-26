# Completion
if [ -f $(brew --prefix)/share/bash-completion/bash_completion ]; then
   . $(brew --prefix)/share/bash-completion/bash_completion
fi

#[ -n "$BASH_COMPLETION" ] || BASH_COMPLETION=/usr/local/etc/bash_completion
#[ -n "$BASH_COMPLETION_DIR" ] || BASH_COMPLETION_DIR=/usr/local/etc/bash_completion.d
#[ -n "$BASH_COMPLETION_COMPAT_DIR" ] || BASH_COMPLETION_COMPAT_DIR=/usr/local/etc/bash_completion.d
#readonly BASH_COMPLETION BASH_COMPLETION_DIR BASH_COMPLETION_COMPAT_DIR
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
