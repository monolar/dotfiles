# RESET="\[\017\]"
# NORMAL="\[\033[0m\]"
# RED="\[\033[31;1m\]"
# YELLOW="\[\033[33;1m\]"
# WHITE="\[\033[37;1m\]"
#SMILEY="${WHITE}:)${NORMAL}"
#FROWNY="${RED}:(${NORMAL}"
SMILEY="😊 "
FROWNY="😕 "
# SELECT="if [ \$? = 0 ]; then echo \"${SMILEY}\"; else echo \"${FROWNY}\"; fi"

last_state() {
  if [ $? = 0 ];
    then
      #echo ":)";
      echo "${SMILEY}";
    else
      #echo ":(";
      echo "${FROWNY}";
    fi
}

export PS1='\[\e[01;32m\]\u@\h:\[\e[01;34m\]\W \[\e[01;36m\]$(last_state) \[\e[01;33m\][rvm:$(current_rvm)]  \[\e[01;35m\]$(git_prompt)\[\e[01;33m\]$\[\e[0m\] '
