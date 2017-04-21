" Vim indent file
" Language:		NyAsm
" Maintainer:		CaiJinJu <517402802@qq.com>
" Original Author:	CaiJinJu <leagueway.com.cn>
" Last Change:		2017-04-11

" Only load this indent file when no other was loaded.

"if exists("b:did_indent")
"  finish
"endif
"let b:did_indent = 1

setlocal indentexpr=NyAsmGetIndent(v:lnum)
"setlocal indentkeys+==ENDIF(,ENDFOREACH(,ENDMACRO(,ELSE(,ELSEIF(,ENDWHILE(
setlocal indentkeys=break,else,endfor,endif,ends,endsw,endw,until,endc,endm,<:>
setlocal tabstop=4
"setlocal softtabstop=4
setlocal shiftwidth=4

" Only define the function once.
"if exists("*NyAsmGetIndent")
"  finish
"endif
"let s:keepcpo= &cpo
"set cpo&vim

fun! NyAsmGetIndent(lnum)
  let this_line = getline(a:lnum)

  " Find a non-blank line above the current line.
  let lnum = a:lnum
  let lnum = prevnonblank(lnum - 1)
  let previous_line = getline(lnum)

  " Hit the start of the file, use zero indent.
  if lnum == 0
    return 0
  endif

  let ind = indent(lnum)

"  let or = '\|'
  " Regular expressions used by line indentation function.
  let nyasm_comment_regex = ';.*'
"  let cmake_regex_identifier = '[A-Za-z][A-Za-z0-9_]*'
"  let cmake_regex_quoted = '"\([^"\\]\|\\.\)*"'
"  let cmake_regex_arguments = '\(' . cmake_regex_quoted .
"                    \       or . '\$(' . cmake_regex_identifier . ')' .
"                    \       or . '[^()\\#"]' . or . '\\.' . '\)*'

"  let cmake_indent_comment_line = '^\s*' . cmake_regex_comment
"  let nyasm_indent_blank_regex = '^\s*$'
"  let cmake_indent_open_regex = '^\s*' . cmake_regex_identifier .
"                    \           '\s*(' . cmake_regex_arguments .
"                    \           '\(' . cmake_regex_comment . '\)\?$'

"  let cmake_indent_close_regex = '^' . cmake_regex_arguments .
"                    \            ')\s*' .
"                    \            '\(' . cmake_regex_comment . '\)\?$'

" 正则匹配
let nyasm_identifier_regex = '[A-Za-z@_][A-Za-z0-9_@]*'
let nyasm_indent_begin_regex = '^\s*\(case\|default\|else\|for\|if\|ifdef\|ifndef\|repeat\|switch\|while\|local\)\>'
let nyasm_indent_end_regex = '^\s*\(break\|else\|endfor\|endif\|ends\|endsw\|endw\|until\|endc\|endm\)\>'

" 行匹配
let nyasm_indent_label_line= '^\s*' . nyasm_identifier_regex . '\s*:'
let nyasm_indent_macro_line='^\s*' . nyasm_identifier_regex . '\s\+macro\>'



  " Add
"  if previous_line =~? cmake_indent_comment_line " Handle comments
"    let ind = ind
"  else
"    if previous_line =~? cmake_indent_begin_regex
"      let ind = ind + &sw
"    endif
"   if previous_line =~? cmake_indent_open_regex
"     let ind = ind + &sw
"   endif
"  endif

"  if previous_line =~ '^\s*\w\+\s*:'
"      if previous_line !~? ';.*:'
"        return ind + &sw
"      endif
"  endif

  if previous_line =~ nyasm_indent_label_line
	let ind += &sw
  endif

  if previous_line =~ nyasm_indent_macro_line
	let ind += &sw
  endif

  if previous_line =~? nyasm_indent_begin_regex
    let ind = ind + &sw
  endif

"  if previous_line =~? ':'
"    if previous_line !~? nyasm_comment_regex . ':'
"      let ind = ind + &sw
"  endif

  " Subtract
  if this_line =~? nyasm_indent_end_regex
    let ind = ind - &sw
  endif

  if this_line =~? nyasm_indent_label_line
    let ind = ind - &sw
  endif

"  if previous_line =~? cmake_indent_close_regex
"    let ind = ind - &sw
"  endif

  return ind
endfun

"let &cpo = s:keepcpo
"unlet s:keepcpo
