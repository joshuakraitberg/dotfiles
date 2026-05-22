# shellcheck shell=sh
# Logging functions
log_info() {
  echo "[INFO] $*"
}

log_error() {
  echo "[ERROR] $*" >&2
}

log_warn() {
  echo "[WARN] $*"
}

die() {
  log_error "$*"
  exit 1
}
