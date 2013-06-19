" Vim syntax file
" Language:	    stx2any
" Maintainer:	John Magolske
" URL:		    http://B79.net/contact/
" Version:	    0.1
" Last Change:  2007 Feb 2
" Remark:	    ...first attempt
" ToDo:	        
" * don't match when empty lines exist within 'strong' 'emphasis' etc.
" * flag double single quotes within 'literal' as errors
" * allow blank space required before one match to be the same as the blank 
"   space required to follow the previous match


" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" maybe find a way to toggle html syntax on & off?
"runtime! syntax/html.vim

" stx2any syntax is case sensitive 
syn case match

" highlight metadata info (must start at the first line of the file)
syntax match metaTitle /\%^\(\S\+: \+.\+\n\)\+/ contains=metaText
syntax match metaText /: \+\zs.\+/ contained

" highlight stx2any macros (preceeded with a `w_')
syntax match wText /\(\(\_^w_\)\|\(\sw_\)\)\S\+/hs=s+2,he=e contains=wTag
syntax match wTag /\(\(\_^w_\)\|\(\sw_\)\)\S\+/hs=s,he=s+2 contained contains=wParen1
syntax match wParen1  /\(\(\_^w_\)\|\(\sw_\)\)\S\+(.\+)/hs=e,he=e contained contains=wParen2
syntax match wParen2  /\(\(\_^w_\)\|\(\sw_\)\)\S\+(/hs=e,he=e contained

" Mark as 'strong' when surrounded by stars:
syntax region strong matchgroup=strongTag start=/\([-{(<"[]\|\_^\|\s\)\zs\*\ze\S/ end=/\S\zs\*\ze\(\s\|\_$\|[]})>.,;:"-]\)/ contains=strongTag
syntax region strongTag start=/\([-{(<"[]\|\_^\|\s\)\zs\*/ end=/\*\ze\(\s\|\_$\|[]})>.,;:"-]\)/ contained

" Mark as 'semanitic emphasis' (italic) when surrounded by underscores
syntax region Emph matchgroup=EmphTag start=/\([-{(<"[]\|\_^\|\s\)\zs_\ze\S/ end=/\S\zs_\ze\(\s\|\_$\|[]})>.,;:"-]\)/ contains=EmphTag
syntax region EmphTag start=/\([-{(<"[]\|\_^\|\s\)\zs_/ end=/_\ze\(\s\|\_$\|[]})>.,;:"-]\)/ contained

" Mark as 'technical emphasis' (italic) when surrounded by slashes
syntax region techEmph matchgroup=techEmphTag start=/\([-{(<"[]\|\_^\|\s\)\zs\/\ze\S/ end=/\S\zs\/\ze\(\s\|\_$\|[]})>.,;:"-]\)/ contains=techEmphTag
syntax region techEmphTag start=/\([-{(<"[]\|\_^\|\s\)\zs\// end=/\/\ze\(\s\|\_$\|[]})>.,;:"-]\)/ contained

" Mark as 'literal' (monospaced) when surrounded by two pairs of single quotes
syntax region literal matchgroup=literalTag start=/\(\s\|\_^\)''\ze\S/ end=/\S\zs''\(\s\|\_$\)/ contains=literalTag
syntax region literalTag start=/\(\s\|\_^\)''/ end=/''\(\s\|\_$\)/ contained

" Highlight 'headings' when line begins with an excamation point
syntax region heading matchgroup=headingTag start=/^!\+\ze\s*\S\+/ end=/$/

" Highlight links, when surrounded by brackets & when preceding a link or URL 
" surrounded by brackets
syntax match LinkTag /\[[^][]\+\]/ contains=Link
syntax match Link /\[[^][]\+\]/hs=s+1,he=e-1 contained
syntax match Link /\zs\S\+\ze\[[^][]\+\]/

" Highlight URL's & their surrounding brackets
syntax match URLtag /\[\(http\|https\|ftp\|ftps\|gopher\|file\|nntp\|mailto\|news\):\/\/\S\+\]/ contains=URL
syntax match URL /\[\(http\|https\|ftp\|ftps\|gopher\|file\|nntp\|mailto\|news\):\/\/\S\+\]/hs=s+1,he=e-1 contained 
syntax match URL /\(\_^\|\s\)\(http\|https\|ftp\|ftps\|gopher\|file\|nntp\|mailto\|news\):\/\/\S\+/

" Highlight footnotes, surrounded by two double-bracket pairs
"syntax region footnote matchgroup=footnoteTag start=/\[\[\ze\( \|-\)\S/ end=/\S\( \|-\)\zs\]\]/ contains=footnoteTag
syntax match Norm /\S*\[\[\( \|-\)\S\+\( \|-\)\]\]/hs=s-1,he=e contains=footnoteTag
syntax match footnoteTag /\[\[\( \|-\)\S\+\( \|-\)\]\]/hs=s-1,he=e contained contains=footnote
syntax match footnote /\[\[\zs\( \|-\)\S\+\( \|-\)\ze\]\]/ contained


" Highlight 'enumerated list' tag `#' when it comes first on a line
syntax match enumerated /^\s*#\ze\s\+\S/

" Highlight 'itemized list' tag `*' or `-' when it comes first on a line
syntax match itemized /^\s*\(\*\|-\)\ze\s\+\S/

" Highlight arrow glyph generating sequences `->' and `<-'
syntax match arrow /\(\(^\| \)->\( \|$\)\)/
syntax match arrow /\(\(^\| \)<-\( \|$\)\)/

" highligh copyright & trademark symbol generating `(c)' and `(tm)'
syntax match sign /\(^\| \)(c) /
syntax match sign /(tm)/

" highlight the 'comments' tag (custom per JfM)
syntax region Comments start=/\(\_^\|\s\)\zs<#\s/ end=/\s#>\(\_$\|\s\)/
syntax region Comments start=/^\s*dnl/ end=/$/

" highlight the double-slash 'line break' tag
syntax match lineBreak /\/\/$/

" highlight the double-pipe 'columns' tag (for tables)
syntax match columns /||/

syntax match vsp /^\s*\\p\/\s*$/ contains=vspnum
syntax match vspnum /^\s*\\\zsp\ze\/\s*$/ contained

syntax match vsp /^\s*\\[1-9][0-9]*\/\s*$/ contains=vspnum
syntax match vspnum /^\s*\\\zs[1-9][0-9]*\ze\/\s*$/ contained

" highlight the 'section break' tag
syntax match sectBreak /^---*$/

" Preformatted blocks
syntax region preformat matchgroup=preformatTag start=/^{{{$/ end=/^}}}$/

" highlight the 'divid' tag, (makes '<div id="">' in html)
syntax match dividTag /^|[-A-Za-z0-9_.][-A-Za-z0-9_.]*|$/ contains=divid
syntax match divid /^|\zs[-A-Za-z0-9_.][-A-Za-z0-9_.]*\ze|$/ contained
syntax match dividTag /^|\^|$/ contains=divid
syntax match divid /^|\zs\^\ze|$/ contained

syntax match punctuation />>/
syntax match punctuation /<</

"highlighting for stx2any markup

hi def link     Norm            Normal
hi def link     Comments        Comment

hi def link     metaTitle       Identifier
hi def link     metaText        Statement

hi def link     wText           ModeMsg
hi def link     wTag            Comment
hi def link     wParen1         Comment
hi def link     wParen2         Comment

hi def link     strong          Special
hi def link     strongTag       Comment

hi def link     techEmph        Define
hi def link     techEmphTag     Comment

hi def link     Emph            Define
hi def link     EmphTag         Comment

hi def link     literal         Constant
hi def link     literalTag      Comment

hi def link     preformat       Constant
hi def link     preformatTag    Comment

hi def link     heading         Title
hi def link     headingTag      Identifier

hi def link     footnote        Statement
hi def link     footnoteTag     Comment

hi def link     URLtag          Nontext
hi def link     URL             Comment

hi def link     LinkTag         Nontext
hi def link     Link            Define

hi def link     enumerated      Define
hi def link     itemized        Special

hi def link     arrow           Special
hi def link     sign            Define

hi def link     vsp             Identifier
hi def link     vspnum          Statement 

hi def link     lineBreak       Identifier

hi def link     sectBreak       Identifier

hi def link     columns         Nontext

hi def link     tech            Special

hi def link     divid           Comment
hi def link     dividTag        Identifier

hi def link     punctuation     Special

let b:current_syntax = "stx"

