# man pages
pman() {
    mandoc -T pdf "$(/usr/bin/man -w $@)" | open -fa Preview
}

# Vim in less mode alias
alias vless="$(brew --prefix vim)/share/vim/vim91/macros/less.sh"

# ls aliasses
alias ls="ls --color=auto"
# alias la="ls --color=auto -laF"
alias la="colourify -es --colour=auto -- ls -la --color=always --time-style=long-iso --human-readable"

alias prettyjson='python -m json.tool'

# start screensaver shortcut
alias sc="open -a ScreenSaverEngine.app"
