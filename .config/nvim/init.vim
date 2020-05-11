let mapleader=","
let maplocalleader="'"

if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ~/.config/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'junegunn/goyo.vim'
Plug 'jreybert/vimagit'
Plug 'vimwiki/vimwiki'
Plug 'bling/vim-airline'
Plug 'tpope/vim-commentary'
Plug 'kovetskiy/sxhkd-vim'
Plug 'rlue/vim-barbaric'
Plug 'jpalardy/vim-slime'
Plug 'mzlogin/vim-markdown-toc'
Plug 'szw/vim-maximizer'
Plug 'VebbNix/dmenufm.vim'
Plug 'ap/vim-css-color'
Plug 'lervag/vimtex'
Plug 'KeitaNakamura/tex-conceal.vim', {'for': 'tex'}
call plug#end()

set bg=light
set go=a
set mouse=a
set nohlsearch
set clipboard=unnamedplus
set ignorecase
set smartcase
" Some basics:
	nnoremap c "_c
	set nocompatible
	filetype plugin on
	syntax on
	set encoding=utf-8
	set number relativenumber
	set linebreak
	" set showbreak=......
	set showcmd
	set shiftwidth=4
	set cindent
	" set colorcolumn=81
	" set wm=10
	" set textwidth=80
	set wrap
" Load vimrc everytime it is saved
	autocmd BufWritePost $MYVIMRC,*.vim source %
" Enable autocompletion:
	set wildmode=longest,list,full
" Disables automatic commenting on newline:
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Apply text width limit to markdown and tex
	" autocmd BufRead,BufNewFile *.md,*.tex setlocal textwidth=80 fo-=l fo+=t
" Goyo plugin makes text more readable when writing prose:
	map <leader>n :Goyo \| set bg=light \| set linebreak<CR>

