# Nick's Dotfiles

Personal configuration files, managed with symlinks.

## Setup

Clone this repo and run the setup script:

```bash
git clone git@github.com:nickboyce/dotfiles.git ~/Code/dotfiles
cd ~/Code/dotfiles
./setup.sh
```

## Contents

- `cursorrules` - Global rules for Cursor AI agents (task workflow, git practices, etc.)
- `setup.sh` - Script to create symlinks

## Adding New Dotfiles

1. Add the file to this repo
2. Update `setup.sh` to create the symlink
3. Commit and push
