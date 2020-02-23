# dotfiles
.files

# Vim Polyglot IDE

See the `.vimrc` file in this repo.

## Fonts

These fonts are nice to have and can be used for vim-devicons plugin:
- [Powerline Fonts](https://github.com/powerline/fonts)
- [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts)

 
### [vim-plug](https://github.com/junegunn/vim-plug) 

- Reload changes to vimrc: source $MYVIMRC
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

Install [yarn](https://yarnpkg.com/en/docs/install)

## erlang_ls

```
asdf  asdf plugin-add rebar https://github.com/Stratus3D/asdf-rebar.git
asdf list-all rebar
asdf install rebar 3.12.0
asdf local rebar 3.12.0

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

