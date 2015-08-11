set nocompatible
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()

filetype on
filetype plugin on
filetype indent on
syntax enable

set background=light
"colorscheme solarized

function! Spellstatus()
    if &spell
        return "[spell]"
    else
        return ""
    endif
endfunction

function! Pastestatus()
    if &paste
        return "[paste]"
    else
        return ""
    endif
endfunction

map <silent> <C-S> :set invspell<CR>
imap <silent> <C-S> <C-O><C-S>
map <silent> <C-D> :set invpaste<CR>
" Heresy!
map <C-A> ^
imap <C-A> <C-O><C-A>
cmap <C-A> <Home>
map <C-E> $
imap <C-E> <C-O><C-E>
cmap <C-E> <End>

set autoindent
set backspace=2
set expandtab
set grepprg=grep\ -nH\ $*
set hls
set laststatus=2
set modelines=1
set ruler
set scrolloff=10
set shiftwidth=4
set shiftround
set showcmd
set softtabstop=4
set spelllang=en_gb
set statusline=[%n]\ %<%f\ %{Spellstatus()}%{Pastestatus()}%{fugitive#statusline()}%h%m%r%=%-14.(l:%l/%L,c:%v\ (%o)%)\ %P
set tabstop=4
set textwidth=78
set nojoinspaces
set nowrap
set listchars+=precedes:<,extends:>
" Case insensitive regexes, unless the regex contains both lower and
" upper-case characters.
set ignorecase
set smartcase

let g:tex_flavor='latex'
let g:Tex_Env_table="\\begin{table}\<cr>\\centering\<cr>\\begin{tabular}{<+dimensions+>}\<cr><++>\<cr>\\end{tabular}\<cr>\\caption{<+Caption text+>}\<cr>\\label{tbl:<+label+>}\<cr>\\end{table}"
let g:Tex_Env_figure="\\begin{figure}\<cr>\\includegraphics{<+file+>}\<cr>\\caption{<+caption+>}\<cr>\\label{fig:<+label+>}\<cr>\\end{figure}"
let g:Tex_Env_frame="\\begin{frame}{<+title+>}\<cr>\\begin{itemize}\<cr>\\item <++>\<cr>\\end{itemize}\<cr>\\end{frame}"
let g:Tex_Env_block="\\begin{block}{<+title+>}\<cr>\\begin{itemize}\<cr>\\item <++>\<cr>\\end{itemize}\<cr>\\end{block}"
let g:Tex_Com_o="\\o{}"
let g:Tex_Com_ctable="\\ctable[botcap,\<cr>caption={<+caption+>},\<cr>label=tbl:<+label+>\<cr>]{<+colspec+>}{<+notes+>}{\<cr>    \\FL\<cr><+table+>\<cr>\\LL\<cr>}"
let g:Tex_Com_multicolumn="\\multicolumn{<+cols+>}{<+colspec+>}{<+row+>}"
let g:Tex_FoldedEnvironments=",frame"
let g:Tex_FoldedMisc="preamble"

let g:slimv_swank_cmd="! tmux new -d 'mlisp -L \"/ltg/arnskj/.vim/bundle/slimv/slime/start-swank.lisp\"'"

dig r. 7771
dig r: 7773
dig l. 7735
dig m. 7747
dig h. 7717
dig n: 7749
dig t. 7789
dig d. 7693
dig n. 7751
dig s. 7779
dig hv 7723

augroup dotvimrc_filetype
    au!
    au BufNewFile,BufRead .tmux.conf*,tmux.conf* setf tmux
augroup end

autocmd! BufNewFile * silent! 0r ~/.vim/template/template.%:e
