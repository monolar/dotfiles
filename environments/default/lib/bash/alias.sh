# man pages
pman () {
    man -t "${1}" | open -f -a /Applications/Preview.app
}

# Vim in less mode alias
alias vless="/usr/share/vim/vim73/macros/less.sh"

# ls aliasses
alias ls="ls --color=auto"
alias la="ls --color=auto -laF"

# git shortcut aliasses
alias lg="git log --decorate --graph --oneline"
