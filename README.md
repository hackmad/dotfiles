# dotfiles

.files

# Vim Polyglot IDE

See the `.vimrc` file in this repo.

## Fonts

These fonts are nice to have and can be used for vim-devicons plugin:

- [Powerline Fonts](https://github.com/powerline/fonts)
- [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts)

### [vim-plug](https://github.com/junegunn/vim-plug)

- Reload changes to vimrc: source \$MYVIMRC
  - Necessary for installing, updating and cleaning plugins

## Install

This works best with [neovim](https://github.com/neovim/neovim/wiki/Installing-Neovim)

Install the following dependencies:

- [yarn](https://yarnpkg.com/en/docs/install)
- `brew install fd`
- `brew install fzf`
- `brew install xclip`
- `brew install ccls`
- `brew install cmake`
- `cargo install proximity-sort`
- `pip3 install --user jedi`
- `pip3 install --user pynvim`
- `pip3 install --upgrade neovim`

You can symlink the configuration in `./nvim` to `~/.config/nvim` (on MacOS):

```bash
ln -s <path-to-dotfiles>/nvim ~/.config/nvim
```

For opinionated configs:

1. See [LunarVim](https://www.lunarvim.org/)

   ```bash
   ln -s <path-to-dotfiles>/lunarvim/lvim ~/.config/lvim
   ```

1. See [AstroNvim](https://rusty-ferris.pages.dev/blog/using-nvim-for-rust-development/)

   ```bash
   ln -s <path-to-dotfiles>/astronvim/lua/user ~/.config/nvim/lua/user
   ```

## Erlang install via asdf

Install dependencies:

```
brew install autoconf wxmac openssl fop coreutils automake libyaml readline libxslt libtool unixodbc unzip curl
```

Set compiler options:

```
export CFLAGS="-O2 -g -fno-stack-check"
```

Set kerl options:

```
export KERL_CONFIGURE_OPTIONS="--disable-hipe --with-ssl=$(brew --prefix openssl)"
```

If the above fails or you don't have Java:

```
export KERL_CONFIGURE_OPTIONS="--disable-hipe --without-javac --with-ssl=$(brew --prefix openssl)"
```

Install erlang:

```
asdf install erlang 22.3
asdf global erlang 22.3
```

## erlang_ls

```
asdf plugin-add rebar https://github.com/Stratus3D/asdf-rebar.git
asdf list-all rebar
asdf install rebar 3.12.0
asdf global rebar 3.12.0

git clone https://github.com/erlang-ls/erlang_ls
cd erlang_ls
make
```

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

[Vimspector](https://github.com/puremourning/vimspector#quick-start) is already
in `.vimrc` using Plug.

Install gadgets. `.vimrc` already has `vimspector_install_gadgets` set to ones
for Python, C++ and Rust.

```
:VimspectorInstall
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

## Alacritty Terminal

- [Setup Tutorial](https://clubmate.fi/alacritty)
- [Setup with tmux](https://arslan.io/2018/02/05/gpu-accelerated-terminal-alacritty/)

