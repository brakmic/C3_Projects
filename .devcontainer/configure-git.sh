#!/usr/bin/env bash
# Applies the repository owner's Git identity and SSH commit signing.
# postAttachCommand copies the host SSH keys before this script runs.
set -euo pipefail

name="Harris Brakmic"
email="brakmic@gmail.com"
signing_key="$HOME/.ssh/id_ed25519_signing_acer.pub"
allowed_signers="$HOME/.ssh/allowed_signers"

git config --global user.name "$name"
git config --global user.email "$email"

if [ -f "$signing_key" ] && [ -f "$allowed_signers" ]; then
  git config --global gpg.format ssh
  git config --global user.signingkey "$signing_key"
  git config --global gpg.ssh.allowedSignersFile "$allowed_signers"
  git config --global commit.gpgsign true
  git config --global tag.gpgsign true
  echo "Git identity and SSH commit signing configured for $email."
else
  echo "WARNING: SSH signing key or allowed_signers file missing; commits will not be signed." >&2
  echo "Mount the host ~/.ssh directory and rebuild the container." >&2
fi
