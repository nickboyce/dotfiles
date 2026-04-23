# Nick's Dotfiles

Personal configuration files, organized by topic and managed with symlinks.

Based on [Holman's dotfiles framework](https://github.com/holman/dotfiles), which uses a topic-centric approach to organize configurations.

## topical

Everything's built around topic areas. If you're adding a new area to your
forked dotfiles — say, "Java" — you can simply add a `java` directory and put
files in there. Anything with an extension of `.zsh` will get automatically
included into your shell. Anything with an extension of `.symlink` will get
symlinked without extension into `$HOME` when you run `script/bootstrap`.

## what's inside

Current topics:
- **cursor/**: Global Cursor AI agent rules for task workflow and development practices
- **git/**: Git configuration and aliases
- **zsh/**: Shell configuration
- **bin/**: Utility scripts
- And more from the base Holman framework (customize as needed)

## components

There's a few special files in the hierarchy.

- **bin/**: Anything in `bin/` will get added to your `$PATH` and be made
  available everywhere.
- **topic/\*.zsh**: Any files ending in `.zsh` get loaded into your
  environment.
- **topic/path.zsh**: Any file named `path.zsh` is loaded first and is
  expected to setup `$PATH` or similar.
- **topic/completion.zsh**: Any file named `completion.zsh` is loaded
  last and is expected to setup autocomplete.
- **topic/install.sh**: Any file named `install.sh` is executed when you run `script/install`. To avoid being loaded automatically, its extension is `.sh`, not `.zsh`.
- **topic/\*.symlink**: Any file ending in `*.symlink` gets symlinked into
  your `$HOME`. This is so you can keep all of those versioned in your dotfiles
  but still keep those autoloaded files in your home directory. These get
  symlinked in when you run `script/bootstrap`.

## install

### Fresh Mac (one-liner)

Paste this into Terminal on a new Mac to install Homebrew, clone this repo, and run the full setup:

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" && \
eval "$(/opt/homebrew/bin/brew shellenv)" && \
git clone https://github.com/nickboyce/dotfiles.git ~/.dotfiles && \
cd ~/.dotfiles && \
script/bootstrap && \
script/install
```

What each step does:

1. Installs Homebrew (also pulls Xcode Command Line Tools).
2. Puts `brew` on `PATH` for the current shell session.
3. Clones this repo to `~/.dotfiles`.
4. `script/bootstrap` — symlinks all `*.symlink` files into `$HOME` (gitconfig, zshrc, cursorrules, etc.).
5. `script/install` — runs `brew bundle` (installs everything in the `Brewfile`) and any topic-level `install.sh` scripts.

### Already have Homebrew?

```sh
git clone git@github.com:nickboyce/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
script/bootstrap
script/install
```

### Notes

- The main file you'll want to change right off the bat is `zsh/zshrc.symlink`, which sets up a few paths that'll be different on your particular machine.
- `Brewfile` is where CLI tools, GUI apps (casks), Mac App Store apps (via `mas`), and VS Code/Cursor extensions are declared. Run `brew bundle install` to sync.
- `bin/dot` is a simple script that installs some dependencies, sets sane macOS defaults, and so on. Run it occasionally to keep your environment fresh.

## bugs

I want this to work for everyone; that means when you clone it down it should
work for you even though you may not have `rbenv` installed, for example. That
said, I do use this as _my_ dotfiles, so there's a good chance I may break
something if I forget to make a check for a dependency.

If you're brand-new to the project and run into any blockers, please
[open an issue](https://github.com/holman/dotfiles/issues) on this repository
and I'd love to get it fixed for you!

## thanks

I forked [Ryan Bates](http://github.com/ryanb)' excellent
[dotfiles](http://github.com/ryanb/dotfiles) for a couple years before the
weight of my changes and tweaks inspired me to finally roll my own. But Ryan's
dotfiles were an easy way to get into bash customization, and then to jump ship
to zsh a bit later. A decent amount of the code in these dotfiles stem or are
inspired from Ryan's original project.
