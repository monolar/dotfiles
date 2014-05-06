# Nimrod itself
PATH="/opt/nimrod/bin:$PATH"

# Babel package manager
PATH="~/.babel/bin:$PATH"

update_nimrod() {
  echo "updating nimrod..."
  cd ~/git/Nimrod
  git pull
  cd csources
  git pull
  sh build.sh
  cd ..
  bin/nimrod c koch
  ./koch boot -d:release
  echo "done building nimrod"
  echo "install via 'sudo ./koch install /opt'"
}
