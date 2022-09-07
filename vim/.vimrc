" =============================================================================
" Manage plugins: vim-plug

call plug#begin('~/.vim/plugged')
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/nerdfont.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
Plug 'lambdalisue/glyph-palette.vim'
Plug 'lambdalisue/fern-git-status.vim'
Plug 'joshdick/onedark.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'derekwyatt/vim-scala'
Plug 'elixir-editors/vim-elixir'
Plug 'mhinz/vim-mix-format'
Plug 'hyhugh/coc-erlang_ls', {'do': 'yarn install --frozen-lockfile'}
Plug 'rust-lang/rust.vim'
Plug 'vim-syntastic/syntastic'
Plug 'universal-ctags/ctags'
Plug 'preservim/tagbar'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'nvim-lualine/lualine.nvim'
call plug#end()
 
" =============================================================================
" Onedark theme + override
"
let g:onedark_color_overrides = {
            \ "background": {"gui": "#080808", "cterm": "232", "cterm16": "0" }
            \}

" onedark.vim override: Don't set a background color when running in a terminal;
" just use the terminal's background color
" `gui` is the hex color code used in GUI mode/nvim true-color mode
" `cterm` is the color code used in 256-color mode
" `cterm16` is the color code used in 16-color mode
if (has("autocmd") && !has("gui_running"))
  augroup colorset
    autocmd!
    autocmd ColorScheme * call onedark#set_highlight("LineNr", { "fg": { "gui": "#8a8a8a", "cterm": "245", "cterm16" : "15" } })
    autocmd ColorScheme * call onedark#set_highlight("ColorColumn", { "bg": { "gui": "#121212", "cterm": "233", "cterm16" : "7" } })
    autocmd ColorScheme * call onedark#set_highlight("Comment", { "fg": { "gui": "#00af00", "cterm": "34", "cterm16" : "2" } })
    autocmd ColorScheme * call onedark#set_highlight("SpecialComment", { "fg": { "gui": "#00af00", "cterm": "34", "cterm16" : "2" } })
  augroup END
endif

colorscheme onedark

" =============================================================================
" Configure non plugin related stuff

" Set line number and text encoding
set number
set encoding=utf8  

" Automatically reload changed files
set autoread

" Clear screen on exit
au VimLeave * :!clear

" Right margin at 80 characters
set cc=120

" Setup tabs
set tabstop=4     " Size of a hard tabstop (ts).
set shiftwidth=4  " Size of an indentation (sw).
set expandtab     " Always uses spaces instead of tab characters (et).
set softtabstop=0 " Number of spaces a <Tab> counts for. When 0, featuer is off
set autoindent    " Copy indent from current line when starting a new line.
set smarttab      " Inserts blanks on a <Tab> key (as per sw, ts and sts).

" Mouse
if has('mouse')
    set mouse=a
endif

if (has("termguicolors"))
    set termguicolors
endif

if has('gui_running')
    if has('gui_macvim')
        set macligatures
        set antialias
    endif

    set guifont=FiraCodeNerdFontComplete-Light:h14
endif

" Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

" Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" =============================================================================
" Fern

let g:fern#drawer_width = 30
let g:fern#renderer = "nerdfont"

let g:fern#mark_symbol                       = '●'
let g:fern#renderer#default#collapsed_symbol = '▷ '
let g:fern#renderer#default#expanded_symbol  = '▼ '
let g:fern#renderer#default#leading          = ' '
let g:fern#renderer#default#leaf_symbol      = ' '
let g:fern#renderer#default#root_symbol      = '~ '

noremap <silent> <Leader>d :Fern . -drawer -width=30 -toggle<CR><C-w>=
noremap <silent> <Leader>t :Fern . -drawer -width=30 -reveal=%<CR><C-w>=
noremap <silent> <Leader>. :Fern %:h -drawer -width=30<CR><C-w>=

augroup my-glyph-palette
  autocmd! *
  autocmd FileType fern call glyph_palette#apply()
  autocmd FileType nerdtree,startify call glyph_palette#apply()
augroup END

