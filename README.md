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
  - Necessary for installing, updating and clearaing plugins

## [coc.vim plugin](https://github.com/neoclide/coc.nvim)

This works best with [neovim](https://github.com/neovim/neovim/wiki/Installing-Neovim)

Install language support with the `:CocInstall` command. This will require a restart of neovim:

- coc-metals (scala)
- coc-python
  - If jedi is already installed re-install it; otherwise install it:
    - pip3 uninstall jedi
    - pip3 install jedi
- coc-go
- coc-elixir
- coc-rls (rust)
- coc-tsserver (typescript)
- coc-json
- coc-git
- coc-prettier

Install the following dependencies:

- [yarn](https://yarnpkg.com/en/docs/install)
- `brew install ripgrep`
- `brew install fzf`
- `pip3 install --user jedi`
- `pip3 install --user pynvim`
- `pip3 install --upgrade neovim`

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

In neovim run the `:CocConfig` to edit `coc-settings.json`. Make sure to update the path to the `elang_ls` binary that was built:

```
{
  "erlang_ls.port": 12345,
  "erlang_ls.erlang_ls_path": "/Users/hyhugh/apps/erlang_ls/_build/default/bin/erlang_ls",
  "erlang_ls.trace.server": "off"
}
```

## Rust

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
