# Nimrod itself
PATH=/opt/nim/bin:$PATH

# Nimble package manager
PATH=~/.nimble/bin:$PATH

update_nimrod() {
  echo "updating nim..."
  cd ~/git/Nim
  if [ -d "csources" ]
  then
    rm -rf csources
  fi

  git pull
  if [ "$1" ]
  then
    echo "switching to tag: ${1}"
    git checkout ${1}
  fi

  sh build.sh

  echo "done building nim"
  echo "install via 'sudo ./koch install /opt'"
}
