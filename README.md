# dotfiles

A Brewfile that captures all the apps and CLI tools on Nick's Mac, so a fresh Mac can be set up with a single command.

## Set up a new Mac

Paste this into Terminal. It installs Homebrew (which also installs Xcode Command Line Tools), clones this repo, and installs everything in the Brewfile.

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" && \
eval "$(/opt/homebrew/bin/brew shellenv)" && \
git clone https://github.com/nickboyce/dotfiles.git ~/.dotfiles && \
cd ~/.dotfiles && \
brew bundle install
```

You'll need to:

- Sign in to the **Mac App Store** before running, so `mas` can install the App Store apps.
- Run `git config --global user.name "Nick Boyce"` and `git config --global user.email nick@trampoline.agency` afterwards.

## Apps that aren't in Homebrew

Download these manually:

- **DaVinci Resolve** — https://www.blackmagicdesign.com/products/davinciresolve
- **Blackmagic RAW Player** and **Proxy Generator** — bundled with the DaVinci Resolve installer
- **Google Docs / Sheets / Slides** — auto-installed by Google Drive

## Updating the Brewfile

On the existing Mac, run this from the repo root to capture the current state:

```sh
brew bundle dump --force
```

Then review the diff, remove anything you don't want to carry forward, commit, push.
