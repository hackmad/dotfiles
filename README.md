# dotfiles

## Zsh

```bash
ln -s <path-to-dotfiles>/zshrc ~/.zshrc
```

## Tmux

```bash
ln -s <path-to-dotfiles>/tmux.conf ~/.tmux.conf
```

See [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm) for setting up plugins.

## [Zellij Terminal Workspace](https://zellij.dev/)

```bash
brew install zellij
ln -s <path-to-dotfiles>/zellij ~/.config/zellij
```

## [Alacritty Terminal](https://alacritty.org/)

```bash
ln -s <path-to-dotfiles>/alacritty ~/.config/alacritty
```

Setup themes

```bash
git clone https://github.com/alacritty/alacritty-theme ~/.config/alacritty-theme
```

## [Wezterm Terminal](https://wezfurlong.org/wezterm/index.html)

```bash
ln -s <path-to-dotfiles>/wezterm ~/.config/wezterm
```

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

For opinionated configs:

1. [LunarVim](https://www.lunarvim.org/)

   ```bash
   ln -s <path-to-dotfiles>/lunarvim/lvim ~/.config/lvim
   ```

1. [AstroNvim](https://astronvim.com/)

   See [Astronvim Config](https://github.com/hackmad/astronvim-config) repository for setting up Astronvim and clone the config for it.

   Run neovim and install additional language servers:

   ```
   :LspInstall clangd rust_analyzer sumneko_lua cmake marksman vimls
   ```

   Install additional tree sitter:

   ```
   :TSInstall bash cpp c lua markdown rust
   ```

1. [Lazyvim](https://www.lazyvim.org/)

   See [Lazyvim Config](https://github.com/hackmad/lazyvim-config) repository for setting up Lazyvim and clone the config for it.

1. [NvChad](https://nvchad.com)

   See [NvChad Config](https://github.com/hackmad/nvchad-config) repository for setting up NvChad and clone the config for it.

## Rust

[Install rust](https://www.rust-lang.org/tools/install)

[Install gdb](https://dev.to/jasonelwood/setup-gdb-on-macos-in-2020-489k)

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

Add `~/.vim/plugged/vimspector/gadgets/macos/.gadgets.d/lldb-vscode.json`:

```
{
  "adapters": {
    "lldb-vscode": {
      "variables": {
        "LLVM": {
          "shell": "brew --prefix llvm"
        }
      },
      "attach": {
        "pidProperty": "pid",
        "pidSelect": "ask"
      },
      "command": [
        "${LLVM}/bin/lldb-vscode"
      ],
      "env": {
        "LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY": "YES"
      },
      "name": "lldb"
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
