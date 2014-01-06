last_state() {
  if [ $? = 0 ];
    then
      # echo "😊 ";
      echo -e "\e[32m✔";
    else
      # echo "😕 ";
      echo -e "\e[31m✘";
    fi
}

export PS1='\[\e[01;32m\]\u@\h:\[\e[01;34m\]\W \[\e[01;36m\]$(last_state) \[\e[01;33m\][rvm:$(current_rvm)] $(git_prompt)\[\e[01;33m\]$\[\e[0m\] '
