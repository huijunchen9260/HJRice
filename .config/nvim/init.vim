let mapleader=","
let maplocalleader="'"

if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ~/.config/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'tpope/vim-surround'
Plug 'junegunn/goyo.vim'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'jreybert/vimagit'
Plug 'LukeSmithxyz/vimling'
Plug 'vimwiki/vimwiki'
Plug 'bling/vim-airline'
Plug 'tpope/vim-commentary'
Plug 'kovetskiy/sxhkd-vim'
" Plugin from Shelby
Plug 'rlue/vim-barbaric'
Plug 'chrisbra/csv.vim'
Plug 'lervag/vimtex'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'dylanaraps/fff.vim'
Plug 'jpalardy/vim-slime'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf.vim'
Plug 'rhysd/vim-grammarous'
 call plug#end()

set bg=light
set go=a
set mouse=a
set nohlsearch
set clipboard=unnamedplus

" Some basics:
	nnoremap c "_c
	set nocompatible
	filetype plugin on
	syntax on
	set encoding=utf-8
	set number relativenumber
	set linebreak
	set showbreak=>>>>
	set showcmd
	" set textwidth=80
	set wrap
" Enable autocompletion:
	set wildmode=longest,list,full
" Disables automatic commenting on newline:
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Goyo plugin makes text more readable when writing prose:
	map <leader>f :Goyo \| set bg=light \| set linebreak<CR>

" Spell-check set to <leader>o, 'o' for 'orthography':
	" setlocal spell
	" set spelllang=en_us
	map <leader>o :setlocal spell! spelllang=en_us<CR>

" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
	set splitbelow splitright


" vimling:
	nmap <leader>d :call ToggleDeadKeys()<CR>
	imap <leader>d <esc>:call ToggleDeadKeys()<CR>a
	nmap <leader>i :call ToggleIPA()<CR>
	imap <leader>i <esc>:call ToggleIPA()<CR>a
	nmap <leader>q :call ToggleProse()<CR>

" Shortcutting split navigation, saving a keypress:
	map <C-h> <C-w>h
	map <C-j> <C-w>j
	map <C-k> <C-w>k
	map <C-l> <C-w>l

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

"""LATEX
	" Word count:
	autocmd FileType tex map <localleader>w :w !detex \| wc -w<CR>
	"" Code snippets
	autocmd FileType tex inoremap ,li <Enter>\item<Space>


" Vim-commentary matlab command
	autocmd Filetype matlab setlocal commentstring=%%s

" Solve for lag for tmux when switching mode
	set ttimeoutlen=100

" Vimtex setting
	let g:tex_flavor='latex'
	let g:vimtex_view_method='zathura'
	let g:vimtex_quickfix_mode=0
	let g:vimtex_compiler_progname="nvr"
	" set conceallevel=1
	" let g:tex_conceal='abdmg'
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


" Spellcheck highlighting
	hi clear SpellBad
	hi SpellBad cterm=bold,underline
	hi clear SpellRare
	hi SpellRare cterm=bold,underline
	hi clear SpellCap
	hi SpellCap cterm=bold,underline
	hi clear SpellLocal
	hi SpellLocal cterm=bold,underline

" Spellcheck on the fly
	inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

"""Python
	"autocmd FileType python map <leader>x :w !python<CR>
	autocmd FileType python map <leader>x :10sp term://python %<CR>
	autocmd FileType python nnoremap ,b i(__import__('ipdb').set_trace())
	autocmd FileType python inoremap ,b (__import__('ipdb').set_trace())
	autocmd FileType python let python_highlight_all = 1

"""C
	autocmd FileType c map <leader>x :w !gcc % && ./a.out<CR>

" Source Shelbyvimterminal.vim
	source $HOME/.vim/Shelbyvimterminal.vim


" csv.vim
	let g:csv_strict_columns = 1

" fff setting
	" Open fff on press of 'f'
	nnoremap <leader>n :F<CR>
	" Vertical split (NERDtree style).
	let g:fff#split = "30vnew"
	" Open split on the left side (NERDtree style).
	let g:fff#split_direction = "nosplitbelow nosplitright"

" Vim-Slime
	let g:slime_target = "tmux"
	let g:slime_paste_file = "$HOME/.slime_paste"
	let g:slime_no_mappings = 1
	" Vim-slime autoflil default config
	let g:slime_default_config = {"socket_name": "default", "target_pane": "1"}
	let g:slime_dont_ask_default = 1
	let g:slime_preserve_curpos = 0
	xmap <c-s><c-s> <Plug>SlimeRegionSend
	nmap <c-s><c-s> <Plug>SlimeParagraphSend
	nmap <c-s>c <Plug>SlimeConfig

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
	inoremap <localleader>f <ESC>v^y:!inkfig <C-R>+<CR><ESC><S-V>
	" yank the line and paste as inkfig argument
	" See :help cmdline.txt <C-R> for more detail
	nnoremap <localleader>f :!edifig<CR>

	vnoremap <localleader>e y:!latex_table.sh <C-R>+<CR>

" Ultisnips setting
	let g:UltiSnipsExpandTrigger = '<tab>'
	let g:UltiSnipsJumpForwardTrigger = '<tab>'
	let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
	" let g:UltiSnipsSnippetsDir="/home/shelby/.config/nvim/snips"
	let g:UltiSnipsSnippetDirectories=["UltiSnips", $HOME.'/.config/nvim/snips']


" Leave insert mode and save
	" @% denotes for current file name
	" If current file name is not empty string, then save the file whenever leave the insert mode.
	if @% != ""
		autocmd InsertLeave * write
	endif



func! WordProcessor()
  " movement changes
  map j gj
  map k gk
  " formatting text
  setlocal formatoptions=1
  setlocal noexpandtab
  setlocal wrap
  setlocal linebreak
  " spelling and thesaurus
  setlocal spell spelllang=en_us
  set thesaurus+=$HOME/.vim/thesaurus/mthesaur.txt
  " complete+=s makes autocompletion search the thesaurus
  set complete+=s
endfu
nnoremap <localleader>w :call WordProcessor()<CR>


" Strip the newline from the end of a string
function! Chomp(str)
  return substitute(a:str, '\n$', '', '')
endfunction

" Find a file and pass it to cmd
function! DmenuOpen(cmd)
  let fname = Chomp(system("git ls-files | dmenu -i -l 20 -p " . a:cmd))
  if empty(fname)
    return
  endif
  execute a:cmd . " " . fname
endfunction

" map <c-t> :call DmenuOpen("tabe")<cr>
map <c-t> :call DmenuOpen("e")<cr>

nnoremap K :keeppatterns substitute/\s*\%#\s*/\r/e <bar> normal! ==<CR>

" highlight OverLength ctermbg=red ctermfg=white guibg=#592929
" match OverLength /\%101v.\+/

" LanguageTool Setting

	"
