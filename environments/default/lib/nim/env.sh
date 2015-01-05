# Nimrod itself
PATH="/opt/nim/bin:$PATH"

# Babel package manager
PATH="~/.nimble/bin:$PATH"

update_nimrod() {
  echo "updating nim..."
  cd ~/git/Nim
  git pull
  cd csources
  git pull
  sh build.sh
  cd ..
  bin/nim c koch
  ./koch boot -d:release
  echo "done building nim"
  echo "install via 'sudo ./koch install /opt'"
}
