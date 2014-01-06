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

export PS1='\[\e[02;32m\]\u@\h:\[\e[0m\]\[\e[01;34m\]\W \[\e[01;36m\]$(last_state) \[\e[02;33m\][$(current_rvm)]\[\e[0m\] $(git_prompt)\[\e[01;33m\] $\[\e[0m\] '
