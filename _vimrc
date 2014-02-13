behave mswin

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

""""""""""""""""""""""""""""""""""""""""""""
" General
""""""""""""""""""""""""""""""""""""""""""""

"--------------------------------------------------------------------
" Get out of VI's compatible mode..
"--------------------------------------------------------------------
set nocompatible

"--------------------------------------------------------------------
" Sets how many lines of history VIM has to remember
"--------------------------------------------------------------------
set history=700

"--------------------------------------------------------------------
" Enable filetype plugin
"--------------------------------------------------------------------
filetype on
filetype plugin on
filetype indent on

"--------------------------------------------------------------------
" Set to auto read when a file is changed from the outside
"--------------------------------------------------------------------
set autoread

"--------------------------------------------------------------------
" Have the mouse enable all the time:
" 
" vimrc_example.vim says "In many terminal emulators 
" the mouse works just fine, thus enable it.", but I
" find this setting is a real evil in some terminal!
"--------------------------------------------------------------------
set mouse=a

"--------------------------------------------------------------------
" Set mapleader
"
" ',' is easy to touch.
"--------------------------------------------------------------------
let mapleader = ","
let g:mapleader = ","

"--------------------------------------------------------------------
" Set fold
"
" setl fen (setlocal foldenable)
"--------------------------------------------------------------------
set foldenable
set fdm=manual

" Special for c,cpp source code
"au FileType c,cpp setl fdm=syntax | setl fen | setl foldnestmax=1
"au FileType c,cpp setl fdm=syntax | setl fen

" Remember fold view when close file
"au BufWinLeave * silent mkview
"au BufWinEnter * silent loadview

""""""""""""""""""""""""""""""""""""""""""""""""
" Colors and Fonts
""""""""""""""""""""""""""""""""""""""""""""""""

"--------------------------------------------------------------------
" Theme
"--------------------------------------------------------------------
colorscheme leo
"colorscheme synic
"colorscheme asu1dark

"--------------------------------------------------------------------
" Font
"--------------------------------------------------------------------
"set guifont=fixsys:h12:cANSI
"set guifont=Consolas:h14
set guifont=Courier_New:h11:cANSI


"--------------------------------------------------------------------
" Enable syntax hl
"--------------------------------------------------------------------
syntax enable

""""""""""""""""""""""""""""""""""""""""""""""""
" VIM usrinterface
""""""""""""""""""""""""""""""""""""""""""""""""

"--------------------------------------------------------------------
" Set 7 lines to the curors - when moving vertical..
"--------------------------------------------------------------------
set so=7

"--------------------------------------------------------------------
" 当你在VIM中用y,p＝＝命令，会自动放到系统剪切板中
"--------------------------------------------------------------------
set clipboard+=unnamed  

"--------------------------------------------------------------------
" Make sure it can save viminfo
"--------------------------------------------------------------------
set viminfo+=!          

"--------------------------------------------------------------------
" Turn on Wild menu
"--------------------------------------------------------------------
set wildmenu

"--------------------------------------------------------------------
" Always show current position
"--------------------------------------------------------------------
set ruler

"--------------------------------------------------------------------
" The commandbar is 2 high
"--------------------------------------------------------------------
set cmdheight=2

"--------------------------------------------------------------------
" Show line number
"--------------------------------------------------------------------
set nu

"--------------------------------------------------------------------
" Show matching bracets
"--------------------------------------------------------------------
set showmatch

"--------------------------------------------------------------------
" 1.为HTML的<>添加跳转；
" 2.在赋值语句的 '=' 和 ';' 来回跳转，用于 C 和 Java 这样的语言；
"--------------------------------------------------------------------
au FileType html,xml set mps+=<:>
au FileType c,cpp,java set mps+==:;

"--------------------------------------------------------------------
" Hightlight search things
"--------------------------------------------------------------------
set hlsearch

"--------------------------------------------------------------------
" Increase Search
"--------------------------------------------------------------------
set incsearch

"--------------------------------------------------------------------
" 使搜索过程在文件结束时就停止。或者，在反向搜索时在到达
" 文件开头时停止
"--------------------------------------------------------------------
set nowrapscan

