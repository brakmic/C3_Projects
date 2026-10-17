#!/usr/bin/env bash
set -euo pipefail

host_ssh_dir=/home/c3dev/.host-ssh
ssh_dir="$HOME/.ssh"

if [[ ! -d "$host_ssh_dir" ]]; then
  echo "ERROR: host SSH directory is not mounted at $host_ssh_dir." >&2
  exit 1
fi

if [[ -z "$(find "$host_ssh_dir" -mindepth 1 -maxdepth 1 -print -quit)" ]]; then
  echo "ERROR: host SSH directory is empty: $host_ssh_dir." >&2
  exit 1
fi

mkdir -p "$ssh_dir"
find "$ssh_dir" -mindepth 1 -maxdepth 1 -exec rm -rf -- {} +
cp -a "$host_ssh_dir/." "$ssh_dir/"
find "$ssh_dir" -type d -exec chmod 700 {} +
find "$ssh_dir" -type f -exec chmod 600 {} +

bash /host_workspace/.devcontainer/configure-git.sh
