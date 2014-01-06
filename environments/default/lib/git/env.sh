###############
# GIT SUPPORT #
###############

# Returns "*" if the current git branch is dirty.
function parse_git_dirty {
    [[ $(git diff --shortstat 2> /dev/null | tail -n1) != "" ]] && echo -e "♦"
}

# Returns "|shashed:N" where N is the number of stashed states (if any).
function parse_git_stash {
    local stash=`expr $(git stash list 2>/dev/null| wc -l)`
    if [ "${stash}" != "0" ]
    then
        echo -e "|stashed:$stash"
    fi
}

# Get the current git branch name (if available)
git_prompt() {
    local ref=$(git symbolic-ref HEAD 2>/dev/null | cut -d'/' -f3)
    if [ "${ref}" != "" ]
    then
        echo -e " ($ref$(parse_git_dirty)$(parse_git_stash))"
    fi
}
