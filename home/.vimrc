" All system-wide defaults are set in $VIMRUNTIME/debian.vim (usually just
" /usr/share/vim/vimcurrent/debian.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vim/vimrc), since debian.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing debian.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
syntax on

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
set background=dark

"""""""""""""""""
" Color Schemes!
"""""""""""""""""
set t_Co=256
"colorscheme grb256
"colorscheme candycode
"colorscheme molokai
"colorscheme solarized
"colorscheme wombat256mod
"colorscheme xoria256
"colorscheme matrix
"colorscheme vividchalk
"colorscheme sorcerer
colorscheme jellybeans
"colorscheme lettuce
"colorscheme freya

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
if has("autocmd")
  filetype plugin indent on
endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
"set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
"set smartcase		" Do smart case matching
set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden             " Hide buffers when they are abandoned
set mouse=a		" Enable mouse usage (all modes)
set nocompatible
set nobackup
set nowritebackup
set noswapfile
set autoindent
"set number
set ls=2			"Show filename at the bottom of the screen

" Highlight the line where the cursor is
set cursorline
"hi cursorLine cterm=NONE term=NONE	"Make background grey, remove line

filetype indent on
filetype on
filetype plugin on


highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

if version >= 703
	execute "set colorcolumn=" . join(range(81,81), ',')
	hi ColorColumn ctermbg=darkgrey guibg=lightgrey
endif

" Source a global configuration file if available
"if filereadable("/etc/vim/vimrc.local")
"  source /etc/vim/vimrc.local
"endif

"Force spell checking depending on filetype
au FileType rst setlocal spell spelllang=en_us
"au Filetype rst colorscheme default
"au Filetype rst colorscheme evening
"au FileType rst setlocal t_Co=16
"au FileType rst setlocal nocursorline

"For some reason those don't work
"au BufNewFile,BufRead *.c let Tlist_Auto_Open=1
"au BufNewFile,BufRead *.h let Tlist_Auto_Open=1

" Only for GIT commits: Turn on spell-checking and enter insert mode at top
" lines
if has('autocmd')
	if has('spell')
		au BufNewFile,BufRead COMMIT_EDITMSG setlocal spell
	endif
	au BufNewFile,BufRead COMMIT_EDITMSG call feedkeys('ggi', 't')
endif

""""""""""""
" Mappings
""""""""""""

nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>

nmap <F2> :TlistToggle<CR>
nmap <F3> <C-W>t
vmap <F4> d:set tw=80<ENTER>Pgq`]:set tw=0<ENTER>

set tags=./tags,tags,/home/apyrgio/archipelago/xseg/tags
