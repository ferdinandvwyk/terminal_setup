set tabstop=4
set expandtab
set shiftwidth=4
set autoindent
set cindent
set colorcolumn=80
set backspace=indent,eol,start

let fortran_free_source=1
let fortran_fold=1

:filetype on
:filetype indent on
:filetype plugin on

set foldmethod=syntax
syntax enable

set wildmode=longest,list

" Remove trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

"Custom shortcuts
:command Sd SyntasticToggleMode
:command Sc SyntasticCheck
:nnoremap <F2> $A #<Esc>YpVkr#p
:map <F7> <Esc>:w <Return>
:map! <F7> <Esc>:w <Return>
:map <F8> <Esc>:w <Return><C-z>
:map! <F8> <Esc>:w <Return><C-z>
:map <F9> <Esc>:wq <Return>
:map! <F9> <Esc>:wq <Return>
:nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

"Use TAB to complete when typing words, else inserts TABs as usual.
""Uses dictionary and source files to find matching words to complete.

"See help completion for source,
""Note: usual completion is on <C-n> but more trouble to press all the time.
"Never type the same word twice and maybe learn a new spellings!
""Use the Linux dictionary when spelling is in doubt.
"Window users can copy the file to their machine.
function! Tab_Or_Complete()
   if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
      return "\<C-N>"
   else
      return "\<Tab>"
   endif
endfunction

:inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>
:set dictionary="/usr/dict/words"

set backup
set backupdir=~/.vim_backup

"Pathogen
execute pathogen#infect()

"Airline customization
let g:syntastic_pylint_checkers=['pylint']
let g:syntastic_python_pylint_post_args='--disable=E0611, C0111'
let g:airline#extensions#tabline#enabled = 1
set laststatus=2
let g:airline_theme = 'solarized'
let g:syntastic_fortran_compiler_options = "-fdefault-real-8 -ffree-form -ffree-line-length-none"
let g:syntastic_python_python_exec = '/local/home/vanwyk/py_envs/py3/bin/python'
let g:riv_fold_auto_update = 0
let g:syntastic_tex_checkers=['chktex']
let g:Tex_PromptedCommands=''
let g:Tex_Env_table ="\\begin{table}\<cr>\\centering\<cr>\\caption{<+Caption text+>}\<cr>\\begin{tabular}{<+dimensions+>}\<cr>\\toprule\<cr><+headings+>\<cr>\\midrule\<cr><+data+>\<cr>\\bottomrule\<cr>\\end{tabular}\<cr>\\label{tab:<+label+>}\<cr>\\end{table}<++>"
let g:syntastic_tex_chktex_args = "-n24 -n8 -n3 -n1"
let g:syntastic_html_tidy_ignore_errors=["'<' + '/' + letter not allowed here"]
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"Solarized
set t_Co=16
let g:solarized_termcolors=16
colorscheme solarized

"LaTeX
let g:tex_flavor='latex'
set grepprg=grep\ -nH\ $*

"Customized indentation for different languages
au FileType ruby setl sw=2 sts=2 et
au FileType python setl sw=4 sts=4 et
au BufRead,BufNewFile *.tex setl sw=2 sts=2 et
au BufRead,BufNewFile *.cls setl sw=2 sts=2 et
au BufRead,BufNewFile *.f?? setl sw=3 sts=3 et
au BufRead,BufNewFile *.rst setl sw=3 sts=3 et
au BufRead,BufNewFile *.html setl sw=2 sts=2 et
au BufRead,BufNewFile *.md setl sw=2 sts=2 et

"No yanking of old text after pasting
vnoremap p "_dP

" Don't screw up folds when inserting text that might affect them, until
" leaving insert mode. Foldmethod is local to the window. Protect against
" screwing up folding when switching between windows.
autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif
