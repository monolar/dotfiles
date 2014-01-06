##############################
# Capistrano bash-completion #
##############################
_capcomplete() {
    if [ ! -e Capfile ]; then
        return
    fi
    complete -W "$(cap -T | grep '#' | awk 'NR != 1 {print $2}')" cap
    return 0
}
complete -o default -o nospace -F _capcomplete cap
