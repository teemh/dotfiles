" MYVIMRC

" Global:
" Sensible Defaults {{{
"==============================================================================
" Enable syntax highlighting.
if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif

" Enable file type detection
if has('autocmd')
  filetype plugin indent on
endif

set backspace=indent,eol,start "now backspace works everywhere else.
set autoread                   "set to auto read when a file is changed from the outside
set noautochdir                "do not automatically cd into the directory. It breaks plugins.
set nrformats-=octal           "don't assume 007 is not an octal

" Turn off annoying error bells
set noerrorbells
set visualbell
set t_vb=

" More tabs
if &tabpagemax < 50
  set tabpagemax=50
endif

" Decrease delay after hitting ESC before going into normal mode.
set timeout
set timeoutlen=1000 
set ttimeoutlen=50

" Source vim configuration file whenever it is saved
if has('autocmd')          " Remain compatible with earlier versions
  augroup Reload_Vimrc       " Group name.  Always use a unique name!
    autocmd!
    autocmd! BufWritePost $MYVIMRC source % | echom "Reloaded " . $MYVIMRC | redraw
    autocmd! BufWritePost $MYGVIMRC if has('gui_running') | so % | echom "Reloaded " . $MYGVIMRC | endif | redraw
  augroup END
endif " has autocmd
" }}}
" File Format {{{
"==============================================================================
" Always use Unix file format for consistently. Prevents things like ^M.
set fileformat=unix
set fileformats=unix,dos,mac
" }}}
" Buffers {{{
"==============================================================================
" Set default text width
set textwidth=0

" Enable 'gq' manual formatting
" Delete comment leader when joining commented lines
set formatoptions=jq

" Buffers must be saved before switching
set noautowrite
set nohidden
" }}}
" UI {{{
"==============================================================================
set nolazyredraw    "use lazyredraw if rendering is slow.
set ttyfast         "improve redrawing smoothness if terminal is fast
set ttyscroll=999   "set to 3 if scrolling is slow

" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^linux\|^Eterm'
  set t_Co=16
endif

set background=dark
colorscheme slate

set laststatus=2    "always show status bar
set ruler           "show line and column number of cursor
set shortmess+=I    "don't show the vim startup message
set title           "title auto changes based on file
set report=0        "always tell me the number of lines changed by a command
set cmdheight=1     "command area height
set showcmd         "show commands
set number          "show number line
set numberwidth=7   "left padding on number line

autocmd! InsertEnter * set cul
autocmd! InsertLeave * set nocul

" When to auto scroll depending on where cursor is.
if !&scrolloff
  set scrolloff=1
endif
if !&sidescrolloff
  set sidescrolloff=5
endif

" }}}
" Multibyte Encoding (UTF-8) {{{
"==============================================================================
if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8
  setglobal fileencoding=utf-8
endif
"}}}
" Matching, Tags and Lists {{{
"==============================================================================
set showmatch

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

" Highlight matching brackets.
set matchpairs=(:),{:},[:],<:>

" Don't match whitespace characters or end-of-line characters visually by
" default.
set nolist

" Define what breaks up a word
set iskeyword=@,48-57,_,192-255

" Better search for tag files
if has('path_extra')
  setglobal tags-=./tags tags-=./tags; tags^=./tags;
endif

" Show invisible characters when set list.
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif
"}}}
" Completion {{{
"==============================================================================
" Searching includes is slow.
set complete-=i
" Don't show list if there is only one word.
set completeopt=menuone,longest
"}}}
" Search {{{
"==============================================================================
set ignorecase
set smartcase
set hlsearch
set incsearch
set infercase

" Enter resets search highlight
nnoremap <CR> :let @/ = ""<CR>/<BS>
"}}}
" Indents {{{
"==============================================================================
" Adopt the indent of the last line on new lines; plugins that
" do clever things with indenting will often assume this is set
set autoindent

" cindent and smartindent conflict set them according to language.
set nocindent
set nosmartindent

" Use spaces instead of tabs
set expandtab

" Indent with 2 spaces when an indent operation is used
set shiftwidth=2

" Insert 2 spaces when Tab is pressed
set softtabstop=2

" How many spaces to show for a literal tab when 'list' is unset
set tabstop=2

" Indent intelligently to 'shiftwidth' at the starts of lines with Tab, but
" use 'tabstop' everywhere else
set smarttab

" When indenting lines with < or >, round the indent to a multiple of
" 'shiftwidth', so even if the line is indented by one space it will indent
" up to 2 and down to 0, for example
set shiftround
"}}}
" Copy & Paste {{{
"==============================================================================
" If you need paste toggle it first.
set nopaste

