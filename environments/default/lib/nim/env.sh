# Nimrod itself
PATH=/opt/nim/bin:$PATH

# Nimble package manager
PATH=~/.nimble/bin:$PATH

update_nim() {
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

  git clone --depth 1 git://github.com/nim-lang/csources
  cd csources && sh build.sh
  cd ..

  echo "done building nim"
  echo "install via 'sudo ./koch install /opt'"
}