"--------------------------------------------------------------------
" Set backspace
"--------------------------------------------------------------------
set backspace=eol,start,indent

"--------------------------------------------------------------------
" 使指定的左右移动光标的键在行首或行尾可以移到前一行或者后一行。
"--------------------------------------------------------------------
"set whichwrap+=<,>,h,l

"--------------------------------------------------------------------
" Format the statusline
"
" 设置在状态行显示的信息如下:
" %F 当前文件名
" %m 当前文件修改状态
" %r 当前文件是否只读
" %Y 当前文件类型
" %{&fileformat}
" 当前文件编码
" %b 当前光标处字符的 ASCII 码值
" %B 当前光标处字符的十六进制值
" %l 当前光标行号
" %c 当前光标列号
" %V 当前光标虚拟列号 (根据字符所占字节数计算)
" %p 当前行占总行数的百分比
" %% 百分号
" %L 当前文件总行数
"--------------------------------------------------------------------
set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c

function! CurDir()
	let curdir = substitute(getcwd(), '/Users/amir/', "~/", "g")
	return curdir
endfunction

"--------------------------------------------------------------------
" 本选项的值影响最后一个窗口何时有状态行:
" 0: 永不
" 1: 只有在有至少两个窗口时
" 2: 总是
"
" 如果你有多个窗口，有状态行会使屏幕看起来好一些，但它会占据一个屏幕行。
"--------------------------------------------------------------------
set laststatus=2

"""""""""""""""""""""""""""""""""""""""""""""""
"Files and backups
"""""""""""""""""""""""""""""""""""""""""""""""
set nobackup

"--------------------------------------------------------------------
" Turn backup on
"--------------------------------------------------------------------
"set backup

"--------------------------------------------------------------------
" Set the extension of the backup file
"--------------------------------------------------------------------
"set backupext=.bak

"--------------------------------------------------------------------
" Save the original version
"--------------------------------------------------------------------
"set patchmode=.orig

"""""""""""""""""""""""""""""""""""""""""""""""
" Buffer related
"""""""""""""""""""""""""""""""""""""""""""""""

"--------------------------------------------------------------------
" vminfo相关设置:
"--------------------------------------------------------------------
"
" !		如果包含，保存和恢复大写字母开头，并且不包含小写
"		字母的全局变量。这样，保存"KEEPTHIS" 和"K_L_M"，
"		但不保存"KeepThis" 和"_K_L_M"。只保存字符串和数值
"		类型。
"
" "		每个寄存器最大保存的行数。'<' 项目的旧名，缺点是
"		你需要在 "之前加上反斜杠，不然它被识别为注释的开
"		始！
"
" %		如果包含，保存和恢复缓冲区列表。如果 Vim 启动时
"		指定文件名参数，缓冲区列表不予恢复。如果 Vim 启
"		动时没有指定文件名参数，缓冲区列表从 viminfo文件
"		里恢复。没有文件名的缓冲区和帮助文件的缓冲区不会
"		写入 viminfo 文件。
"		如果后跟数值，该数值指定保存的缓冲区的最大个数。
"		如果没有此数，保存所有的缓冲区。
" 
" '		编辑过的文件的最大数目，为它们记住位置标记。如果
"		'viminfo' 非空，必须包含本参数。
"
" /		保存的搜索模式历史的最大项目数目。如果非零，那么
"		也保存前次搜索和替代模式。如果不包含，使用
"		'history' 的值。
"
" :		保存的命令行历史的最大项目数目。如果不包含，使用
"               'history' 的值。
"                                                 
" <		每个寄存器最大保存的行数。如果为零，不保存寄存器。
"		如果不包含，所有的行都被保存。'"'是本项目的旧名。
"
"
" @		保存的输入行历史的最大项目数目。如果不包含，使用
"		'history' 的值。
"                         
" c		如果包含，把 viminfo 里的文本从写入时使用的
"		'encoding' 转换为当前的 'encoding'。
"
" f		是否保存文件位置标记。如果为零，不保存文件位置标记
"		('0 到 '9，'A 到 'Z)。如果不存在或者非零，它们都被
"		保存。'0 记住光标的当前位置 (退出或者执行":wviminfo"时)。
"
" 
" h		载入 viminfo 文件时，关闭 'hlsearch' 的效果。如果
"		不包含，取决于在最近的搜索命令之后是否使用过":nohlsearch"。
"
" n		viminfo 文件的名字。该名字必须立即跟随在 'n' 之后，
"		而且这必须是最后一个参数！如果启动 Vim 时指定"-i"
"		参数，那个文件名覆盖'viminfo'在这里给出的。环境变量
"		在文件打开时被扩展，而不是设置选项时。
"
" r		略
"
" s		每个项目千字节计的最大长度。如果为零，不保存寄存器。
"		目前，只适用于寄存器。缺省的"s10" 会忽略包含超过 10
"               千字节文本的寄存器。另见上面的 '<' 项目: 行数限制。
"
"--------------------------------------------------------------------
" 例如: set viminfo='50,<1000,s100,:0,n~/vim/viminfo
"
" '50			记住最近 50 个你编辑的文件的位置标记。
" <1000			记住寄存器的内容 (每个不超过1000 行)。
" s100			跳过超过 100千字节文本的寄存器。
" :0			不保存命令行历史。
" n~/vim/viminfo	使用的文件名是"~/vim/viminfo"。
" no /			因为没有指定'/'，使用缺省。也就是，保存所有的
"			搜索历史和前次搜索和替代模式。
" no %			不保存也不读入缓冲区列表。
" no h			恢复'hlsearch'高亮。
"--------------------------------------------------------------------
set viminfo='10,\"100,:20,%,n~/.viminfo