" Use the windows clipboard.
if !has('xterm_clipboard') && has('win32')
  " Automatically prepend "* to p and y to copy paste.
  set clipboard=unnamed
else
  " Automatically prepend "+ to p and y to copy paste.
  set clipboard=unnamedplus
endif
"}}}
" Tabs {{{
"==============================================================================
set guitablabel=%t "just show the filename in the tab label.
"}}}
" Spelling {{{
"==============================================================================
set nospell
set spelllang=en_us
set spellsuggest=10
"}}}
" WildMenu {{{
"==============================================================================
set wildmenu
set wildignorecase
set wildmode=longest,list,full

" Ignore the following:
" MSVC
set wildignore+=*.ilk,*.pdb
" Compiled
set wildignore+=*.dll,*.obj,*.exe,*.manifest,*.luac,*.o,*.pyc,*.a
" Images
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png,*.jpeg
" Version Control
set wildignore+=.DS_Store,.git,.hg,.svn
" Temp Files
set wildignore+=*~,*.swp,*.tmp,*.sw?
" LaTeX
set wildignore+=*.aux,*.out,*.toc
" Other
set wildignore+=*.orig
"}}}
" Wrapping {{{
"==============================================================================
"Wrap text that doesnt fit on the screen and try to wrap without cutting words
"and without line breaks.
set wrap
set linebreak
set display+=lastline
let &showbreak = '> '
set cpoptions+=n "Moves the showbreak characters into line number coloumn.
"}}}
"Backup, Swap and Undo {{{
"==============================================================================
if &history < 1000
  set history=1000 "max undo history
endif

set undolevels=1000         "max number of undos that can be done
set sessionoptions-=options "don't save options from last session

" Only keep backup and undo file if user is not root.
if !strlen($SUDO_USER)
  " Use swap files
  set swapfile

  " Backup
  set backup
  set writebackup
  set backupext=.bak
  set backupskip=/tmp/*,/private/tmp/*"

  " Persistent Undo
  set undofile
  set undoreload=10000

  " Remember info about open buffers on close
  if !empty(&viminfo)
    set viminfo^=!
  endif

  " Backup and Undo File Locations
  if has('win32')
    " Directories to store backup, swap and undo.
    set backupdir=$VIM/backup//
    set directory=$VIM/swap//
    set undodir=$VIM/undo//

    " Check if directories exist.
    if !isdirectory($VIM . '/backup') && exists('*mkdir')
      echo "Please create backup folder"
    endif
    if !isdirectory($VIM . '/swap') && exists('*mkdir')
      echo "Please create swap folder"
    endif
    if !isdirectory($VIM . '/undo') && exists('*mkdir')
      echo "Please create undo folder"
    endif

  elseif has('unix') 
    " Directories to store backup, swap and undo.
    set backupdir=~/.vim/backup//
    set directory=~/.vim/swap//
    set undodir=~/.vim/undo//

    " Create directories if they don't exist.
    if !isdirectory($HOME . '/.vim/backup') && exists('*mkdir')
      call mkdir($HOME . '/.vim/backup', 'p', 0700)
    endif
    if !isdirectory($HOME . '/.vim/swap') && exists('*mkdir')
      call mkdir($HOME . '/.vim/swap', 'p', 0700)
    endif
    if !isdirectory($HOME . '/.vim/undo') && exists('*mkdir')
      call mkdir($HOME . '/.vim/undo', 'p', 0700)
    endif
  else
    " OSX?
  endif
else
  set nobackup
  set nowritebackup
  set noswapfile
  set noundofile
  set viminfo=
endif
"}}}
" Folding {{{
"==============================================================================
set foldmethod=marker

" Default fold markers
set foldmarker={{{,}}}

" Show fold column
set foldcolumn=5
"}}}
" Font {{{
"==============================================================================
if has("directx") && $VIM_USE_DIRECTX != '0'
  set renderoptions=type:directx,gamma:1.8,contrast:0.5,level:0.5,geom:1,renmode:5,taamode:1
  let s:use_directx=1
endif

if has('gui_running')
  set guifontwide=NSimSun " For unicode characters
  if has("gui_gtk2") " Linux / Gnome
    set guifont=Monospace\ 14
  elseif has("gui_macvim") " Mac
    set guifont=Monaco:h14
  elseif has("gui_win32") " Windows
    set guifont=SF_Mono:h16:cANSI:qCLEARTYPE
  endif
else
  " Use terminal's font.
endif

" Increase the space underneath text by X pixels (lineheight)
set linespace=0
"}}}
" Regular Expressions {{{
"==============================================================================
set magic
"magic:	    \v	   \m	    \M	     \V		matches 
"          'magic'         'nomagic'
"	        $	   $	        $	     \$		  matches end-of-line...........................
"         .	   .	        \.	     \.		matches any character
"	        *	   *	        \*	     \*		any number of the previous atom
"         ()	   \(\)     \(\)     \(\)	grouping into an atom
"         |	    \|	      \|	     \|		separating alternatives
"	        \a	   \a	      \a	     \a		alphabetic character
"	        \\	   \\	      \\	     \\		literal backslash
"	        \.	   \.	      .	       .		literal dot
"	        \{	   {	      {	       {		literal '{'
"	        a	     a	      a	       a		literal 'a'
"}}}
" GVIM Window{{{
"==============================================================================
if has("gui_running")
  "set guioptions-=m  " Hide the menu bar
  set guioptions-=T   " Hide the toolbar
endif

augroup gvimgui
  autocmd!
  autocmd GUIEnter * simalt ~x " Max Window in GUI Mode
augroup END

"}}}
" NETRW {{{
"==============================================================================
let g:netrw_liststyle    = 1    "Long list, detailed.
let g:netrw_banner       = -1   "Don't show the banner.
let g:netrw_browse_split = 0    "Open file in current window.
"}}}
" Functions {{{
"==============================================================================
" Check if colorscheme file exists
function! ColorSchemeExists(scheme)
  " Windows Path to custom colorscheme
  if filereadable(expand("$VIMRUNTIME/colors/".a:scheme.".vim"))
    return 1
    " Nix Path to custom colorscheme
  elseif filereadable(expand("$HOME/.vim/colors/".a:scheme.".vim"))
    return 1
  else
    return 0
  endi
endfunction

" Toggle between auto detect and defined file type.
function! FileTypeToggle(type)
  if &filetype == a:type
    filetype detect
  else
    setfiletype a:type
  endif
endfunction

" Fill entire line with one character.
function! FillLine(str)
  " Set tw to the desired total length.
  let tw = &textwidth
  if tw == 0 | let tw = 80 | endif
  " Strip trailing spaces first.
  .s/[[:space:]]*$//
  " Calculate total number of 'str's to insert.
  let reps = (tw - col("$")) / len(a:str)
  " Insert them, if there's room, removing trailing spaces.
  if reps > 0
    .s/$/\=(repeat(a:str, reps + 1))/
  endif
endfunction

" Delete trailing white space.
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
"}}}
" Key Mappings {{{
"==============================================================================
" ~ changes the case of the character under cursor
set notildeop

" Repeat last command on each line in visual block.
vnoremap . :normal .<CR>

" Select the highlighted word in omni completion by hitting enter.
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Preserve the flags for a pattern when repeating a substitution with &.
noremap & :&&<CR> 
vnoremap & :&&<CR>

" Pasting in visual mode shouldn't copy into clipboard what you pasted over.
vnoremap p pgvy
vnoremap P Pgvy

" Typos
"------------------------------------------------------------------------------
command! -bang E e<bang>
command! -bang Q q<bang>
command! -bang W w<bang>
command! -bang QA qa<bang>
command! -bang Qa qa<bang>
command! -bang Wa wa<bang>
command! -bang WA wa<bang>
command! -bang Wq wq<bang>
command! -bang WQ wq<bang>
command! -bang Bd bd<bang>

" Cut, Delete and Change.
"------------------------------------------------------------------------------
" Backspace in Visual mode deletes selection.
vnoremap <BS> "_d

" Make x and X act like d and D. Use backspace instead of X. Use x instead
" d for cutting.
"noremap  x d
"vnoremap x d
"noremap  X D
"vnoremap X D
"
"" When using dD and cC don't copy to clipboard. Makes pasting much better.
"nnoremap d "_d
"vnoremap d "_d
"nnoremap D "_D
"vnoremap D "_D
"nnoremap c "_c
"vnoremap c "_c
"nnoremap C "_C
"vnoremap C "_C

" Arrow Keys
"------------------------------------------------------------------------------
noremap <Down>  gj
noremap <Up>    gk

" Move around (Big Movements)
noremap  <C-Down>    } 
noremap  <C-Left>    0
noremap  <C-Right>   $
noremap  <C-Up>      {

" Move around (Smaller Movements)
noremap  <S-Down>    )
noremap  <S-Left>    gE
noremap  <S-Right>   E
noremap  <S-Up>      (

" Buffer Movement
"------------------------------------------------------------------------------
" A-Down closes file in buffer without deleted the window
nmap  <A-Down>    :bp<bar>sp<bar>bn<bar>bd<CR>
nmap  <A-Left>    :bp<CR>
nmap  <A-Right>   :bn<CR>
nmap  <A-Up>      :buffers<CR>:buffer<Space>

" OMNI Movement
"------------------------------------------------------------------------------
" Can use arrow keys in omnicomplete menu.
inoremap <expr> <Down> pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>   pumvisible() ? "\<C-p>" : "\<Up>"

" CTRL-S and CTRL-Q
"------------------------------------------------------------------------------
" Don't map to ctrl-s
map  <C-s>  <nop>
imap <C-s>  <nop>

" Don't map to ctrl-q
map  <C-q>  <nop>
imap <C-q>  <nop>

" Tabs
"------------------------------------------------------------------------------
" Move between tabs like browsers do.
noremap  <C-Tab>    :tabnext<CR>
inoremap <C-Tab>    <C-O>:tabnext<CR>
cnoremap <C-Tab>    <C-C>:tabnext<CR>
onoremap <C-Tab>    <C-C>:tabnext<CR>

" Open a new tab
nnoremap <leader>t :tabnew<CR>

" Function Keys
"------------------------------------------------------------------------------
" Use :help instead of F1 because F1 gets intercepted by terminals
map F1 <nop>

"}}}
" Leader Mappings {{{
"==============================================================================
let mapleader = "," " Default is \
let maplocalleader = "\\" " Recommended (by vim) default is _

" Space is an easier to hit leader.
map <space> <leader>

" When saving requires sudo.
noremap <Leader>w !sudo tee % > /dev/null<CR>

" Edit vimrc file
noremap <Leader>v :edit $MYVIMRC<CR>

" Assume first spelling match is correct and use it.
noremap <Leader>z 1z=

" Echo Highlight Group(s)
noremap <Leader>h :echo "hi <" 
      \ . synIDattr(synID(line("."),col("."),1),"name") . '> trans <'
      \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo <"
      \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Lines for Headings
"------------------------------------------------------------------------------
" Wrap text with over and underline
noremap <Leader>1 O<ESC>:call FillLine('=')<ESC>jo<ESC>:call FillLine('=')<ESC>k
noremap <Leader>2 O<ESC>:call FillLine('-')<ESC>jo<ESC>:call FillLine('-')<ESC>k

" Just a Line
noremap <Leader># :call FillLine('#')<CR>
noremap <Leader>* :call FillLine('*')<CR>
noremap <Leader>= :call FillLine('=')<CR>
noremap <Leader>- :call FillLine('-')<CR>
noremap <Leader>. :call FillLine('.')<CR>
"}}}
" Extra Annotations {{{
function! HighlightAnnotations()
  syn keyword cTodo                 contained TODO HACK FIXME NOTE
  syn keyword javaScriptCommentTodo contained TODO HACK FIXME NOTE
endfunction
autocmd Syntax * call HighlightAnnotations()
"}}}

" File Type Specific:
" C / CPP {{{
" make sure header files are treated as c files not cpp files
let g:c_syntax_for_h = 1

augroup ft_cpp
  autocmd FileType c,cpp setlocal matchpairs+==:; "match = to ;
augroup END

function! CppSyntax()
  set cindent

  syn match cSpaceError display excludenl "\s\+$"
  syn match cSpaceError display "\t"
  syn match cType       "\vstruct\s+[a-zA-Z0-9_]+"

  syn match cCustomParen "?=(" contains=cParen,cCppParen
  syn match cCustomFunc  "\w\+\s*(\@=" contains=cCustomParen
  syn match cCustomScope "::"
  syn match cCustomClass "\w\+\s*::" contains=cCustomScope

  hi def link cCustomFunc  Function
  hi def link cCustomClass StorageClass

  syn keyword cType     u8 s8 u16 s16 u32 s32 u64 s64 f32 f64 b32 
  syn keyword Function  ssizeof
  syn keyword cType     ssize_t usize isize
  syn keyword cType     vec2 vec3 vec4 vec2f vec3f vec4f
  syn keyword cType     mat2 mat3 mat4 mat2f mat3f mat4f
  syn keyword cType     utf8, cstr

  " Prevents c.vim complaining about compound literals (ie {} in ())
  let c_no_curly_error = 1

endfunction
autocmd Syntax c,cpp,h,hpp call CppSyntax()

"}}}
" VIM {{{
augroup ft_vim
  au!
  " put help files in a vertical split instead of horizontal
  autocmd BufWinEnter *.txt if &ft == 'help' | wincmd L | endif
augroup END
"}}}
