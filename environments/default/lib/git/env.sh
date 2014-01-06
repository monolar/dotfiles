###############
# GIT SUPPORT #
###############

# Returns "*" if the current git branch is dirty.
function parse_git_dirty {
    [[ $(git diff --shortstat 2> /dev/null | tail -n1) != "" ]] && echo "🔴 "
}

# Returns "|shashed:N" where N is the number of stashed states (if any).
function parse_git_stash {
    local stash=`expr $(git stash list 2>/dev/null| wc -l)`
    if [ "${stash}" != "0" ]
    then
        echo "|stashed:$stash"
    fi
}

# Get the current git branch name (if available)
git_prompt() {
    local ref=$(git symbolic-ref HEAD 2>/dev/null | cut -d'/' -f3)
    if [ "${ref}" != "" ]
    then
        echo "($ref$(parse_git_dirty)$(parse_git_stash)) "
    fi
}
