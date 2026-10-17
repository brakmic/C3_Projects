#!/usr/bin/env bash
# Applies the repository owner's Git identity and SSH commit signing.
# postAttachCommand copies the host SSH keys before this script runs.
set -euo pipefail

name="Harris Brakmic"
email="brakmic@gmail.com"
signing_key="$HOME/.ssh/id_ed25519_signing_acer.pub"
private_key="$HOME/.ssh/id_ed25519_signing_acer"
allowed_signers="$HOME/.ssh/allowed_signers"

for required_file in "$signing_key" "$private_key" "$allowed_signers"; do
  if [[ ! -r "$required_file" ]]; then
    echo "ERROR: required Git signing file is missing or unreadable: $required_file" >&2
    exit 1
  fi
done

git config --global user.name "$name"
git config --global user.email "$email"

git config --global gpg.format ssh
git config --global user.signingkey "$signing_key"
git config --global gpg.ssh.allowedSignersFile "$allowed_signers"
git config --global commit.gpgsign true
git config --global tag.gpgsign true
echo "Git identity and SSH commit signing configured for $email."