" Spell-check set to <leader>o, 'o' for 'orthography':
	" setlocal spell
	" set spelllang=en_us
	map <leader>o :setlocal spell! spelllang=en_us<CR>
	" Spellcheck on the fly
	inoremap <C-o> <c-g>u<Esc>[s1z=``a<c-g>u

" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
	set splitbelow splitright

" Shortcutting split navigation, saving a keypress:
	nnoremap <C-h> <C-w>h
	nnoremap <C-j> <C-w>j
	nnoremap <C-k> <C-w>k
	nnoremap <C-l> <C-w>l
	" nnoremap <Tab> :tabn<CR>

" Shortcut for navigation within terminal
	tnoremap <C-j> <C-\><C-n><C-w>j
	tnoremap <C-k> <C-\><C-n><C-w>k
	" tnoremap <Tab> <C-\><C-n>:tabn<CR>

" J in insert mode but reverse
	nnoremap K :keeppatterns substitute/\s*\%#\s*/\r/e <bar> normal! ==<CR>

" Move selection
	xnoremap K :move '<-2<CR>gv-gv
	xnoremap J :move '>+1<CR>gv-gv

" Enter to newline in normal
	nnoremap <CR> o<ESC>

" Resize split windows
	nnoremap `h :vertical-resize -5<CR>
	nnoremap `j :resize +2<CR>
	nnoremap `k :resize -2<CR>
	nnoremap `l :vertical-resize +5<CR>
	tnoremap `h <C-\><C-n>:vertical-resize -10<CR>
	tnoremap `j <C-\><C-n>:resize +2<CR>
	tnoremap `k <C-\><C-n>:resize -2<CR>
	tnoremap `l <C-\><C-n>:vertical-resize +10<CR>
" Better tabbing
	vnoremap > >gv
	vnoremap < <gv

" Check file in shellcheck:
	map <leader>s :!clear && shellcheck %<CR>

" Open my bibliography file in split
	map <leader>b :vsp<space>$BIB<CR>
	map <leader>r :vsp<space>$REFER<CR>

" Replace all is aliased to S.
	nnoremap S :%s//g<Left><Left>

" Compile document, be it groff/LaTeX/markdown/etc.
	map <leader>c :w! \| !compiler <c-r>%<CR>

" Open corresponding .pdf/.html or preview
	map <leader>p :!opout <c-r>%<CR><CR>

" Runs a script that cleans out tex build files whenever I close out of a .tex file.
	autocmd VimLeave *.tex !texclear %

" Ensure files are read as what I want:
	let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
	let g:vimwiki_list = [{'path': '~/vimwiki', 'syntax': 'markdown', 'ext': '.md'}]
	autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
	autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
	autocmd BufRead,BufNewFile *.tex set filetype=tex

" Copy selected text to system clipboard (requires gvim/nvim/vim-x11 installed):
	vnoremap <C-c> "+y
	map <C-p> "+P

" Enable Goyo by default for mutt writting
	" Goyo's width will be the line limit in mutt.
	autocmd BufRead,BufNewFile /tmp/neomutt* let g:goyo_width=80
	autocmd BufRead,BufNewFile /tmp/neomutt* :Goyo \| set bg=light

" Automatically deletes all trailing whitespace on save.
	autocmd BufWritePre * %s/\s\+$//e

" When shortcut files are updated, renew bash and vifm configs with new material:
	autocmd BufWritePost ~/.config/bmdirs,~/.config/bmfiles !shortcuts

" Update binds when sxhkdrc is updated.
	autocmd BufWritePost *sxhkdrc !pkill -USR1 sxhkd
" Run xrdb whenever Xdefaults or Xresources are updated.
	autocmd BufWritePost *Xresources,*Xdefaults !xrdb %

	autocmd BufWritePost config.def.h !rm ./config.h; sudo make install
" Vim-commentary matlab command
	autocmd Filetype matlab setlocal commentstring=%%s

" Solve for lag for tmux when switching mode
	set ttimeoutlen=100
" Activate makefile

" Vimtex setting
	let g:tex_flavor='latex'
	let g:vimtex_view_method='zathura'
	let g:vimtex_quickfix_mode=0
	let g:vimtex_compiler_progname="nvr"
	let g:vimtex_compiler_latexmk = {
	    \ 'options' : [
	    \   '-pdf',
	    \   '-pdflatex="pdflatex --shell-escape %O %S"',
	    \   '-verbose',
	    \   '-file-line-error',
	    \   '-synctex=1',
	    \   '-interaction=nonstopmode',
	    \ ]
	    \}
" Tex-conceal.vim
	set conceallevel=2
	let g:tex_conceal='abdmg'

" Vim-repeat
	silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)


" Spellcheck highlighting
	hi clear SpellBad
	hi SpellBad cterm=bold,underline
	hi clear SpellRare
	hi SpellRare cterm=bold,underline
	hi clear SpellCap
	hi SpellCap cterm=bold,underline
	hi clear SpellLocal
	hi SpellLocal cterm=bold,underline

" Comment italic
	highlight Comment cterm=italic


"""Python
	"autocmd FileType python map <leader>x :w !python<CR>
	autocmd FileType python map <leader>x :10sp term://python %<CR>
	autocmd FileType python nnoremap ,b i(__import__('ipdb').set_trace())
	autocmd FileType python inoremap ,b (__import__('ipdb').set_trace())
	autocmd FileType python let python_highlight_all = 1

"""C
	autocmd FileType c map <leader>x :w !gcc % && ./a.out<CR>