"--------------------------------------------------------------------
" 打开文件时，按照 viminfo 保存的上次关闭时的光标位置重新设置光标
"
" 自动命令服务的对象是所有类型的文件。它所执行的功能是检查是否定义
" 了标记`",如果定义了就跳转到这个位置去。
"
" 该标记记录了上次编辑一个文件时退出前光标的最后位置。
"--------------------------------------------------------------------
au BufReadPost * if line("'\"") > 0 | if line("'\"") <= line("$") | exe("norm '\"") | else | exe "norm $" | endif | endif

"""""""""""""""""""""""""""""""""""""""""""""""
" Files and Encodings
"""""""""""""""""""""""""""""""""""""""""""""""

"--------------------------------------------------------------------
" 设置VIM系统语言设置 Vim内部使用的字符编码。
" 它应用于缓冲区、寄存器、表达式所用字符串、viminfo保存的等各种文本。
" 该选项设置 Vim 可以工作的字符类型。
"--------------------------------------------------------------------
set encoding=utf-8

"--------------------------------------------------------------------
" 设置此缓冲区所在文件的字符编码。
" 如果 'fileencoding' 不同于 'encoding'，读写文件时需要进行转换。
" 如果 'fileencoding' 为空，使用 'encoding' 相同的值(读写不需要转换)。
"
" 警 告: 转换可能导致信息的丢失！如果'encoding'为"utf-8"，
" 那么转换的结果通过逆转换很有可能产生相同的文本。相反，如果
" 'encoding'不是"utf-8"，一些字符可能会丢失
"--------------------------------------------------------------------
"set fileencoding=
"
"--------------------------------------------------------------------
" 设置可以识别的语言,这是一个字符编码的列表。
" 开始编辑已存在的文件时，参考此选项。
"
" 如果文件被读入，Vim 尝试使用本列表第一个字符编码。
" 如果检测到错误，使用列表的下一个。
" 
" 如果找到一个能用的编码，设置 'fileencoding'为该值。
" 如果全都失败, 'fileencoding' 设为空字符串，这意味着使用 'encoding'的值。
"
" 特殊值"ucs-bom" 可用来检查文件开始处的 Unicode 的 BOM (Byte OrderMark 
" 字节顺序标记)。要使之能正常工作，不能把"utf-8" 或别的 Unicode编码
" 放在它的前面。8 位编码的项目 (比如，"latin1") 应该放在最后，因为
" Vim 不会检测出错，因而总会接受该编码。
"--------------------------------------------------------------------
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1

