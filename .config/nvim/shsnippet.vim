" Shell script snippet

" Navigation
autocmd FileType sh inoremap ;; <Esc>/<++><CR>"_c4l
autocmd FileType sh nnoremap ;; /<++><CR>"_c4l
autocmd FileType sh vnoremap ;; <Esc>/<++><CR>"_c4l
autocmd FileType sh inoremap ;<tab> <++><Esc>``a
autocmd FileType sh vnoremap ;<tab> <++><Esc>``a

" Navigation between functions
autocmd FileType sh nnoremap ]] /[A-Za-z-_0-9 ]*()[ ]\?{<CR>
autocmd FileType sh nnoremap [[ ?[A-Za-z-_0-9 ]*()[ ]?{<CR>
autocmd FileType sh inoremap ]] /[A-Za-z-_0-9 ]*()[ ]\?{<CR>
autocmd FileType sh nnoremap [[ ?[A-Za-z-_0-9 ]*()[ ]?{<CR>

" Template
autocmd FileType sh inoremap ;#!; #!/bin/sh<CR><CR>
autocmd FileType sh inoremap ;case; case <--> in<CR><++>) <++> ;;<CR>esac<CR><++><Esc>?<--><CR>"_c4l
autocmd FileType sh inoremap ;li; <ESC>o) <++> ;;<ESC>F)i
autocmd FileType sh inoremap ;[]; [  ] <++><ESC>F[la
autocmd FileType sh inoremap ;if; if <-->; then<CR><++><CR>fi<CR><++><Esc>?<--><CR>"_c4l
autocmd FileType sh inoremap ;elif; <ESC>oelif <-->; then<CR><++><Esc>?<--><CR>"_c4l
autocmd FileType sh inoremap ;w; while <-->; do<CR><++><CR>done<CR><++><Esc>?<--><CR>"_c4l
autocmd FileType sh inoremap ;func; <--> () {<CR><tab><++><CR>}<CR><++><Esc>?<--><CR>"_c4l
autocmd FileType sh inoremap ;for; for <--> in <++>; do<CR><++><CR>done<CR><++><Esc>?<--><CR>"_c4l
autocmd FileType sh inoremap ;here; <Space><<- EOF<CR><--><CR>EOF<Esc>?<--><CR>"_c4l
