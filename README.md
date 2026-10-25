# dotfiles

## Zsh

### Dependencies

**ArchLinux**

```bash
pacman -S eza bat fd fzf zoxide starship ripgrep
```

**macOS**

```bash
brew install eza bat fd fzf zoxide starship ripgrep
```

### Zsh config directory

On ArchLinux use `/etc/zsh/zshenv`.
On MacOS use `/etc/zshenv`.

Add the following to to the `zshenv`:

```bash
if [[ -z "$XDG_CONFIG_HOME" ]]
then
    export XDG_CONFIG_HOME="$HOME/.config"
fi

if [[ -d "$XDG_CONFIG_HOME/zsh" ]]
then
    export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
fi
```

Create required directories:

```bash
mkdir -p ~/.local/state/zsh   # History
mkdir -p ~/.cache/zsh         # Completion cache
ln -s <path-to-dotfiles>/zsh ~/.config/zsh
```

Start new shell and update plugins:

```bash
zplugin-update
```
```

## Tmux

```bash
ln -s <path-to-dotfiles>/tmux.conf ~/.tmux.conf
```

See [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm) for setting up plugins.

## Fonts

These fonts are nice to have and can be used for 'vim-devicons' / `nvim-web-devicons` plugins:

- [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts)
- [Nerd Fonts for Lazyvim/NvChad](https://www.nerdfonts.com/)

```bash
brew tap homebrew/cask-fonts
brew install --cask font-jetbrains-mono-nerd-font
```

## Vim

See `vim/.vimrc` file in this repo for use with `vim`.

## Neovim

Install the following dependencies:

- [yarn](https://yarnpkg.com/en/docs/install)
- `brew install fd`
- `brew install fzf`
- `brew install ripgrep`
- `brew install xclip`
- `brew install ccls`
- `brew install cmake`
- `brew install bear`
- `cargo install proximity-sort`
- `pip3 install --user jedi`
- `pip3 install --user pynvim`
- `pip3 install --upgrade neovim`

You can symlink the configuration in `./nvim` to `~/.config/nvim` (on MacOS):

```bash
ln -s <path-to-dotfiles>/nvim ~/.config/nvim
```

## Rust

- [Install rust](https://www.rust-lang.org/tools/install)
- [Install gdb](https://dev.to/jasonelwood/setup-gdb-on-macos-in-2020-489k)

Change the debugger to `rust-gdb`:

```
:let termdebugger="rust-gdb"
```

Add `.gdbinit`:

```
set startup-with-shell off
```

[Vimspector](https://github.com/puremourning/vimspector#quick-start) is already in the configs.

Install gadgets (the config has `vimspector_install_gadgets` set to ones for Python, C++ and Rust):

```
:VimspectorInstall CodeLLDB
```

Add `.vimspector.jsom` in project root:

```
{
  "configurations": {
    "launch": {
      "adapter": "CodeLLDB",
      "filetypes": ["rust"],
      "configuration": {
        "request": "launch",
        "program": "${workspaceRoot}/target/debug/pbr-rust",
        "args": ["-t", "1", "scenes/test/example.pbrt"],
        "env": {
          "RUST_LOG": "info"
        }
      }
    }
  }
}
```

## CMake / C++

Generate `compile_commands.json` in project folder root which can be used by `clangd` LSP with
`-DCMAKE_EXPORT_COMPILE_COMMANDS=ON`.

```
cmake -D CMAKE_BUILD_TYPE=Debug -S . -B Debug -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
cp Debug/compile_commands.json ./
```

OR use `bear`:

```bash
bear -- cmake -D CMAKE_BUILD_TYPE=Debug -S . -B Debug
```

## git-delta

See [Getting Started](https://github.com/dandavison/delta#get-started) for `~/.gitconfig` changes (not committed in this repo so as not to expose name, email, etc.

```bash
brew install git-delta
```

## lazygit

```bash
ln -s <path-to-dotfiles>/lazygit ~/.config/lazygit
```