"""Fortran

	" func! FortranRun()
	"     !gfortran % -o %:t:r
	"     call TermToggle(15)
	" endfu
	autocmd FileType fortran nnoremap <leader>x :w  !gfortran % -o %:t:r && ./%:t:r<CR>

" Source Shelbyvimterminal.vim
	source $HOME/.vim/Shelbyvimterminal.vim

" Source snippet.vim
	source $HOME/.vim/snippet/texsnippet.vim
	source $HOME/.vim/snippet/shsnippet.vim
	source $HOME/.vim/snippet/mdsnippet.vim
" Read snippet on the fly
	nnoremap <leader>h :!snippethelp<CR>
" Synctex
	function! Synctex()
	    let vimura_param = " --synctex-forward " . line('.') . ":" . col('.') . ":" . expand('%:p') . " " . substitute(expand('%:p'),"tex$","pdf", "")
	    if has('nvim')
		call jobstart("vimura neovim" . vimura_param)
	    else
		exe "silent !vimura vim" . vimura_param . "&"
	    endif
	    redraw!
	endfunction
	nnoremap <leader>i :call Synctex()<CR>
" Autocompile
	nnoremap <leader>a :!setsid autocomp % &<CR>

" Dmenufm setting
	nnoremap <leader>f :Dmenufm<CR>

" Vim-Slime
" Vim-Slime setting
	let g:slime_python_ipython = 1
	let g:slime_dont_ask_default = 1
	let g:slime_no_mappings = 1
	let g:slime_paste_file="$HOME/.cache/.slime.paste"
	xmap <c-s><c-s> <Plug>SlimeRegionSend
	nmap <c-s><c-s> <Plug>SlimeParagraphSend
	nmap <c-s>c <Plug>SlimeConfig
" X11 -> tabbed
	let g:slime_target = "x11"
	function SlimeOverrideConfig()
	  let b:slime_config = {"window_id": ""}
	  let b:slime_config["window_id"] = system("tabbed-slime")
	endfunction
" neovim terminal setting for Vim-Slime
	" let g:slime_target = "neovim"
	" let g:slime_default_config = {"jobid": "3"}
" tmux setting for Vim-Slime
	" let g:slime_target = "tmux"
	" let g:slime_paste_file = "$HOME/.slime_paste"
	" " Vim-slime autoflil default config
	" let g:slime_default_config = {"socket_name": "default", "target_pane": "1"}
	" let g:slime_preserve_curpos = 0

" Set underline in insert mode
	autocmd InsertEnter * set cul
	autocmd InsertLeave * set nocul
" Tmux
	"Fix Tmux cursor shape issue
	" if exists('$TMUX')
	"     let &t_SI = "\<Esc>Ptmux;\<Esc>\e[5 q\<Esc>\\"
	"     let &t_EI = "\<Esc>Ptmux;\<Esc>\e[2 q\<Esc>\\"
	" else
	"     let &t_SI = "\e[5 q"
	"     let &t_EI = "\e[2 q"
	" endif


" Inkscape setting
	" inoremap <localleader>f <ESC>v^y:!inkfig <C-R>+<CR><ESC><S-V>
	" yank the line and paste as inkfig argument
	" See :help cmdline.txt <C-R> for more detail
	" nnoremap <localleader>f :!edifig<CR>
	" vnoremap <localleader>e y:!latex_table.sh <C-R>+<CR>

" Leave insert mode and save
	" @% denotes for current file name
	" If current file name is not empty string, then save the file whenever leave the insert mode.
	" if @% != ""
	" 	autocmd InsertLeave * write
	" endif


" func! WordProcessor()
  " movement changes
  " map j gj
  " map k gk
  " formatting text
  " setlocal formatoptions=1
  " setlocal noexpandtab
  " setlocal wrap
  " setlocal linebreak
  " spelling and thesaurus
  " setlocal spell spelllang=en_us
  " set thesaurus+=$HOME/.vim/thesaurus/mthesaur.txt
  " complete+=s makes autocompletion search the thesaurus
  " set complete+=s
" endfu
" nnoremap <localleader>w :call WordProcessor()<CR>

" map <c-t> :call DmenuOpen("tabe")<cr>
" map <c-t> :call DmenuOpen("e")<cr>

""" vim-maximizer
" let g:maximizer_default_mapping_key = 'F3'




nnoremap <leader>x :!sh -x %<CR>

autocmd FileType markdown,rmd nnoremap <leader>m :GenTocGFM<CR>

set path+=*
set wildmenu

inoremap <leader>map <c-r>=glob('**/*')<CR>

" set foldmethod=indent

" highlight OverLength ctermbg=red ctermfg=white guibg=#592929
" match OverLength /\%101v.\+/
