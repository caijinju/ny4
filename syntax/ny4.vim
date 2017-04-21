" Vim syntax file
" Language:	NY4 Assembler
" Maintainer:	caijinju <517402802@qq.com>
" Last Change:	2017 03 30


" quit when a syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

" 查看当前语法高亮可使用 :syntax
" 查看当前语法某项高亮可使用 :syntax list {groupName}
" 清理语法
"syntax clear


" 忽略关键字大小写
syn case ignore

""""""""""""""""""""""""""""""""""""""""""""""""""
" add by cjj
""""""""""""""""""""""""""""""""""""""""""""""""""
" NY4 指令
" Arithmetic Instructions
syn keyword ariIns incm decm addm xorm andm orm mvam mvma mvrm mvmr mvlr addl xorl andl orl mvla rora rola rstc setc inca deca
" Conditional Instructions
syn keyword conIns cpam cnam cpal cnal cpab cpcz cncz cpzz cnzz
" Data Audio Instructions
syn keyword audIns ldtm rbvp stop play
" Other Instructions
syn keyword othIns mpg rbro jmp call ldpc rbpc halt cwdt nop

syn keyword ny4regD rpt0 rpt1 rpt2 rpt3 rpt4 rod1 rod2 fd bt sfr pa paio pb pbio

"syn keyword ny4regT vol pflg int mix aud pa pb pc pd pe pf


" NYASM 指令
" 控制型虚拟指令
syn match contInst "\#define"
syn match contInst "\#includata"
syn match contInst "\#include"
syn match contInst "\#undefine"
syn keyword contInst constant end equ error list messg org lines newpage radix subtitle title variable
" 条件式组译指令
syn keyword condInst break case continue default else endfor endif ends endsw endw for if ifdef ifndef repeat switch until wihle
" 资料
syn keyword dataInst cblock  data db dn dt dw endc
"syn match dataInst "high[01]"
"syn match dataInst "mid[01]"
"syn match dataInst "low[01]"
syn keyword dataInst high high0 high1 mid mid0 mid1 low low0 low1
" 巨集
syn keyword specInst endm exitm expand local macro maxmacrodepth noexpand


""""""""""""""""""""""""""""""""""""""""""""""""""

" storage types
"syn match asmType "\.long"
"syn match asmType "\.ascii"
"syn match asmType "\.asciz"
"syn match asmType "\.byte"
"syn match asmType "\.double"
"syn match asmType "\.float"
"syn match asmType "\.hword"
"syn match asmType "\.int"
"syn match asmType "\.octa"
"syn match asmType "\.quad"
"syn match asmType "\.short"
"syn match asmType "\.single"
"syn match asmType "\.space"
"syn match asmType "\.string"
"syn match asmType "\.word"

syn match nyasmLabel		/[A-Za-z_@][A-Za-z0-9_@]*\s*:/me=e-1
"syn match asmIdentifier		"[a-z_@][a-z0-9_@]*"

" Various #'s as defined by GAS ref manual sec 3.6.2.1
" Technically, the first decNumber def is actually octal,
" since the value of 0-7 octal is the same as 0-7 decimal,
" I (Kevin) prefer to map it as decimal:
"syn match decNumber		"0\+[1-7]\=[\t\n$,; ]\>"
"syn match decNumber		"\<[1-9]\d*\>"
"syn match octNumber		"\<0[0-7][0-7]\+\>"
"syn match hexNumber		"\<0[xX][0-9a-fA-F]\+\>"
"syn match binNumber		"\<0[bB][0-1]*\>"

syn match decNumber		"\<[dD]'[1-9]\d*'\>"
syn match decNumber		"\<[1-9]\d*\>"
syn match decNumber		"\<\d\+\>"
syn match hexNumber		"\<0[xX][0-9a-fA-F]\+\>"
syn match hexNumber		"\<[hH]'[0-9a-fA-F]\+'\>"
syn match hexNumber		"\<[0-9a-fA-F]\+[hH]\>"
syn match octNumber		"\<[oO]'[0-7][0-7]\+'\>"
syn match binNumber		"\<[bB]'[0-1]\+'\>"