"""""""""""""""""""""""""""""""""""""""""""""""
" Indent
"""""""""""""""""""""""""""""""""""""""""""""""

"--------------------------------------------------------------------
" Set smartindent
"--------------------------------------------------------------------
set smartindent

"--------------------------------------------------------------------
" Set autoindent
"--------------------------------------------------------------------
set autoindent

"--------------------------------------------------------------------
" Set C-style indent
"
" :N    将 case 标号放在 switch() 缩进位置之后的 N 个字符处。
"	(缺省为'shiftwidth')。
"
" gN    将 C++ 作用域声明置于其所在代码块的 N 个字符后。(缺省
"	为'shiftwidth')。作用域声明可以是"public:","protected:" 
"	或者"private:"。
"--------------------------------------------------------------------
set cindent
set cinoptions+=g0,:0

" GNU style indenting, CMSERVER
"set cinoptions+={2

"--------------------------------------------------------------------
" Nowrap lines
"--------------------------------------------------------------------
set nowrap

"--------------------------------------------------------------------
" 设置行宽和自动换行
"--------------------------------------------------------------------
set lbr
set tw=80

"--------------------------------------------------------------------
" Tab and space
"--------------------------------------------------------------------
set softtabstop=2
set shiftwidth=2

"au FileType c,cpp set softtabstop=8
"au FileType c,cpp set shiftwidth=8

au FileType html,xml set softtabstop=2
au FileType html,xml set shiftwidth=2

au BufRead,BufNewFile *.html,*.jsp,*.tpl,*.htm set softtabstop=2 shiftwidth=2
au BufRead,BufNewFile *.js set syntax=jquery

set expandtab

"""""""""""""""""""""""""""""""""""""""""""""""
" Spell check and Auto complete
"""""""""""""""""""""""""""""""""""""""""""""""

"--------------------------------------------------------------------
" Auto Code Complete
"--------------------------------------------------------------------
set completeopt=longest,menu

"--------------------------------------------------------------------
" Spell check
"--------------------------------------------------------------------
"set spell

"""""""""""""""""""""""""""""""""""""""""""""""
" Quick Fix
"""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>cn :cn<cr>
nmap <leader>cp :cp<cr>
nmap <leader>cw :cw 10<cr>

"""""""""""""""""""""""""""""""""""""""""""""""
" 自定义快捷键
"""""""""""""""""""""""""""""""""""""""""""""""

" 选中一段文字并全文搜索这段文字
:vnoremap <silent> ,/ y/<C-R>=escape(@", '\\/.*$^~[]')<CR><CR> 
:vnoremap <silent> ,? y?<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>

" 模仿MS Windows中的快捷键
nmap <C-a> ggvG$

" 快速在分割窗口中打开当前文件
map <leader>w :sp<cr>

" Smart way to move btw. windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Tab configuration
map <leader>tn :tabnew<cr>
map <leader>te :tabedit
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

" 缩写
iab idate <c-r>=strftime("%Y-%m-%d")<CR>
iab itime <c-r>=strftime("%H:%M")<CR>

" 利用F9在打开和关闭粘贴模式
set pastetoggle=<F9>

"""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
"""""""""""""""""""""""""""""""""""""""""""""""

"--------------------------------------------------------------------
" Auto Code Complete
"--------------------------------------------------------------------
set completeopt=longest,menu

" f:文件名补全，l:行补全，d:字典补全，]:tag补全
imap <C-]>             <C-X><C-]>
imap <C-F>             <C-X><C-F>
imap <C-D>             <C-X><C-D>
imap <C-L>             <C-X><C-L> 

"--------------------------------------------------------------------
" Auto Brackets Complete
"
" <>括号的自动补全仅仅针对html文件，因为c语言等中的比较操作符不需要
" 补全
"--------------------------------------------------------------------
:inoremap ( ()<ESC>i
:inoremap ) <c-r>=ClosePair(')')<CR>
:inoremap { {}<ESC>i
:inoremap } <c-r>=ClosePair('}')<CR>
:inoremap [ []<ESC>i
:inoremap ] <c-r>=ClosePair(']')<CR>

