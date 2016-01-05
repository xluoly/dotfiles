set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
"Plugin 'user/L9', {'name': 'newL9'}
Plugin 'scrooloose/nerdtree'  "文件浏览
Plugin 'majutsushi/tagbar'    "代码符号
Plugin 'wesleyche/SrcExpl'    "类似sourceInsight的代码预览窗口
Plugin 'minibufexpl.vim'
Plugin 'xmledit'
Plugin 'ctrlp.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'ap/vim-buftabline'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
syntax on

let NERDTreeWinPos='left'
nnoremap <F2> :NERDTreeToggle<CR>
let g:tagbar_ctags_bin='/usr/bin/ctags'
let g:tagbar_left = 0
nnoremap <F3> :TagbarToggle<CR>
nmap <F4> :SrcExplToggle<CR>
let g:Srcexpl_winHeight = 10
" // Set 100 ms for refreshing the Source Explorer
let g:SrcExpl_refreshTime = 100

" // Set "Enter" key to jump into the exact definition context
let g:SrcExpl_jumpKey = "<ENTER>"

" // Set "Space" key for back from the definition context
let g:SrcExpl_gobackKey = "<SPACE>"

let g:SrcExpl_pluginList = [
            \ "__Tag_List__",
            \ "_NERD_tree_"
            \ ]


set tags=tags;/  "搜索上一级建立的tag
set autochdir

nmap <C-h> <C-W>h "Ctrl+h 进入左边的窗口
nmap <C-j> <C-W>j "Ctrl+j 进入下边的窗口
nmap <C-k> <C-W>k "Ctrl+k 进入上边的窗口
nmap <C-l> <C-W>l "Ctrl+l 进入右边的窗口

""""""""""""""""""""""""""""""  
" miniBufexplorer Config  
""""""""""""""""""""""""""""""  
let g:miniBufExplMapWindowNavArrows = 1  
let g:miniBufExplMapWindowNavVim = 1  
let g:miniBufExplMapCTabSwitchWindows = 1  
"let g:miniBufExplMapCTabSwitchBufs = 1   
let g:miniBufExplModSelTarget = 1  

"解决FileExplorer窗口变小问题  
let g:bufExplorerMaxHeight=30
let g:miniBufExplForceSyntaxEnable = 1  
let g:miniBufExplorerMoreThanOne=2  

""""""""""""""""""""""""""""""
" xmledit
""""""""""""""""""""""""""""""
let g:xml_syntax_folding=1
au FileType xml setlocal foldmethod=syntax

""""""""""""""""""""""""""""""
" Language:     PlantUML
""""""""""""""""""""""""""""""
if exists("g:loaded_plantuml_plugin")
    finish
endif
let g:loaded_plantuml_plugin = 1

if !exists("g:plantuml_executable_script")
    let g:plantuml_executable_script='java -jar /opt/java/jars/plantuml.jar'
endif
let s:makecommand=g:plantuml_executable_script." %"

" define a sensible makeprg for plantuml files
autocmd Filetype plantuml let &l:makeprg=s:makecommand

"""""""""""""""""""""""""""""""""""""""""""""
" highlight the 80th column
" In Vim >= 7.3, also highlight columns 120+
"""""""""""""""""""""""""""""""""""""""""""""
if exists('+colorcolumn')
    " (I picked 120-320 because you have to provide an upper bound and 320 just
    "  covers a 1080p GVim window in Ubuntu Mono 11 font.)
    "let &colorcolumn="80,".join(range(80,320),",")
    set colorcolumn=80
else
    " fallback for Vim < v7.3
    autocmd BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

  " 当$MYVIMRC文件被修改保存后，自动重新载入生效
  augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
  augroup END " }

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
colorscheme desert

set nocompatible                " choose no compatibility with legacy vi
set nobackup
set encoding=UTF-8
" set langmenu=zh_CN.UTF-8
" language message zh_CN.UTF-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set fileencoding=utf-8

syntax enable
set showcmd                     " display incomplete commands
filetype plugin indent on       " load file type plugins + indentation

"" Whitespace
" set nowrap                      " don't wrap lines
set tabstop=4 shiftwidth=4      " a tab is two spaces (or set this to 4)
set expandtab                   " use spaces, not tabs (optional)
set backspace=indent,eol,start  " backspace through everything in insert mode
set number                      " show lie number

"" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter:w

" 记忆文件上次编辑的位置
autocmd BufReadPost *
    \ if line("'\"")>0&&line("'\"")<=line("$") |
    \   exe "normal g'\"" |
    \ endif

"" cscope
if has("cscope")
    set cscopetag   " 使支持用 Ctrl+]  和 Ctrl+t 快捷键在代码间跳来跳去
    " check cscope for definition of a symbol before checking ctags:
    " set to 1 if you want the reverse search order.
    set csto=1

    " add any cscope database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
    " else add the database pointed to by environment variable
    elseif $CSCOPE_DB !=""
        cs add $CSCOPE_DB
    endif

    " show msg when any other cscope db added
    set cscopeverbose

    " :cs find s ---- 查找C语言符号，即查找函数名、宏、枚举值等出现的地方
    " :cs find g ---- 查找函数、宏、枚举等定义的位置，类似ctags所提供的功能
    " :cs find d ---- 查找本函数调用的函数
    " :cs find c ---- 查找调用本函数的函数
    " :cs find t ---- 查找指定的字符串
    " :cs find e ---- 查找egrep模式，相当于egrep功能，但查找速度快多了
    " :cs find f ---- 查找并打开文件，类似vim的find功能
    " :cs find i ---- 查找包含本文件的文件
    nmap <C-/>s :cs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-/>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-/>d :cs find d <C-R>=expand("<cword>")<CR><CR>
    nmap <C-/>c :cs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-/>t :cs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-/>e :cs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-/>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-/>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
endif

