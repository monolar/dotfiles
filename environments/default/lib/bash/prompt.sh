last_state() {
  if [ $? = 0 ];
    then
      echo "✔";
    else
      echo -en "✘";
    fi
}

export PS1='\[\e[02;32m\]\u@\h:\[\e[0m\]\[\e[01;36m\]\W\[\e[0m\] $(last_state) \[\e[02;33m\][$(current_rvm)]\[\e[0m\]\[\e[01;35m\]$(git_prompt)\[\e[0m\] \[\e[01;33m\]$\[\e[0m\] '

powerline_start() {
  . /usr/local/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh
}