syn keyword asmTodo		contained TODO


" GAS supports one type of multi line comments:
"syn region asmComment		start="/\*" end="\*/" contains=asmTodo

" GAS (undocumentedly?) supports C++ style comments. Unlike in C/C++ however,
" a backslash ending a C++ style comment does not extend the comment to the
" next line (hence the syntax region does not define 'skip="\\$"')
"syn region asmComment		start="//" end="$" keepend contains=asmTodo

" Line comment characters depend on the target architecture and command line
" options and some comments may double as logical line number directives or
" preprocessor commands. This situation is described at
" http://sourceware.org/binutils/docs-2.22/as/Comments.html
" Some line comment characters have other meanings for other targets. For
" example, .type directives may use the `@' character which is also an ARM
" comment marker.
" As a compromise to accommodate what I arbitrarily assume to be the most
" frequently used features of the most popular architectures (and also the
" non-GNU assembly languages that use this syntax file because their asm files
" are also named *.asm), the following are used as line comment characters:
syn match asmComment		";.*" contains=asmTodo

" Side effects of this include:
" - When `;' is used to separate statements on the same line (many targets
"   support this), all statements except the first get highlighted as
"   comments. As a remedy, remove `;' from the above.
" - ARM comments are not highlighted correctly. For ARM, uncomment the
"   following two lines and comment the one above.
"syn match asmComment		"@.*" contains=asmTodo
"syn match asmComment		"^#.*" contains=asmTodo

" Advanced users of specific architectures will probably want to change the
" comment highlighting or use a specific, more comprehensive syntax file.

"syn match asmInclude		"\.include"
"syn match asmCond		"\.if"
"syn match asmCond		"\.else"
"syn match asmCond		"\.endif"
"syn match asmMacro		"\.macro"
"syn match asmMacro		"\.endm"

" Assembler directives start with a '.' and may contain upper case (e.g.,
" .ABORT), numbers (e.g., .p2align), dash (e.g., .app-file) and underscore in
" CFI directives (e.g., .cfi_startproc). This will also match labels starting
" with '.', including the GCC auto-generated '.L' labels.
"syn match asmDirective		"\.[A-Za-z][0-9A-Za-z-_]*"


syn case match

" Define the default highlighting.
" Only when an item doesn't have highlighting yet

" The default methods for highlighting.  Can be overridden later
"hi def link asmSection	Special
hi def link nyasmLabel	Question
hi def link asmComment	Comment
hi def link asmTodo	Todo
"hi def link asmDirective	Statement

"hi def link asmInclude	Include
"hi def link asmCond	PreCondit
"hi def link asmMacro	Macro

hi def link hexNumber	Number
hi def link decNumber	Number
hi def link octNumber	Number
hi def link binNumber	Number

"hi def link asmIdentifier	Identifier
"hi def link asmType	Type

""""""""""""""""""""""""""""""""""""""""""""""""""
" add by cjj
""""""""""""""""""""""""""""""""""""""""""""""""""
hi def link ariIns	Directory
hi def link conIns	Directory
hi def link audIns	Directory
hi def link othIns	Directory
"hi def link conIns	SpecialKey
"hi def link audIns	Statement
"hi def link othIns	ModeMsg

hi def link contInst	PreCondit
hi def link condInst	PreCondit
hi def link dataInst	PreCondit
hi def link specInst	PreCondit
"hi def link condInst	MoreMsg
"hi def link dataInst	Type
"hi def link specInst	Special

hi def link ny4regD	SpecialKey
"hi def link ny4regT	SpecialKey

""""""""""""""""""""""""""""""""""""""""""""""""""

let b:current_syntax = "ny4"

let &cpo = s:cpo_save
unlet s:cpo_save

" vim: ts=8
