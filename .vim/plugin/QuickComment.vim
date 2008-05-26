" BlockComment2.vim
" Author: Simon Xu
" Version: 1.0
" License: GPL v2.0 
" 

"--------------------------------------------------
" Avoid multiple sourcing
"-------------------------------------------------- 
if exists( "loaded_block_comment" )
	finish
endif
let loaded_block_comment = 1


"--------------------------------------------------
" Key mappings
"-------------------------------------------------- 
noremap <silent> .c :call Comment()<CR>
noremap <silent> .C :call UnComment()<CR>


"--------------------------------------------------
" Set comment characters by filetype
"-------------------------------------------------- 
function! CommentStr()
	if &ft == "vim"
		let s:comment_strt = '"'
		let s:comment_mid0 = '" '
		let s:comment_mid1 = '"'
		let s:comment_stop = ' '
		let s:comment_bkup = 0
	elseif &ft == "c" || &ft == "css"
		let s:comment_strt = '/*'
		let s:comment_mid0 = '* '
		let s:comment_mid1 = '*'
		let s:comment_stop = '*/'
		let s:comment_bkup = 1
		let s:comment_strtbak = '/ *'
		let s:comment_stopbak = '* /'
	elseif &ft == "cpp" || &ft == "java" || &ft == "javascript" || &ft == "php"
		let s:comment_strt = '//'
		let s:comment_mid0 = '// '
		let s:comment_mid1 = '//'
		let s:comment_stop = ' '
		let s:comment_bkup = 0
	elseif &ft == "asm" || &ft == "lisp" || &ft == "scheme"
		let s:comment_strt = ';'
		let s:comment_mid0 = '; '
		let s:comment_mid1 = ';'
		let s:comment_stop = ' '
		let s:comment_bkup = 0
	elseif &ft == "vb"
		let s:comment_strt = '\''
		let s:comment_mid0 = '\' '
		let s:comment_mid1 = '\''
		let s:comment_stop = ' '
		let s:comment_bkup = 0
	elseif &ft == "html" || &ft == "xml" || &ft == "entity"
		let s:comment_strt = '<!--'
		let s:comment_mid0 = '! '
		let s:comment_mid1 = '!'
		let s:comment_stop = '-->'
		let s:comment_bkup = 1
		let s:comment_strtbak = '< !--'
		let s:comment_stopbak = '-- >'
	else
		let s:comment_strt = '#'
		let s:comment_mid0 = '# '
		let s:comment_mid1 = '#'
		let s:comment_stop = ' '
		let s:comment_bkup = 0
	endif
endfunction

"--------------------------------------------------
" Comment a block of code
"-------------------------------------------------- 
function! Comment(...) range
	" range variables
	if a:0 == 0
		let l:firstln = a:firstline
		let l:lastln = a:lastline
	elseif a:0 == 2
		let l:firstln = a:1
		let l:lastln = a:2
	else
		finish
	endif

	" get comment chars
	call CommentStr()
	" get tab indent level
	let l:indent = indent( l:firstln ) / &tabstop
	" loop to get padding str
	let l:pad = ""
	let l:i = 0
	while l:i < l:indent
		let l:pad = l:pad . "\t"
		let l:i = l:i + 1
	endwhile
	" loop for each line
	let l:block = 0
	let l:midline = l:firstln
	while l:midline <= l:lastln
		" get line
		let l:line = getline( l:midline )
		" check if padding matches
		if strpart( l:line, 0, l:indent ) == l:pad
			" start comment block
			" append comment between indent and code
			let l:line = strpart( l:line, l:indent )
			" handle comments within comments
			if s:comment_bkup == 1
				let l:line = substitute( l:line, escape( s:comment_strt, '\*^$.~[]' ), s:comment_strtbak, "g" )
				let l:line = substitute( l:line, escape( s:comment_stop, '\*^$.~[]' ), s:comment_stopbak, "g" )
			endif
			call setline( l:midline, l:pad . s:comment_mid0 . l:line )
		" else end block
		let l:midline = l:midline + 1
		endif
	endwhile
	" end block
	" return to first line of comment
	execute l:firstln
endfunction

"--------------------------------------------------
" Uncomment a block of code
"-------------------------------------------------- 
function! UnComment(...) range
	if a:0 == 0
		" range variables
		let l:firstln = a:firstline
		let l:lastln = a:lastline
	elseif a:0 == 2
		let l:firstln = a:1
		let l:lastln = a:2
	else
		finish
	endif

	" get comment chars
	call CommentStr()
	" get length of comment string
	let l:clen = strlen( s:comment_mid0 )
	" loop for each line
	let l:midline = l:firstln
	while l:midline <= l:lastln
		" get indent level - process indent for each line instead of by block
		let l:indent = indent( l:midline ) / &tabstop
		let l:line = getline( l:midline )
		" commented code line - remove comment
		if strpart( l:line, l:indent, l:clen ) == s:comment_mid0
			let l:pad = strpart( l:line, 0, l:indent )
			let l:line = strpart( l:line, l:indent + l:clen )
			" handle comments within comments
			if s:comment_bkup == 1
				let l:line = substitute( l:line, escape( s:comment_strtbak, '\*^$.~[]' ), s:comment_strt, "g" )
				let l:line = substitute( l:line, escape( s:comment_stopbak, '\*^$.~[]' ), s:comment_stop, "g" )
			endif
			call setline( l:midline, l:pad . l:line )
		endif
		let l:midline = l:midline + 1
	endwhile
endfunction

command! -range -nargs=* C call Comment(<line1>, <line2>)
command! -range -nargs=* NC call UnComment(<line1>, <line2>)