" au:autocmd
au FileType c,cpp,java :inoremap " ""<ESC>i
au FileType c,cpp,java :inoremap ' ''<ESC>i

"au FileType html,xml :inoremap < <><ESC>i
"au FileType html,xml :inoremap > <c-r>=ClosePair('>')<CR>

function ClosePair(char)
	if getline('.')[col('.') - 1] == a:char
		return "\<Right>"
	else
		return a:char
	endif
endf

"--------------------------------------------------------------------
" 插件 - suptab.vim
" 用途 - 用tab实现自动补全
" script version: 1.6
" Vim version: 7.0
"
" 注：更新doc命令 :helptags $HOME/.vim/doc
"--------------------------------------------------------------------
"use SuperTab completion
"let g:SuperTabRetainCompletionDuration=
let g:SuperTabDefaultCompletionType='context'
let g:SuperTabMidWordCompletion=0

"--------------------------------------------------------------------
" 插件 - omnicppcomplete.vim
" 用途 - C++代码自动补全 
" script version: 0.41
" Vim version: 7.0
"
" Remember set ctags options as follow:
" --c++-kinds=+p
" --fields=+iaS
" --extra=+q
"--------------------------------------------------------------------
"let OmniCpp_ShowPrototypeInAbbr = 1	" 总是展示函数原型

" 设置代码提示窗口各元素的颜色
"highlight Pmenu ctermbg=black
highlight PmenuSel ctermbg=darkblue

"--------------------------------------------------------------------
" 插件 - buferexplore.vim
" 用途 - Buffer Explorer / Browser 
" script version: 7.2.8
" Vim version: 7.0
"
" 使用方法: ',be' ',bv' ',bs' (mapleader is ',')
"--------------------------------------------------------------------
let g:bufExplorerDefaultHelp=0		" Do not show default help.
let g:bufExplorerShowRelativePath=1	" Show relative paths.
let g:bufExplorerSortBy='mru'		" Sort by most recently used.
let g:bufExplorerSplitRight=0		" Split left.
let g:bufExplorerSplitBelow=1		" Split new window below current.

"--------------------------------------------------------------------
" 插件 - The NERD tree
" 用途 -  A tree explorer plugin for navigating the filesystem
" script version: 4.2.0
" Vim version: 7.0
"--------------------------------------------------------------------
let g:NERDChristmasTree=1
let g:NERDTreeToggle=1
let g:NERDTreeShowBookmarks=1
let g:NERDTreeShowFiles=1
let g:NERDTreeShowLineNumbers=1
let g:NERDTreeWinPos='left'
let g:NERDTreeWinSize=40
"let g:NERDTreeQuitOnOpen=1

nnoremap F :NERDTreeToggle<cr>

"--------------------------------------------------------------------
" 插件 - tagbar.vim
" 用途 - Source code browser 
" script version: 2.5
" Vim version: 7.0
"--------------------------------------------------------------------
let g:tagbar_left = 1
let g:tagbar_sort = 0

nnoremap T :TagbarToggle<CR>
autocmd VimEnter * nested :call tagbar#autoopen(1)
"autocmd VimEnter *.c,*.cpp,*.java,*.py nested :call tagbar#autoopen(1)

"--------------------------------------------------------------------
" 插件 - nginx.vim
" 用途 - highlights configuration files for nginx 
" script version: 0.3.2
" Vim version: 6.0
"--------------------------------------------------------------------
au BufRead,BufNewFile nginx.conf,openresty_config_sample* set ft=nginx

"--------------------------------------------------------------------
" 插件 - haproxy.vim
" 用途 - highlights configuration files for haproxy
" script version: 0.3
" Vim version: 7.0
"--------------------------------------------------------------------
au BufRead,BufNewFile haproxy* set ft=haproxy

"--------------------------------------------------------------------
" 插件 - thrift.vim
" 用途 - highlights configuration files for thrift
"--------------------------------------------------------------------
au BufRead,BufNewFile *.thrift set filetype=thrift
au! Syntax thrift source ~/.vim/syntax/thrift.vim

"--------------------------------------------------------------------
" ctags setting
"--------------------------------------------------------------------

set tags=tags
set autochdir
