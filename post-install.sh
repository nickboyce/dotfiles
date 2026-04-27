#!/bin/bash
# Setup that the Brewfile can't do on its own.
# Run after `brew bundle install`.

set -euo pipefail

# Set global git identity. Identity isn't stored in this repo (it's public);
# pass values via env vars on first run, or skip if already configured.
if [ -n "${GIT_NAME:-}" ] && [ -n "${GIT_EMAIL:-}" ]; then
  git config --global user.name "$GIT_NAME"
  git config --global user.email "$GIT_EMAIL"
  echo "Set global git identity to $GIT_NAME <$GIT_EMAIL>."
elif [ -n "$(git config user.name 2>/dev/null)" ] && [ -n "$(git config user.email 2>/dev/null)" ]; then
  echo "git identity already set ($(git config user.name) <$(git config user.email)>) — skipping."
else
  echo "ERROR: git identity not set. Re-run with:"
  echo "  GIT_NAME='Your Name' GIT_EMAIL='you@example.com' ./post-install.sh"
  exit 1
fi

ZSHRC="$HOME/.zshrc"
START="# >>> dotfiles: shell setup >>>"
END="# <<< dotfiles: shell setup <<<"

if [ -f "$ZSHRC" ] && grep -qF "$START" "$ZSHRC"; then
  echo "Shell setup block already in ~/.zshrc — skipping."
else
  cat >> "$ZSHRC" <<EOF

$START
# Make python / python3 / pip / pip3 resolve to Homebrew's python@3.14
# instead of Apple's bundled Python 3.9.
# libexec/bin gives us unversioned \`python\` and \`pip\`; the aliases cover
# \`python3\` / \`pip3\`, which Homebrew only ships as versioned binaries.
export PATH="/opt/homebrew/opt/python@3.14/libexec/bin:\$PATH"
alias python3=python3.14
alias pip3=pip3.14

alias cc=claude
$END
EOF
  echo "Added shell setup block to ~/.zshrc."
  echo "Open a new terminal (or run \`source ~/.zshrc\`) to pick it up."
fi
