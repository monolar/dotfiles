# man pages
pman () {
    man -t "${1}" | open -f -a /Applications/Preview.app
}

# Vim in less mode alias
alias vless="$(brew --prefix vim)/share/vim/vim74/macros/less.sh"

# ls aliasses
alias ls="ls --color=auto"
# alias la="ls --color=auto -laF"
alias la="colourify -es --colour=auto -- ls -la --color=always --time-style=long-iso --human-readable"

alias prettyjson='python -m json.tool'

# use thefuck
eval $(thefuck --alias)

# start screensaver shortcut
alias sc="open /System/Library/Frameworks/ScreenSaver.framework/Versions/A/Resources/ScreenSaverEngine.app"
