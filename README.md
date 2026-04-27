# dotfiles

Captures all the apps, CLI tools, git identity, and shell tweaks on Nick's Mac, so a fresh Mac can be brought up to the same state with one command.

## What's in here

- **`Brewfile`** — every Homebrew formula, cask, and Mac App Store app that should be installed.
- **`gitconfig`** — git `[user]` identity, pulled into `~/.gitconfig` via `include.path`.
- **`post-install.sh`** — wires the gitconfig include into `~/.gitconfig` and adds a managed block to `~/.zshrc` (PATH for `python@3.14`, plus `python3` / `pip3` / `cc` aliases). Idempotent — safe to re-run.

## Setting up a new Mac

Each step below is idempotent. An agent can run them top-to-bottom; a human can paste them one block at a time.

### Before you start

- **Sign in to the Mac App Store.** Required for `mas` to install App Store apps. If `mas account` returns "Not signed in", do this first via the App Store app.
- **Apps not in Homebrew** need a human download:
  - DaVinci Resolve — https://www.blackmagicdesign.com/products/davinciresolve
  - Blackmagic RAW Player + Proxy Generator (bundled with the Resolve installer)
  - Google Docs / Sheets / Slides — auto-installed by Google Drive once it's running

### 1. Install Homebrew (skip if already installed)

```sh
command -v brew >/dev/null || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
```

### 2. Clone this repo

```sh
[ -d ~/.dotfiles ] || git clone https://github.com/nickboyce/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

### 3. Install everything from the Brewfile

```sh
brew bundle install
```

### 4. Run post-install

```sh
./post-install.sh
```

### 5. Verify

```sh
brew bundle check                # "The Brewfile's dependencies are satisfied."
git config user.email            # nick@trampoline.agency
zsh -i -c 'python --version'     # Python 3.14.x
zsh -i -c 'type python3 pip3 cc' # all three reported as aliases
```

If any check fails, stop and investigate — don't paper over it.

## Updating this repo from the current Mac state

```sh
brew bundle dump --force
```

Review the diff, drop anything not worth carrying forward, commit, push.