function! FernInit() abort
  nmap <buffer><expr>
        \ <Plug>(fern-my-open-expand-collapse)
        \ fern#smart#leaf(
        \   "\<Plug>(fern-action-open:select)",
        \   "\<Plug>(fern-action-expand)",
        \   "\<Plug>(fern-action-collapse)",
        \ )
  nmap <buffer> <CR> <Plug>(fern-my-open-expand-collapse)
  nmap <buffer> <2-LeftMouse> <Plug>(fern-my-open-expand-collapse)
  nmap <buffer> m <Plug>(fern-action-mark:toggle)j
  nmap <buffer> N <Plug>(fern-action-new-file)
  nmap <buffer> K <Plug>(fern-action-new-dir)
  nmap <buffer> D <Plug>(fern-action-remove)
  nmap <buffer> C <Plug>(fern-action-copy)
  nmap <buffer> M <Plug>(fern-action-move)
  nmap <buffer> R <Plug>(fern-action-rename)
  nmap <buffer> s <Plug>(fern-action-open:split)
  nmap <buffer> v <Plug>(fern-action-open:vsplit)
  nmap <buffer> r <Plug>(fern-action-reload)
  nmap <buffer> H <Plug>(fern-action-hidden)
  nmap <buffer> <nowait> d <Plug>(fern-action-hidden:toggle)
  nmap <buffer> <nowait> < <Plug>(fern-action-leave)
  nmap <buffer> <nowait> > <Plug>(fern-action-enter)
endfunction

augroup FernEvents
  autocmd!
  autocmd FileType fern call FernInit()
augroup END

augroup FernTypeGroup
    autocmd! * <buffer>
    autocmd BufEnter <buffer> silent execute "normal \<Plug>(fern-action-reload)"
augroup END

" =============================================================================
" Fzf

" Preview window on the upper side of the window with 40% height, hidden by 
" default, ctrl-/ to toggle
let g:fzf_preview_window = ['up:40%:hidden', 'ctrl-/']

" =============================================================================
" Lualine

if has('nvim')
    lua << END
require'lualine'.setup()
END
endif

" =============================================================================
" Vimspector

let g:vimspector_enable_mappings = 'VISUAL_STUDIO'
let g:vimspector_install_gadgets = [ 'debugpy', 'vscode-go', 'CodeLLDB' ]
nmap <leader>dd :call vimspector#Launch()<CR>
nmap <leader>dx :VimspectorReset<CR>
nmap <leader>de :VimspectorEval
nmap <leader>dw :VimspectorWatch
nmap <leader>do :VimspectorShowOutputlet 

" =============================================================================
" Elixir options

let g:mix_format_on_save = 1
let g:mix_format_options = '--check-equivalent'

" =============================================================================
" Rust options

let g:rustfmt_autosave = 1
let g:rustfmt_emit_files = 1

" =============================================================================
" Configuration for coc.nvim

autocmd BufRead,BufNewFile *.sbt set filetype=scala
autocmd FileType json syntax match Comment +\/\/.\+$+
let g:scala_scaladoc_indent = 1


set hidden

" Some servers have issues with backup files
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have a bad experience with diagnostic messages with the default 4000.
set updatetime=300

" Don't give |ins-completion-menu| messages.
set shortmess+=c

" Used in the tab autocompletion for coc
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Used to expand decorations in worksheets
nmap <Leader>ws <Plug>(coc-metals-expand-decoration)

" Use K to either doHover or show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType scala setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add status line support, for integration with other plugin, checkout `:h coc-status`
"set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" Toggle panel with Tree Views
nnoremap <silent> <space>t :<C-u>CocCommand metals.tvp<CR>
" Toggle Tree View 'metalsBuild'
nnoremap <silent> <space>tb :<C-u>CocCommand metals.tvp metalsBuild<CR>
" Toggle Tree View 'metalsCompile'
nnoremap <silent> <space>tc :<C-u>CocCommand metals.tvp metalsCompile<CR>
" Reveal current current class (trait or object) in Tree View 'metalsBuild'
nnoremap <silent> <space>tf :<C-u>CocCommand metals.revealInTreeView metalsBuild<CR>

" =============================================================================
" Configuration for coc-prettier

command! -nargs=0 Prettier :CocCommand prettier.formatFile
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
