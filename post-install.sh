#!/bin/bash
# Setup that the Brewfile can't do on its own.
# Run after `brew bundle install`.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Wire ~/.gitconfig to include this repo's gitconfig (which holds user identity).
GITCONFIG_PATH="$SCRIPT_DIR/gitconfig"
if git config --global --get-all include.path 2>/dev/null | grep -qF "$GITCONFIG_PATH"; then
  echo "git include.path already pointing at $GITCONFIG_PATH — skipping."
else
  git config --global --add include.path "$GITCONFIG_PATH"
  echo "Registered $GITCONFIG_PATH as a git include."
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
