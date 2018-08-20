# print green output
info() {
  echo $'\e[1;32m'"$@"$'\e[0m'
}

# print yellow output
warn() {
  echo $'\e[1;33m'"$@"$'\e[0m'
}

# print red output
error() {
  echo $'\e[1;31m'"$@"$'\e[0m'
}

# install the brew if not installed yet
brewinstall() {
  echo "==> install $1"
  if ! brew list "$1" 1>/dev/null 2>&1; then
    brew install "$1"
  else
    warn "already installed"
  fi
}

# backup old non-symbolic file
backup() {
  FILE=$1
  BACKUP_FILE="$1-$TIMESTAMP.org"
  if [ -f "$FILE" -a ! -h "$FILE" ]; then
    echo "==> backup $FILE"
    cp -vp "$FILE" "$BACKUP_FILE"
    # log the backup
    echo "$BACKUP_FILE" >> $INSTALL_HOME/package/custom/backup.log
  fi
}

# symlink conf file
linkconf() {
  backup "$2"
  if [ -f "$1" ]; then
    echo "==> link $1"
    ln -Fsv "$1" "$2"
  else
    error "$1 does not exists"
  fi
}
