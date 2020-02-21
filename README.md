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
- coc-erlang 
- coc-rls (rust)
- coc-tsserver (typescript) 
- coc-json 
- coc-git 
- coc-prettier

Install [yarn](https://yarnpkg.com/en/docs/install)
